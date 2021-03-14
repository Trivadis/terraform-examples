# ---------------------------------------------------------------------------
# Trivadis AG, Infrastructure Managed Services
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ---------------------------------------------------------------------------
# Name.......: variables.tf
# Author.....: Martin Berger (mbg) martin.berger@trivadis.com
# Editor.....: Martin Berger
# Date.......: 2021.03.14
# Revision...: 
# Purpose....: Variable definition for this terraform configuration.
# Notes......: --
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ---------------------------------------------------------------------------

# provider identity parameters ----------------------------------------------
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

# general oci parameters ----------------------------------------------------
variable "compartment_name" {
  description = "Name for the new compartment"
  type        = string
}

variable "compartment_description" {
  description = "Description of the new compartment"
  type        = string
}

variable "compartment_master_ocid" {
  description = "OCID of the master compartment"
  type        = string
}

# compute instance parameters ----------------------------------------------------
variable "compute_shape" {
  description = "The shape of compute instance."
  default     = "VM.Standard.E2.1"
  type        = string
}

variable "compute_image_id" {
  description = "Provide a custom image id for the host or leave as OEL (Oracle Enterprise Linux)."
  default     = "OEL"
  type        = string
}


variable "compute_os" {
  description = "Base OS for Linux based OS."
  default     = "Oracle Linux"
  type        = string
}

variable "compute_os_version" {
  description = "Define the default OS version for Oracle Linux."
  default     = "7.9"
  type        = string
}

variable "compute_ocpus" {
  description = "The ocpus for the shape."
  default     = 1
  type        = number
}

variable "compute_memory_in_gbs" {
  description = "The memory in gbs for the shape."
  default     = 8
  type        = number
}

variable "compute_display_name" {
  description = "Display name of host"
  default     = "Application Server - Private Subnet"
  type        = string
}


variable "bootstrap_cloudinit_template" {
  description = "path to boostrap cloudinit template file"
  default     = ""
  type        = string
}

variable "bootstrap_playbook_path" {
  description = "path to boostrap playbook file"
  default     = ""
  type        = string
}

# SSH ------------------------- ----------------------------------------------------

variable "ssh_public_key" {
  description = "the content of the ssh public key used to access the admin. set this or the ssh_public_key_path"
  default     = ""
  type        = string
}

variable "ssh_public_key_path" {
  description = "path to the ssh public key used to access the admin. set this or the ssh_public_key"
  default     = ""
  type        = string
}

# vcn parameters ------------------------------------------------------------
variable "vcn_name" {
  description = "name of VCN"
  default     = "VCN OpenVPN Access"
  type        = string
}

variable "vcn_dns_label" {
  description = "DNS label of VCN"
  default     = "vcnopenvpnas"
  type        = string
}

variable "vcn_cidr" {
  description = "cidr block of VCN"
  default     = "10.1.0.0/24"
  type        = string
}

variable "vcn_public_cidr_block" {
  description = "cidr block of public subnet"
  default     = "10.1.0.0/27"
  type        = string
}

variable "vcn_private_cidr_block" {
  description = "cidr block of private subnet"
  default     = "10.1.0.32/27"
  type        = string
}

variable "nat_gateway_display_name" {
  description = "Display name of NAT gateway"
  default     = "ng-01"
  type        = string
}

variable "internet_gateway_display_name" {
  description = "Display name of internet gateway"
  default     = "ig-01"
  type        = string
}

variable "service_gateway_display_name" {
  description = "Display name of internet gateway"
  default     = "sg-01"
  type        = string
}

variable "service_gateway_enabled" {
  description = "Service gateway enabled"
  default     = true
  type        = bool
}

variable "public_route_table_display_name" {
  description = "Display name of the public route table"
  default     = "rt-public-01"
  type        = string
}

variable "private_route_table_display_name" {
  description = "Display name of the private route table"
  default     = "rt-private-01"
  type        = string
}

# --- EOF -------------------------------------------------------------------
