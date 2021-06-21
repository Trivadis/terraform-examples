#ps1_sysnative
# -----------------------------------------------------------------------------
# Trivadis AG, Infrastructure Managed Services
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# -----------------------------------------------------------------------------
# Name.......: config_win_env.ps1
# Author.....: Stefan Oehrli (oes) stefan.oehrli@trivadis.com
# Editor.....: Stefan Oehrli
# Date.......: 2021.06.21
# Revision...: 
# Purpose....: Script to configure the Windows server after bootstrap
# Notes......:  
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# -----------------------------------------------------------------------------
# Modified...:
# see git revision history for more information on changes/updates
# -----------------------------------------------------------------------------
$PuttyRegFile = (Get-ChildItem -Path "c:\u00" -Filter "*putty_sessions.reg" -Recurse -ErrorAction SilentlyContinue -Force).FullName | Select-Object -last 1
reg import $PuttyRegFile
# --- EOF ----------------------------------------------------------------------