# ---------------------------------------------------------------------------
# Trivadis AG, Infrastructure Managed Services
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ---------------------------------------------------------------------------
# Name.......: outputs.tf
# Author.....: Martin Berger (mbg) martin.berger@trivadis.com
# Editor.....: Martin Berger
# Date.......: 2021.02.22
# Revision...: 
# Purpose....: Output definition for this terraform configuration.
# Notes......: --
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ---------------------------------------------------------------------------

# General -------------------------------------------------------------------

# compartment name
output "compartment-name" {
  value = oci_identity_compartment.tf-compartment.name
}

# compartment id
output "compartment-OCID" {
  value = oci_identity_compartment.tf-compartment.id
}

# list of availability domains
output "all-availability-domains-in-your-tenancy" {
  value = data.oci_identity_availability_domains.ads.availability_domains
}

# Compute -------------------------------------------------------------------

# private IP compute instance
output "private-ip-for-compute-instance" {
  value = oci_core_instance.compute_instance.private_ip
}


# VCN -----------------------------------------------------------------------

# vcn_ocid
output "vcn_id" {
  description = "OCID of the VCN that is created"
  value       = module.vcn.vcn_id
}

# private security list
output "private-security-list-name" {
  value = oci_core_security_list.private-security-list.display_name
}
output "private-security-list-OCID" {
  value = oci_core_security_list.private-security-list.id
}

# public security list
output "public-security-list-name" {
  value = oci_core_security_list.public-security-list.display_name
}
output "public-security-list-OCID" {
  value = oci_core_security_list.public-security-list.id
}

# private subnet
output "private-subnet-name" {
  value = oci_core_subnet.vcn-private-subnet.display_name
}
output "private-subnet-OCID" {
  value = oci_core_subnet.vcn-private-subnet.id
}

# public subnet
output "public-subnet-name" {
  value = oci_core_subnet.vcn-public-subnet.display_name
}
output "public-subnet-OCID" {
  value = oci_core_subnet.vcn-public-subnet.id
}


# OpenVPN -------------------------------------------------------------

# public URL
output "openvpnas_instance_public_url" {
  value = format("https://%s/admin", oci_core_public_ip.reserved_public_ip_assigned.ip_address)
}

# admin username
output "admin_password" {
  value = var.openvpn_admin_password
}

# admin password
output "admin_username" {
  value = var.openvpn_admin_username
}