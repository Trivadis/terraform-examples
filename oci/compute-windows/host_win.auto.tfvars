# ------------------------------------------------------------------------------
# Trivadis AG, Infrastructure Managed Services
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ------------------------------------------------------------------------------
# Name.......: host_win.auto.tfvars
# Author.....: Stefan Oehrli (oes) stefan.oehrli@trivadis.com
# Editor.....: Stefan Oehrli
# Date.......: 2021.06.17
# Revision...: 
# Purpose....: Terraform Variable file for Oracle EM repository host
# Notes......: 
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ------------------------------------------------------------------------------
# OUD Host Parameter Oracle Database 19c ---------------------------------------
host_win_enabled       = true                  # whether to create the compute instance or not.
host_win_name          = "win"                 # Name portion of host
host_win_private_ip    = "10.0.1.50"           # Private IP for host.
host_win_image_id      = "WIN"                 # Provide a custom image id for the host or leave as OEL (Oracle Enterprise Linux).
host_win_shape         = "VM.Standard.E3.Flex" # The shape of compute instance.
host_win_ocpus         = 1                     # The OCPUS for the shape.
host_win_memory_in_gbs = 10                    # The memory in gbs for the shape. 
host_win_defined_tags  = { "Schedule.Weekend" = "0,0,0,0,0,0,0,0,0,0,*,*,*,*,*,*,*,*,*,*,*,0,0,0",
                           "Schedule.WeekDay" = "0,0,0,0,0,0,*,*,1,1,1,1,1,1,1,1,1,1,1,*,*,0,0,0" }
# --- EOF ----------------------------------------------------------------------
