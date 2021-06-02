# ---------------------------------------------------------------------------
# Trivadis AG, Infrastructure Managed Services
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ---------------------------------------------------------------------------
# Name.......: vpn.tf
# Author.....: Roland Stirnimann, roland.stirnimann@trivadis.com
# Editor.....: Roland Stirnimann
# Date.......: 18.03.2021
# Revision...: 
# Purpose....: Setting up all components required for the Trivadis VPN tunnel
# Notes......: --
# Reference..: --
# ---------------------------------------------------------------------------

resource "oci_core_drg" "trivadis_vpn_drg" {
  #Required
  compartment_id = var.compartment_ocid

  #Optional
  display_name = var.drg_display_name
}

resource "oci_core_cpe" "trivadis_vpn_cpe" {
  #Required
  compartment_id = var.compartment_ocid
  ip_address     = var.cpe_public_ip_address

  #Optional
  #cpe_device_shape_id = var.cpe_device_shape_id
  display_name = var.cpe_display_name
}

resource "oci_core_ipsec" "trivadis_vpn_ip_sec_connection" {
  #Required
  compartment_id = var.compartment_ocid
  cpe_id         = oci_core_cpe.trivadis_vpn_cpe.id
  drg_id         = oci_core_drg.trivadis_vpn_drg.id
  static_routes  = var.ip_sec_connection_static_routes

  #Optional
  display_name = var.ip_sec_connection_display_name
}

resource "oci_core_drg_attachment" "trivadis_vpn_drg_attachment" {
  #Required
  drg_id = oci_core_drg.trivadis_vpn_drg.id
  vcn_id = module.vcn.vcn_id

  #Optional
  display_name = var.drg_attachment_display_name
}
