# ---------------------------------------------------------------------------
# Trivadis AG, Infrastructure Managed Services
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ---------------------------------------------------------------------------
# Name.......: vcn.tf
# Author.....: Martin Berger (mbg) martin.berger@trivadis.com
# Editor.....: Martin Berger
# Date.......: 2021.02.22
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
  version = "1.0.3"
  # Use the latest version, if there is one newer than "1.0.3"
  # insert the 4 required variables here

  # Required
  compartment_id = oci_identity_compartment.tf-compartment.id
  region         = var.region
  vcn_name       = var.vcn_name
  vcn_dns_label  = var.vcn_dns_label

  # Optional
  vcn_cidr = var.vcn_cidr
}

# public subnet----------------------------------------------------------------
resource "oci_core_subnet" "vcn-public-subnet" {

  # Required
  compartment_id = oci_identity_compartment.tf-compartment.id
  vcn_id         = module.vcn.vcn_id
  cidr_block     = var.vcn_public_cidr_block

  # Optional
  route_table_id    = oci_core_route_table.public_route_table.id
  security_list_ids = [oci_core_security_list.public-security-list.id]
  display_name      = "sn-regional-public-01"
}


# private subnet--------------------------------------------------------------
resource "oci_core_subnet" "vcn-private-subnet" {

  # Required
  compartment_id = oci_identity_compartment.tf-compartment.id
  vcn_id         = module.vcn.vcn_id
  cidr_block     = var.vcn_private_cidr_block

  # Optional
  # Caution: For the route table id, use module.vcn.nat_route_id.
  # Do not use module.vcn.nat_gateway_id, because it is the OCID for the gateway and not the route table.
  route_table_id    = oci_core_route_table.private_route_table.id
  security_list_ids = [oci_core_security_list.private-security-list.id]
  display_name      = "sn-regional-private-01"
}

# public route table ----------------------------------------------------------
resource "oci_core_route_table" "public_route_table" {
  display_name   = var.public_route_table_display_name
  compartment_id = oci_identity_compartment.tf-compartment.id
  vcn_id         = module.vcn.vcn_id

  route_rules {
    cidr_block        = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.internet_gateway.id
  }

}

# private route table ----------------------------------------------------------
resource "oci_core_route_table" "private_route_table" {
  display_name   = var.private_route_table_display_name
  compartment_id = oci_identity_compartment.tf-compartment.id
  vcn_id         = module.vcn.vcn_id

  route_rules {
    cidr_block        = "0.0.0.0/0"
    network_entity_id = oci_core_nat_gateway.nat_gateway.id
  }

}


# public security list ----------------------------------------------------------
resource "oci_core_security_list" "public-security-list" {

  # Required
  compartment_id = oci_identity_compartment.tf-compartment.id
  vcn_id         = module.vcn.vcn_id

  # Optional
  display_name = "sl-public-01"

  egress_security_rules {
    stateless        = false
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    protocol         = "all"
  }

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
  ingress_security_rules {
    stateless   = false
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    # Get protocol numbers from https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml ICMP is 1  
    protocol = "1"

    # For ICMP type and code see: https://www.iana.org/assignments/icmp-parameters/icmp-parameters.xhtml
    icmp_options {
      type = 3
      code = 4
    }
  }

  ingress_security_rules {
    stateless   = false
    source      = "10.0.0.0/16"
    source_type = "CIDR_BLOCK"
    # Get protocol numbers from https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml ICMP is 1  
    protocol = "1"

    # For ICMP type and code see: https://www.iana.org/assignments/icmp-parameters/icmp-parameters.xhtml
    icmp_options {
      type = 3
    }
  }

  ingress_security_rules {
    stateless   = false
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    # Get protocol numbers from https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml TCP is 6
    protocol = "6"
    tcp_options {
      min = 943
      max = 943
    }
  }

  ingress_security_rules {
    stateless   = false
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    # Get protocol numbers from https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml TCP is 6
    protocol = "6"
    tcp_options {
      min = 945
      max = 945
    }
  }

  ingress_security_rules {
    stateless   = false
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    # Get protocol numbers from https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml TCP is 6
    protocol = "6"
    tcp_options {
      min = 443
      max = 443
    }
  }


  ingress_security_rules {
    stateless   = false
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    # Get protocol numbers from https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml TCP is 6
    protocol = "17"
    udp_options {
      min = 1194
      max = 1194
    }
  }

}


# private security list ----------------------------------------------------------
resource "oci_core_security_list" "private-security-list" {

  # Required
  compartment_id = oci_identity_compartment.tf-compartment.id
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
  compartment_id = oci_identity_compartment.tf-compartment.id
  vcn_id         = module.vcn.vcn_id

  #Optional
  display_name = var.nat_gateway_display_name
}


# internet gateway ------------------------------------------------------------
resource "oci_core_internet_gateway" "internet_gateway" {
  #Required
  compartment_id = oci_identity_compartment.tf-compartment.id
  vcn_id         = module.vcn.vcn_id

  #Optional
  display_name = var.internet_gateway_display_name
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
  compartment_id = oci_identity_compartment.tf-compartment.id
  display_name   = var.service_gateway_display_name

  services {
    service_id = lookup(data.oci_core_services.all_oci_services[0].services[0], "id")
  }

  vcn_id = module.vcn.vcn_id
  # route_table_id = oci_core_route_table.private_route_table.id

  count = var.service_gateway_enabled == true ? 1 : 0
}

# --- EOF -------------------------------------------------------------------