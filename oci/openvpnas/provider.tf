# ---------------------------------------------------------------------------
# Trivadis AG, Infrastructure Managed Services
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ---------------------------------------------------------------------------
# Name.......: provider.tf
# Author.....: Martin Berger (mbg) martin.berger@trivadis.com
# Editor.....: Martin Berger
# Date.......: 2021.02.22
# Revision...: 
# Purpose....: Provider specific configuration for this terraform configuration.
# Notes......: --
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ---------------------------------------------------------------------------


# define the terraform provider
provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}

# define local state file for terraform
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

# define remote state file for terraform
#terraform {
#  required_version = ">= 0.13.0"
#  backend "http" {
#    update_method = "PUT"
#    address       =  "https://objectstorage.eu-zurich-1.oraclecloud.com/p/............./b/terraform_state_file/o/terraform.tfstate"
#  }
#}

# --- EOF -------------------------------------------------------------------

