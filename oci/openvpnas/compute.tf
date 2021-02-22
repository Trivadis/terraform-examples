# ---------------------------------------------------------------------------
# Trivadis AG, Infrastructure Managed Services
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ---------------------------------------------------------------------------
# Name.......: compute.tf
# Author.....: Martin Berger (mbg) martin.berger@trivadis.com
# Editor.....: Martin Berger
# Date.......: 2021.02.11
# Revision...: 
# Purpose....: Create compute instances.
# Notes......: --
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ---------------------------------------------------------------------------


# Create Application Server ----------------------------------------------------

# Oracle Linux instance according image OCID
resource "oci_core_instance" "compute_instance" {
  # Required
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = oci_identity_compartment.tf-compartment.id
  shape               = var.compute_shape
  source_details {
    source_id   = var.linux_image_ocid[var.region]
    source_type = "image"
  }

  # Optional
  display_name = var.compute_display_name
  create_vnic_details {
    assign_public_ip = false
    subnet_id        = oci_core_subnet.vcn-private-subnet.id
  }
  metadata = {
    ssh_authorized_keys = file(var.compute_ssh_authorized_keys)
  }
  preserve_boot_volume = false

}

# Create OpenVPN Access Server ----------------------------------------------------

# marketplace subscription - Local variables pointing to the Marketplace catalog resource
locals {
  mp_listing_id               = var.mp_listing_id
  mp_listing_resource_id      = var.mp_listing_resource_id
  mp_listing_resource_version = var.mp_listing_resource_version
}

# get image agreement
resource "oci_core_app_catalog_listing_resource_version_agreement" "mp_image_agreement" {
  #  count = var.use_marketplace_image ? 1 : 0

  listing_id               = local.mp_listing_id
  listing_resource_version = local.mp_listing_resource_version
}

# accept terms and subscribe to the image, placing the image in a particular compartment
resource "oci_core_app_catalog_subscription" "mp_image_subscription" {
  #  count                    = var.use_marketplace_image ? 1 : 0
  compartment_id           = oci_identity_compartment.tf-compartment.id
  eula_link                = oci_core_app_catalog_listing_resource_version_agreement.mp_image_agreement.eula_link
  listing_id               = oci_core_app_catalog_listing_resource_version_agreement.mp_image_agreement.listing_id
  listing_resource_version = oci_core_app_catalog_listing_resource_version_agreement.mp_image_agreement.listing_resource_version
  oracle_terms_of_use_link = oci_core_app_catalog_listing_resource_version_agreement.mp_image_agreement.oracle_terms_of_use_link
  signature                = oci_core_app_catalog_listing_resource_version_agreement.mp_image_agreement.signature
  time_retrieved           = oci_core_app_catalog_listing_resource_version_agreement.mp_image_agreement.time_retrieved

  timeouts {
    create = "20m"
  }
}

# gets the partner image subscription
data "oci_core_app_catalog_subscriptions" "mp_image_subscription" {
  #Required
  compartment_id = oci_identity_compartment.tf-compartment.id

  #Optional
  listing_id = local.mp_listing_id

  filter {
    name   = "listing_resource_version"
    values = [local.mp_listing_resource_version]
  }
}

# bootstrap data source
data "template_file" "bootstrap" {
  template = file("./userdata/bootstrap.tpl")

  vars = {
    password          = var.openvpn_admin_password
    as_activation_key = var.openvpn_activation_key
    admin_username    = var.openvpn_admin_username
  }
}

# define availability domain
data "oci_identity_availability_domain" "ad" {
  compartment_id = var.tenancy_ocid
  ad_number      = 1
}

# creates an instance (without assigning a public IP to the primary private IP on the VNIC)
resource "oci_core_instance" "as_instance" {
  availability_domain = data.oci_identity_availability_domain.ad.name
  compartment_id      = oci_identity_compartment.tf-compartment.id
  display_name        = var.openvpn_display_name
  shape               = var.compute_shape

  source_details {
    source_type = "image"
    source_id   = local.mp_listing_resource_id
  }

  create_vnic_details {
    assign_public_ip       = false
    display_name           = "asPrimaryVnic"
    subnet_id              = oci_core_subnet.vcn-public-subnet.id
    skip_source_dest_check = true
  }

  metadata = {
    ssh_authorized_keys = file(var.compute_ssh_authorized_keys)
    user_data           = base64encode(data.template_file.bootstrap.rendered)
  }
  timeouts {
    create = "60m"
  }
}


# gets a list of VNIC attachments on the instance
data "oci_core_vnic_attachments" "instance_vnics" {
  compartment_id      = oci_identity_compartment.tf-compartment.id
  availability_domain = data.oci_identity_availability_domain.ad.name
  instance_id         = oci_core_instance.as_instance.id
}

# gets the OCID of the first VNIC
data "oci_core_vnic" "instance_vnic1" {
  vnic_id = lookup(data.oci_core_vnic_attachments.instance_vnics.vnic_attachments[0], "vnic_id")
}


# gets a list of private IPs on the first VNIC
data "oci_core_private_ips" "private_ips1" {
  vnic_id = data.oci_core_vnic.instance_vnic1.id
}

# create 1 reserved public IP and associate with private ip:
resource "oci_core_public_ip" "reserved_public_ip_assigned" {
  compartment_id = oci_identity_compartment.tf-compartment.id
  display_name   = "asPublicIPAssigned"
  lifetime       = "RESERVED"
  private_ip_id  = lookup(data.oci_core_private_ips.private_ips1.private_ips[0], "id")
}

# --- EOF -------------------------------------------------------------------
