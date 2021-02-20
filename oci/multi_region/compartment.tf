# ---------------------------------------------------------------------------
# Trivadis AG, Infrastructure Managed Services
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ---------------------------------------------------------------------------
# Name.......: compartment.tf
# Author.....: Stefan Oehrli (oes) stefan.oehrli@trivadis.com
# Editor.....: Stefan Oehrli
# Date.......: 2020.10.14
# Revision...: 
# Purpose....: Provider specific configuration for this terraform configuration.
# Notes......: --
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ---------------------------------------------------------------------------
# create the compartment in the Home region
resource "oci_identity_compartment" "compartment" {
  provider       = oci.home
  name           = var.resource_name
  description    = "Example compartment ${var.resource_name} created by terraform"
  compartment_id = var.tenancy_ocid
  # true will cause this compartment to be deleted when running `terrafrom destroy`
  enable_delete = true
}
# --- EOF -------------------------------------------------------------------