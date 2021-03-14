# Terraform & Ansible Starter Kit
This example contains a Terraform configuration to a public/private subnet setup, creates a compute instance ans installs Apache 2 by Ansible.

# What this example covers
 * A new compartment is created based on an existing compartment
 * VCN with regional public and private subnet provisioned
 * Routing tables and security lists provisioned
 * Internet gateway, NAT gateway and service gateway provisioned
 * Oracle Linux Server in public Subnet
 * Configures Ansible on Target Server
 * Installs Apache 2 by Ansible

# Prerequisites
  * Oracle OCI CLI installed and configured 
  * Terraform up and running
  * Git client installed
  * SSH public key for OCI instance setup available (or you can use the examples in ss subdirectory)


# Variables in terraform.tfvars file
Required variables according your Oracle Cloud Infrastructure environment.
| Variable                              | Value                                      |
|---------------------------------------|--------------------------------------------|
| TF_VAR_tenancy_ocid                   | OCI Tenancy OCID                           |
| TF_VAR_user_ocid                      | OCI User OCID                              | 
| TF_VAR_key_file                       | OCI API SSH Key File                       |
| TF_VAR_fingerprint                    | OCI API Fingerprint                        |
| TF_VAR_region                         | OCI Region                                 |
| TF_VAR_compartment_name               | OCI Compartment Name                       |
| TF_VAR_compartment_description        | OCI Compartment Description                |
| TF_VAR_compartment_master_ocid        | OCI Master Compartment OCID                |

  * Note 1: In this example, in _variables.tf_ example keys from subdirectory ssh are used.
  * Note 2: The new created compartent still exists after _terraform destroy_ command - you change the behavior in _main.tf_ line 23.


## Example to export specific variables:
```bash
export TF_VAR_tenancy_ocid=<your_tenancy_ocid>
export TF_VAR_user_ocid=<your_username_OCID>                              
export TF_VAR_private_key_path=<your_ssh_private_key>   
export TF_VAR_fingerprint=<your_public_key_fingerprint>
export TF_VAR_region=<your_OCI_region>                           
export TF_VAR_compartment_name=<your_compartment_name>
export TF_VAR_compartment_description=<your_compartment_description>
export TF_VAR_compartment_master_ocid=<your_OCID of the master compartment>
```

# Usage

 * Define the provider specific variables either in terraform.tfvars or via ENV variables
 * Initialize the OCI terraform provider


## Terraform init

```bash
$ terraform init
```

## Terraform plan

```bash
$ terraform plan -out=compute-ansible.tfplan
```

## Terraform apply
```bash
$ terraform apply compute-ansible.tfplan
```

# SSH Access
The public SSH key for the compute instance is provided in file _variables.tf_ or by your environment settings. The example private key to get access to the compute instance is available in subdirectory ssh. Please change the keys.

# Apache 2 URL
The public IP address is part of the Terraform output variable _public-ip-for-compute-instance_.
* http://public-ip-for-compute-instance
