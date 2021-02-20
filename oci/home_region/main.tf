# ---------------------------------------------------------------------------
# Trivadis AG, Infrastructure Managed Services
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ---------------------------------------------------------------------------
# Name.......: home_region.tf
# Author.....: Stefan Oehrli (oes) stefan.oehrli@trivadis.com
# Editor.....: Stefan Oehrli
# Date.......: 2021.02.15
# Revision...: 
# Purpose....: Get the home region from tenancy.
# Notes......: --
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ---------------------------------------------------------------------------

# These variables would commonly be defined as environment variables or sourced in a .env file
variable "user_ocid" {
  description = "user OCID used to access OCI"
  type        = string
}

variable "fingerprint" {
  description = "Fingerprint for user"
  type        = string
}

variable "private_key_path" {
  description = "Private Key Path"
  type        = string
}

variable "tenancy_ocid" {
  description = "tenancy id where to create the resources"
  type        = string
}

variable "region" {
  # List of regions: https://docs.cloud.oracle.com/iaas/Content/General/Concepts/regions.htm#ServiceAvailabilityAcrossRegions
  description = "The OCI region where resources will be created"
  type        = string
}

# default provider for the configuration
provider "oci" {
  tenancy_ocid     = var.tenancy_ocid
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  private_key_path = var.private_key_path
  region           = var.region
}

# This data source provides details about a specific Tenancy resource in 
# Oracle Cloud Infrastructure Identity service. see 
# https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/identity_tenancy
data "oci_identity_tenancy" "tenancy" {
  tenancy_id = var.tenancy_ocid
}

# This data source provides the list of Regions in Oracle Cloud Infrastructure Identity service.
# see https://registry.terraform.io/providers/hashicorp/oci/latest/docs/data-sources/identity_regions
data "oci_identity_regions" "regions" {
}

locals {
  # define a region map
  region_map = {
    for r in data.oci_identity_regions.regions.regions :
    r.key => r.name
  }
  # get home region for home_region_key
  home_region = lookup(
    local.region_map,
    data.oci_identity_tenancy.tenancy.home_region_key
  )
}

# display home region
output "home_region" {
  value = local.home_region
}

# display region
output "region" {
  value = var.region
}
# --- EOF -------------------------------------------------------------------