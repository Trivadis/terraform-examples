# Cloud Init Files and Templates

This directory contains cloud-init user data files and templates used to setup
and bootstrap the windows compute instances.

- [windows_host.yaml](windows_host.yaml) cloud-init configuration file for
  windows host
- [bootstrap_win_host.template.ps1](bootstrap_win_host.template.ps1) Script to
  bootstrap the windows server/client
- [config_win_env.ps1](config_win_env.ps1) Script to configure the Windows server
  after bootstrap. Script has to be execuded manually via destop shortcut. It is
  also defined as RunOnce but not executed yet.
