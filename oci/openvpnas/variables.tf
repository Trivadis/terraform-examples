# ---------------------------------------------------------------------------
# Trivadis AG, Infrastructure Managed Services
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ---------------------------------------------------------------------------
# Name.......: variables.tf
# Author.....: Martin Berger (mbg) martin.berger@trivadis.com
# Editor.....: Martin Berger
# Date.......: 2021.02.11
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

variable "linux_image_ocid" {
  type = map(any)

  default = {
    # See https://docs.us-phoenix-1.oraclecloud.com/images/
    # Oracle-provided image "Oracle-Linux-7.8-2020.04.17-0"
    eu-zurich-1    = "ocid1.image.oc1.eu-zurich-1.aaaaaaaa5ganyj57k2dqyik4m4btpuq23le3e7clh56rjhgz6fekvtoyazqa"
    eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaavz6p7tyrczcwd5uvq6x2wqkbwcrjjbuohbjomtzv32k5bq24rsha"
    eu-amsterdam-1 = "ocid1.image.oc1.eu-amsterdam-1.aaaaaaaaie5km236l53ymcvpwufyb2srtc3hw2pa6astfjdafzlxxdv5nfsq"
    us-ashburn-1   = "ocid1.image.oc1.iad.aaaaaaaahjkmmew2pjrcpylaf6zdddtom6xjnazwptervti35keqd4fdylca"
  }
}

variable "compute_display_name" {
  description = "Display name of host"
  default     = "Application Server - Private Subnet"
  type        = string
}

variable "ssh_public_key" {
	default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCbytm9y7UigHeV2L0vUXWqFiplf9ntG9VMUBGwEoWATV6Ir/4udvObm/6dFCltVmvHVWD5XdbXWvyz9is69jH3Cb2hOUtyZMeXJBTtXnMuC0HaN7zHmrV6qfkQDiRpJNHCEpD3LhAL2VG7tViqCC9rSTEfezKibjGXVl1R606xp57oduuT1V4g82+BLYKdEsDAfgVLI8z23dSYyzd3Kb6ikqG+9wSA1KWWb051KE8ofRtL+FD5cZ/uGLwhczIbMaEZjHs5Zv5L9kWKUU4nBIxv4RN2QjbpFQ+EoTVVZqPeT1eILKEuOFPy5s42AA1an4FMdSoLmEuRtC0sIoR5L5kj imported-openssh-key"
  type        = string
}


# openvpnas instance parameters ----------------------------------------------------
variable "mp_listing_id" {
  description = "OCI Marketplace Listing ID"
  default     = "ocid1.appcataloglisting.oc1..aaaaaaaafbgwdxg5j6jnyfhbcxvd62iabcraaf6bwu2u2nhrddztrrle66lq"
  type        = string
}

variable "mp_listing_resource_id" {
  description = "OCI Marketplace Listing Resource ID"
  default     = "ocid1.image.oc1..aaaaaaaa4ozqggnywlp3e3wzvu5x3aoohkt6cwm2pumgpn2tlzroj756azma"
  type        = string
}

variable "mp_listing_resource_version" {
  description = "OCI Marketplace Listing Version"
  default     = "AS_2.8.3"
  type        = string
}

variable "openvpn_display_name" {
  description = "Display name of OpenVPN Access Server"
  default     = "OpenVPN Access Server - Public Subnet"
  type        = string
}

variable "openvpn_admin_username" {
  description = "OpenVPN Application Server username"
  default     = "openvpnadmin"
  type        = string
}

variable "openvpn_admin_password" {
  description = "OpenVPN Application Server admin password"
  type        = string
}

variable "openvpn_activation_key" {
  description = "OpenVPN Application Server License Activation Key"
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