# ---------------------------------------------------------------------------
# Trivadis AG, Infrastructure Managed Services
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ---------------------------------------------------------------------------
# Name.......: locals.tf
# Author.....: Stefan Oehrli (oes) stefan.oehrli@trivadis.com
# Editor.....: Stefan Oehrli
# Date.......: 2020.10.12
# Revision...: 
# Purpose....: Local variables for the terraform module tvdlab vcn.
# Notes......: -- 
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ---------------------------------------------------------------------------

locals {
  availability_domain = data.oci_identity_availability_domains.ad_list.availability_domains[var.ad_index - 1].name
  resource_name       = var.resource_name == "" ? data.oci_identity_compartment.compartment.name : var.resource_name
  resource_name_lower = lower(local.resource_name)
  resource_shortname  = lower(replace(local.resource_name, "-", ""))
  host_image_id       = var.host_image_id == "WIN" ? data.oci_core_images.oracle_images.images.0.id : var.host_image_id
  hosts_file          = var.hosts_file == "" ? "${path.module}/etc/hosts.template" : var.hosts_file
  host_bootstrap = base64encode(templatefile("${path.module}/cloudinit/bootstrap_win_host.template.ps1", {
    def_password        = var.tvd_def_password
    resource_name       = local.resource_name
    resource_name_lower = local.resource_name_lower
    lab_source_url      = var.lab_source_url
    tvd_domain          = var.tvd_domain
  }))
}
# --- EOF -------------------------------------------------------------------

