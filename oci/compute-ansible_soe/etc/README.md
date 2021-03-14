# Configuration Files

This directory contains configuration files and templates used to setup and bootstrap the different compute instances.

- [default_authorized_keys](default_authorized_keys) default SSH authorized key files for the different compute instances.
- [hosts.template](hosts.template) template for additional host entries. This file will be appended to the regular `/etc/hosts`. Variable values are replaced by `templatefile` in [local.tf](../local.tf).
- [id_oci_avocado](id_oci_avocado) private key used to configure Guacamole access. Key also have to be added to [guacamole_connections.sql](../scripts/guacamole_connections.sql).
- [id_oci_avocado.pub](id_oci_avocado.pub) public key used to configure Guacamole access.