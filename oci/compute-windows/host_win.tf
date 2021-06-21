# ------------------------------------------------------------------------------
# Trivadis AG, Infrastructure Managed Services
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ------------------------------------------------------------------------------
# Name.......: host_win.tf
# Author.....: Stefan Oehrli (oes) stefan.oehrli@trivadis.com
# Editor.....: Stefan Oehrli
# Date.......: 2021.06.17
# Revision...: 
# Purpose....: Main configuration to build the training environment.
# Notes......: Define the core resouces using the module tvdlab-base
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ------------------------------------------------------------------------------

# - ADD VCM Module -------------------------------------------------------------
module "tvdlab-win" {
  source = "./host_win"

  # - Mandatory Parameters -----------------------------------------------------
  region           = var.region                          # The OCI region where resources will be created
  compartment_ocid = var.compartment_ocid                # OCID of the compartment where to create all resources
  tenancy_ocid     = var.tenancy_ocid                    # tenancy id where to create the resources
  host_subnet      = module.tvdlab-vcn.private_subnet_id # List of subnets for the host hosts
  tvd_def_password = var.tvd_def_password                # Default password for windows administrator, oracle, directory and more
  lab_source_url   = var.lab_source_url                  # preauthenticated URL to the LAB source ZIP file.
  # - Optional Parameters ------------------------------------------------------
  # Lab Configuration
  resource_name    = var.resource_name    # user-friendly string to name all resource. If undefined it will be derived from compartment name.
  tvd_domain       = var.tvd_domain       # The domain name of the LAB environment
  tvd_participants = var.tvd_participants # The number of VCN to create

  # general oci parameters
  ad_index              = var.ad_index                  # The index of the availability domain. This is used to identify the availability_domain place the compute instances.
  label_prefix          = var.label_prefix              # A string that will be prepended to all resources
  defined_tags          = var.defined_tags              # Defined tags to tag the resources created
  tags                  = var.tags                      # A simple key-value pairs to tag the resources created
  hosts_file            = local.hosts_file              # path to a custom /etc/hosts which has to be appended"
  host_enabled          = var.host_win_enabled          # whether to create the compute instance or not.
  host_name             = var.host_win_name             # Name portion of host
  host_image_id         = var.host_win_image_id         # Provide a custom image id for the host or leave as OEL (Oracle Enterprise Linux).
  host_boot_volume_size = var.host_win_boot_volume_size # Size of the boot volume.
  host_ocpus            = var.host_win_ocpus            # The ocpus for the shape.
  host_memory_in_gbs    = var.host_win_memory_in_gbs    # The memory in gbs for the shape.
  host_private_ip       = var.host_win_private_ip       # Private IP for host.
  host_shape            = var.host_win_shape            # The shape of compute instance.
  host_state            = var.tvd_training_state        # Whether the host should be either RUNNING or STOPPED state.

}

# ------------------------------------------------------------------------------
# - Variables
# ------------------------------------------------------------------------------

# Host Parameter ---------------------------------------------------------------
variable "host_win_enabled" {
  description = "whether to create the compute instance or not."
  default     = false
  type        = bool
}

variable "host_win_name" {
  description = "Name portion of host"
  default     = "win"
  type        = string
}

variable "host_win_image_id" {
  description = "Provide a custom image id for the host or leave as OEL (Oracle Enterprise Linux)."
  default     = "WIN"
  type        = string
}

variable "host_win_boot_volume_size" {
  description = "Size of the boot volume."
  default     = 256
  type        = number
}

variable "host_win_shape" {
  description = "The shape of compute instance."
  default     = "VM.Standard.E3.Flex"
  type        = string
}

variable "host_win_ocpus" {
  description = "The ocpus for the shape."
  default     = 1
  type        = number
}

variable "host_win_memory_in_gbs" {
  description = "The memory in gbs for the shape."
  default     = 16
  type        = number
}

variable "host_win_volume_enabled" {
  description = "whether to create an additional volume or not."
  default     = false
  type        = bool
}

variable "host_win_volume_source" {
  description = "Source block volume to clone from."
  default     = ""
  type        = string
}

variable "host_win_volume_size" {
  description = "Size of the additional volume."
  default     = 256
  type        = number
}

variable "host_win_private_ip" {
  description = "Private IP for host."
  default     = "10.0.1.50"
  type        = string
}

variable "host_win_state" {
  description = "Whether the host should be either RUNNING or STOPPED state. "
  default     = "RUNNING"
}

variable "host_win_defined_tags" {
  description = "Defined tags for this resource"
  type        = map(any)
  default     = {}
}

variable "host_win_tags" {
  description = "A simple key-value pairs to tag the resources created"
  type        = map(any)
  default     = {}
}
# --- EOF ----------------------------------------------------------------------
