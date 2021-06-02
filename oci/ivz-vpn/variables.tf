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

variable "compartment_ocid" {
  description = "The OCI compartment where resources will be created"
  type        = string
}


# network settings

variable "vcn_name" {
  description = "Name for the new VCN"
  type        = string
  default     = "vcn-ivz-dev-01"
}

variable "vcn_cidr_block" {
  description = "CIDR Block for VCN"
  type        = string
  default     = "10.10.2.0/24"
}

variable "vcn_dns_label" {
  description = "Label for DNS"
  type        = string
  default     = "vcnivzdev01"
}

variable "vcn_subnet_cidr_block_private_1" {
  description = "CIDR Block for VCN"
  type        = string
  default     = "10.10.2.0/27"
}

variable "vcn_subnet_name_private_1" {
  description = "Subnet Name"
  type        = string
  default     = "sn-private-ivz-dev-01"
}

variable "vcn_subnet_cidr_block_private_2" {
  description = "CIDR Block for VCN"
  type        = string
  default     = "10.10.2.32/27"
}

variable "vcn_subnet_name_private_2" {
  description = "Subnet Name"
  type        = string
  default     = "sn-private-ivz-dev-02"
}

variable "private_route_table_display_name" {
  description = "Route Table Name"
  type        = string
  default     = "rt-private-ivz-dev-00"
}


variable "nat_gateway_display_name" {
  description = "NAT Gateway Name"
  type        = string
  default     = "ng-ivz-dev-00"
}

variable "service_gateway_display_name" {
  description = "NAT Gateway Name"
  type        = string
  default     = "sg-ivz-dev-00"
}

variable "service_gateway_enabled" {
  description = "Enable SG yes/no"
  type        = string
  default     = "1"
}

# VPN
variable "drg_display_name" {
  description = "DRG name for the Trivadis VPN"
  type        = string
  default     = "vpn-ivz-drg-trivadis"
}

variable "cpe_public_ip_address" {
  description = "Trivadis pulic IP for VPN tunnel end-point"
  type        = string
  default     = "195.191.189.219"
}

variable "cpe_display_name" {
  description = "CPE name for the Trivadis VPN"
  type        = string
  default     = "vpn-ivz-cpe-trivadis"
}

variable "ip_sec_connection_static_routes" {
  description = "Static route to Trivadis for IPSec tunnel"
  type        = list(string)
  default     = ["172.16.0.0/12"]
}

variable "ip_sec_connection_display_name" {
  description = "IPSec connection name for the Trivadis VPN"
  type        = string
  default     = "vpn-ivz-ipsec-trivadis"
}

variable "drg_attachment_display_name" {
  description = "DRG VCN attachment name for the Trivadis VPN"
  type        = string
  default     = "vpn-ivz-drg-attach-trivadis"
}

