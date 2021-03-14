# ------------------------------------------------------------------------------
# Trivadis AG, Infrastructure Managed Services
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ------------------------------------------------------------------------------
# Name.......: compute.tf
# Author.....: Martin Berger (mbg) martin.berger@trivadis.com
# Editor.....: Martin Berger
# Date.......: 2021.03.13
# Revision...: 
# Purpose....: Create compute instance, setup ansible and install httpd service
# Notes......: Replace SSH Keys first
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ------------------------------------------------------------------------------

# datasource to get the latest image ID
data "oci_core_images" "oracle_images" {
  compartment_id           = oci_identity_compartment.tf-compartment.id
  operating_system         = var.compute_os
  operating_system_version = var.compute_os_version
  shape                    = var.compute_shape
  sort_by                  = "TIMECREATED"
}

# Define locals ----------------------------------------------------------------

locals {
  compute_image_id             = var.compute_image_id == "OEL" ? data.oci_core_images.oracle_images.images.0.id : var.compute_image_id
  ssh_public_key_path          = var.ssh_public_key_path == "" ? "${path.module}/etc/default_authorized_keys" : var.ssh_public_key_path
  bootstrap_playbook_path      = var.bootstrap_playbook_path == "" ? "${path.root}/ansible/apache-install.yml" : var.bootstrap_playbook_path
  ssh_authorized_keys          = var.ssh_public_key != "" ? var.ssh_public_key : file(local.ssh_public_key_path)
  bootstrap_cloudinit_template = var.bootstrap_cloudinit_template == "" ? "${path.root}/cloudinit/basic_host.yaml" : var.bootstrap_cloudinit_template
  bootstrap_cloudinit = base64gzip(templatefile(local.bootstrap_cloudinit_template, {
    authorized_keys  = base64gzip(local.ssh_authorized_keys)
    ansible_playbook = base64gzip(file(local.bootstrap_playbook_path))
  }))
}
# Create Application Server ----------------------------------------------------

# Oracle Linux instance according image OCID - PUblic Subnet
resource "oci_core_instance" "compute_instance" {
  # Required
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = oci_identity_compartment.tf-compartment.id
  shape               = var.compute_shape
  source_details {
    source_type = "image"
    source_id   = local.compute_image_id
  }


  # Optional
  display_name = var.compute_display_name
  create_vnic_details {
    assign_public_ip = true
    subnet_id        = oci_core_subnet.vcn-public-subnet.id
  }

  metadata = {
    ssh_authorized_keys = local.ssh_authorized_keys
    user_data           = local.bootstrap_cloudinit
  }

  # Just in case somebody wants to user a E3.Flex shape
  shape_config {
    memory_in_gbs = var.compute_memory_in_gbs
    ocpus         = var.compute_ocpus
  }

  preserve_boot_volume = false

}

# --- EOF -------------------------------------------------------------------
