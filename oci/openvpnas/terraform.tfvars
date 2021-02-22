# ---------------------------------------------------------------------------
# Trivadis AG, Infrastructure Managed Services
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ---------------------------------------------------------------------------
# Name.......: terraform.tfvars
# Author.....: Martin Berger (mbg) martin.berger@trivadis.com
# Editor.....: Martin Berger
# Date.......: 2021.02.11
# Revision...: 
# Purpose....: Private variables for this terraform configuration.
# Notes......: Do not check in
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ---------------------------------------------------------------------------

# required ------------------------------------------------------------------

# provider identity variables 
tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaaxuk4je4t3aorovuzmwyeaq5sftqv3nkyz64snijtdkitadbqqxmq"
user_ocid = "ocid1.user.oc1..aaaaaaaadlv5vwm3zfdnyanosmdjm7cyjzdhmgawregvm6de7wznb3fjqtxq"
private_key_path = "/home/oci/.oci/oci_api_key.pem"
fingerprint = "6a:ce:8e:a7:4a:a1:70:ad:4e:d7:e6:8f:d6:97:55:60"
region = "eu-zurich-1"

# general oci variables 
compartment_name="OCI_OpenVPN_Access"
compartment_description="OCI OpenVPN Access Server Setup"
compartment_master_ocid="ocid1.compartment.oc1..aaaaaaaat5uo2xh77edws4huwvqorengp7x4xdv6x3giw3vryk36vyydwsdq"

# compute instance variables 
compute_ssh_authorized_keys="./ssh/terraform_deployments_example.pub"

# openvpnas instance variables 
openvpn_admin_password="4703@Kestenholz"


# set as per default in variables.tf--------------------------------------------

# compute instance variables 
#compute_shape= "VM.Standard.E2.1"
#compute_source_id="ocid1.image.oc1.eu-zurich-1.aaaaaaaaxuq5fxk44frdwth73qxxdyfbmfzmqauyoo5d6ortrwhgfp5lme2q"
#compute_display_name="Application Server - Private Subnet"


# vcn variables 
#vcn_cidr="10.1.0.0/24"
#vcn_private_cidr_block="10.1.0.32/27"
#vcn_public_cidr_block="10.1.0.0/27"
#nat_gateway_display_name="ng-01"
#internet_gateway_display_name="ig-01"
#service_gateway_enabled=true
#service_gateway_display_name="sg-01"
#private_route_table_display_name="rt-private-01"
#public_route_table_display_name="rt-public-01"

# openvpnas instance variables 
#mp_listing_id="ocid1.appcataloglisting.oc1..aaaaaaaafbgwdxg5j6jnyfhbcxvd62iabcraaf6bwu2u2nhrddztrrle66lq"
#mp_listing_resource_id="ocid1.image.oc1..aaaaaaaa4ozqggnywlp3e3wzvu5x3aoohkt6cwm2pumgpn2tlzroj756azma"
#mp_listing_resource_version="AS_2.8.3"
#openvpn_display_name="OpenVPN Access Server - Private Subnet"
#openvpn_activation_key=""

# --- EOF -------------------------------------------------------------------