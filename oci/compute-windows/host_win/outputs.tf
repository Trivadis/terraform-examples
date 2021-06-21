# ---------------------------------------------------------------------------
# Trivadis AG, Infrastructure Managed Services
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ---------------------------------------------------------------------------
# Name.......: outputs.tf
# Author.....: Stefan Oehrli (oes) stefan.oehrli@trivadis.com
# Editor.....: Stefan Oehrli
# Date.......: 2021.06.04
# Revision...: 
# Purpose....: Output for the terraform module tvdlab compute.
# Notes......: -- 
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ---------------------------------------------------------------------------

# display public IPs
output "id" {
  description = "OCID of the instances."
  value       = oci_core_instance.compute.*.id
}

output "name" {
  description = "The hostname for VNIC's primary private IP of the instances."
  value       = oci_core_instance.compute.*.hostname_label
}

output "public_ip" {
  description = "The public IP address of the instances."
  value       = oci_core_instance.compute.*.public_ip
}

output "private_ip" {
  description = "The private IP address of the instances."
  value       = oci_core_instance.compute.*.private_ip
}

# --- EOF -------------------------------------------------------------------
