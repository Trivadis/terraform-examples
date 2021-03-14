# ---------------------------------------------------------------------------
# Trivadis AG, Infrastructure Managed Services
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ---------------------------------------------------------------------------
# Name.......: outputs.tf
# Author.....: Martin Berger (mbg) martin.berger@trivadis.com
# Editor.....: Martin Berger
# Date.......: 2021.03.14
# Revision...: 
# Purpose....: Output definition for this terraform configuration.
# Notes......: --
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ---------------------------------------------------------------------------

# General -------------------------------------------------------------------

# compartment name
output "new-compartment-name" {
  value = oci_identity_compartment.tf-compartment.name
}

# list of availability domains
output "all-availability-domains-in-your-tenancy" {
  value = data.oci_identity_availability_domains.ads.availability_domains
}

# Compute -------------------------------------------------------------------

# public IP compute instance
output "public-ip-for-compute-instance" {
  value = oci_core_instance.compute_instance.public_ip
}
# # private subnet
# output "private-subnet-name" {
#   value = oci_core_subnet.vcn-private-subnet.display_name
# }

# # public subnet
# output "public-subnet-name" {
#   value = oci_core_subnet.vcn-public-subnet.display_name
# }


