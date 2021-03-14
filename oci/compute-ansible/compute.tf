# ---------------------------------------------------------------------------
# Trivadis AG, Infrastructure Managed Services
# Saegereistrasse 29, 8152 Glattbrugg, Switzerland
# ---------------------------------------------------------------------------
# Name.......: compute.tf
# Author.....: Martin Berger (mbg) martin.berger@trivadis.com
# Editor.....: Martin Berger
# Date.......: 2021.03.13
# Revision...: 
# Purpose....: Create compute instance, setup ansible and install httpd service
# Notes......: Replace SSH Keys first
# Reference..: --
# License....: Apache License Version 2.0, January 2004 as shown
#              at http://www.apache.org/licenses/
# ---------------------------------------------------------------------------


# Create Application Server -----------------------------------------------------

# Oracle Linux instance according image OCID - PUblic Subnet
resource "oci_core_instance" "compute_instance" {
  # Required
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = oci_identity_compartment.tf-compartment.id
  shape               = var.compute_shape
  source_details {
    source_id   = var.linux_image_ocid[var.region]
    source_type = "image"
  }

  # Optional
  display_name = var.compute_display_name
  create_vnic_details {
    assign_public_ip = true
    subnet_id        = oci_core_subnet.vcn-public-subnet.id
  }
  metadata = {
    ssh_authorized_keys = var.ssh_opc_public_key
  }

  preserve_boot_volume = false


  # Create connect to preprare SSH setup for user ansible
  provisioner "file" {
    source      = var.ssh_ansible_public_key_file
    destination = "/tmp/authorized_keys"

    connection {
      type        = "ssh"
      host        = oci_core_instance.compute_instance.public_ip
      user        = "opc"
      private_key = file(var.ssh_opc_private_key_file)
    }
  }

  # Add OS user ansible and add to sudo group, prepare directories and permissions
  provisioner "remote-exec" {
    inline = [
      # Setup sudo to allow no-password sudo for "ansible" user
      # From: https://learn.hashicorp.com/tutorials/terraform/packer
      "sudo echo 'This instance was provisioned by Terraform.' | sudo tee /etc/motd",
      "sudo yum -y install ansible git python",
      "sudo groupadd -r ansible",
      "sudo useradd -m -s /bin/bash -g ansible ansible",
      "sudo echo 'ansible ALL=(ALL) NOPASSWD: ALL' | sudo EDITOR='tee -a' visudo",

      # Installing SSH key
      "sudo mkdir -p /home/ansible/.ssh",
      "sudo chmod 700 /home/ansible/.ssh",
      "sudo mkdir -p /home/ansible/files",
      "sudo chmod 700 /home/ansible/files",
      "sudo cp /tmp/authorized_keys /home/ansible/.ssh/authorized_keys",
      "sudo chmod 600 /home/ansible/.ssh/authorized_keys",
      "sudo chown -R ansible /home/ansible/.ssh",
      "sudo chown -R ansible /home/ansible/files",
      "sudo rm /tmp/authorized_keys",
    ]

    connection {
      type        = "ssh"
      host        = oci_core_instance.compute_instance.public_ip
      user        = "opc"
      private_key = file(var.ssh_opc_private_key_file)
    }
  }


  # Transfer apache install file    
  provisioner "file" {
    source      = "./ansible/apache-install.yml"
    destination = "/home/ansible/files/apache-install.yml"

    connection {
      type        = "ssh"
      host        = oci_core_instance.compute_instance.public_ip
      user        = "ansible"
      private_key = file(var.ssh_ansible_private_key_file)
    }
  }

  # Execute Ansible playbook
  provisioner "remote-exec" {
    inline = [
      "cd files; ansible-playbook -c local -i \"localhost,\" apache-install.yml",
    ]

    connection {
      type        = "ssh"
      host        = oci_core_instance.compute_instance.public_ip
      user        = "ansible"
      private_key = file(var.ssh_ansible_private_key_file)
    }
  }
}

# --- EOF -------------------------------------------------------------------
