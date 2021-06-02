# ---------------------------------------------------------------------------
# Trivadis AG, Infrastructure Managed Services
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ---------------------------------------------------------------------------
# Name.......: vcn.tf
# Author.....: Martin Berger (mbg) martin.berger@trivadis.com
# Editor.....: Martin Berger
# Date.......: 2021.02.11
# Revision...: 
# Purpose....: Create VCN, subnet, route table and security list.
# Notes......: --
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ---------------------------------------------------------------------------

# vcn -----------------------------------------------------------------------
module "vcn" {
  source  = "oracle-terraform-modules/vcn/oci"
  version = "2.2.0"
  # Use the latest version, if there is one newer than "1.0.3"
  # insert the 4 required variables here

  # Required
  compartment_id = var.compartment_ocid
  vcn_name       = var.vcn_name
  vcn_dns_label  = var.vcn_dns_label
  region         = var.region

  # Optional
  vcn_cidr = var.vcn_cidr_block
}

# private subnet 1 ----------------------------------------------------------------
resource "oci_core_subnet" "vcn_private_subnet_1" {

  # Required
  compartment_id = var.compartment_ocid
  vcn_id         = module.vcn.vcn_id
  cidr_block     = var.vcn_subnet_cidr_block_private_1


  # Optional
  route_table_id    = oci_core_route_table.private_route_table.id
  security_list_ids = [oci_core_security_list.private-security-list.id]
  display_name      = var.vcn_subnet_name_private_1
}

# private subnet 2 ----------------------------------------------------------------
resource "oci_core_subnet" "vcn_private_subnet_2" {

  # Required
  compartment_id = var.compartment_ocid
  vcn_id         = module.vcn.vcn_id
  cidr_block     = var.vcn_subnet_cidr_block_private_2


  # Optional
  route_table_id    = oci_core_route_table.private_route_table.id
  security_list_ids = [oci_core_security_list.private-security-list.id]
  display_name      = var.vcn_subnet_name_private_2
}


# private route table ----------------------------------------------------------
resource "oci_core_route_table" "private_route_table" {
  display_name   = var.private_route_table_display_name
  compartment_id = var.compartment_ocid
  vcn_id         = module.vcn.vcn_id

  route_rules {
    cidr_block        = "0.0.0.0/0"
    network_entity_id = oci_core_nat_gateway.nat_gateway.id
  }

}


# private security list ----------------------------------------------------------
resource "oci_core_security_list" "private-security-list" {

  # Required
  compartment_id = var.compartment_ocid
  vcn_id         = module.vcn.vcn_id

  # Optional
  display_name = "sl-private-01"

  ingress_security_rules {
    stateless   = false
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    # Get protocol numbers from https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml TCP is 6
    protocol = "6"
    tcp_options {
      min = 22
      max = 22
    }
  }

  egress_security_rules {
    stateless        = false
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol         = "all"
  }
}


# nat gateway ---------------------------------------------------------------
resource "oci_core_nat_gateway" "nat_gateway" {
  #Required
  compartment_id = var.compartment_ocid
  vcn_id         = module.vcn.vcn_id

  #Optional
  display_name = var.nat_gateway_display_name
}


# service  gateway ---------------------------------------------------------------
data "oci_core_services" "all_oci_services" {
  filter {
    name   = "name"
    values = ["All .* Services In Oracle Services Network"]
    regex  = true
  }
  count = var.service_gateway_enabled == true ? 1 : 0
}

resource "oci_core_service_gateway" "service_gateway" {
  compartment_id = var.compartment_ocid
  display_name   = var.service_gateway_display_name

  services {
    service_id = lookup(data.oci_core_services.all_oci_services[0].services[0], "id")
  }

  vcn_id = module.vcn.vcn_id
  # route_table_id = oci_core_route_table.private_route_table.id

  count = var.service_gateway_enabled == true ? 1 : 0
}

# --- EOF -------------------------------------------------------------------
