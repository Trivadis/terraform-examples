# ---------------------------------------------------------------------------
# Trivadis AG, Infrastructure Managed Services
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ---------------------------------------------------------------------------
# Name.......: main.tf
# Author.....: Martin Berger (mbg) martin.berger@trivadis.com
# Editor.....: Martin Berger
# Date.......: 2021.02.11
# Revision...: 
# Purpose....: Create compartment and verify availabilty domains.
# Notes......: --
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ---------------------------------------------------------------------------

# create compartment --------------------------------------------------------
resource "oci_identity_compartment" "tf-compartment" {
  # Required
  compartment_id = var.compartment_master_ocid
  description    = var.compartment_description
  name           = var.compartment_name
  enable_delete  = true
}

# verify availability domain -------------------------------------------------
data "oci_identity_availability_domains" "ads" {
  compartment_id = oci_identity_compartment.tf-compartment.id
}