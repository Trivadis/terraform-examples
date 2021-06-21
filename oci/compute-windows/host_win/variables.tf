# ---------------------------------------------------------------------------
# Trivadis AG, Infrastructure Managed Services
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ---------------------------------------------------------------------------
# Name.......: variables.tf
# Author.....: Stefan Oehrli (oes) stefan.oehrli@trivadis.com
# Editor.....: Stefan Oehrli
# Date.......: 2020.10.12
# Revision...: 
# Purpose....: Variable file for the terraform module tvdlab compute.
# Notes......: -- 
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ---------------------------------------------------------------------------

# provider identity parameters ----------------------------------------------
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
variable "compartment_ocid" {
  description = "OCID of the compartment where to create all resources"
  type        = string
}

variable "label_prefix" {
  description = "A string that will be prepended to all resources"
  type        = string
  default     = "none"
}

variable "resource_name" {
  description = "user-friendly string to name all resource. If undefined it will be derived from compartment name. "
  type        = string
  default     = ""
}

variable "ad_index" {
  description = "The index of the availability domain. This is used to identify the availability_domain place the compute instances."
  default     = 1
  type        = number
}

variable "defined_tags" {
  description = "Defined tags for this resource"
  type        = map(any)
  default     = {}
}

variable "tags" {
  description = "A simple key-value pairs to tag the resources created"
  type        = map(any)
  default     = {}
}

# Trivadis LAB specific parameter -------------------------------------------
variable "tvd_participants" {
  description = "The number of VCN to create"
  type        = number
  default     = 1
}

variable "tvd_domain" {
  description = "The domain name of the LAB environment"
  type        = string
  default     = "trivadislabs.com"
}

variable "tvd_os_user" {
  description = "Default OS user used to bootstrap"
  default     = "oracle"
  type        = string
}

variable "tvd_def_password" {
  description = "Default password for windows administrator, oracle, directory and more"
  type        = string
  sensitive   = true
}

variable "lab_source_url" {
  description = "preauthenticated URL to the LAB source ZIP file."
  default     = ""
  type        = string
}

# Host Parameter ----------------------------------------------------
variable "host_enabled" {
  description = "whether to create the compute instance or not."
  default     = false
  type        = bool
}

variable "host_name" {
  description = "Name portion of host"
  default     = "ad"
  type        = string
}

variable "host_image_id" {
  description = "Provide a custom image id for the host or leave as OEL (Oracle Enterprise Linux)."
  default     = "WIN"
  type        = string
}

variable "host_os" {
  description = "Base OS for the host."
  default     = "Windows"
  type        = string
}

variable "host_os_version" {
  description = "Define Base OS version for the host."
  default     = "Server 2019 Standard"
  type        = string
}

variable "host_subnet" {
  description = "List of subnets for the host hosts"
  type        = list(string)
}

variable "host_public_ip" {
  description = "whether to assigne a public IP or not."
  default     = false
  type        = bool
}

variable "host_private_ip" {
  description = "Private IP for host."
  default     = "10.0.1.4"
  type        = string
}

variable "hosts_file" {
  description = "path to a custom /etc/hosts which has to be appended"
  default     = ""
  type        = string
}

variable "host_state" {
  description = "Whether the host should be either RUNNING or STOPPED state. "
  default     = "RUNNING"
}

variable "host_shape" {
  description = "The shape of compute instance."
  default     = "VM.Standard.E4.Flex"
  type        = string
}

variable "host_ocpus" {
  description = "The ocpus for the shape."
  default     = 1
  type        = number
}

variable "host_memory_in_gbs" {
  description = "The memory in gbs for the shape."
  default     = 8
  type        = number
}

variable "host_boot_volume_size" {
  description = "Size of the boot volume."
  default     = 256
  type        = number
}

variable "host_volume_enabled" {
  description = "whether to create an additional volume or not."
  default     = false
  type        = bool
}

variable "host_volume_source" {
  description = "Source block volume to clone from."
  default     = ""
  type        = string
}

variable "host_volume_attachment_type" {
  description = "The type of volume."
  default     = "paravirtualized"
  type        = string
}

variable "host_volume_size" {
  description = "Size of the additional volume."
  default     = 256
  type        = number
}


# --- EOF -------------------------------------------------------------------
