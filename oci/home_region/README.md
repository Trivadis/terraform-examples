# Home Region

This example contains Terraform configuration to get the home region for the current tenancy. This is used to create IAM resouces (see [Provision Oracle Cloud Infrastructure Home Region IAM resources in a multi-region Terraform configuration](https://medium.com/oracledevs/provision-oracle-cloud-infrastructure-home-region-iam-resources-in-a-multi-region-terraform-f997a00ae7ed))

## What this example covers

- Query the tenancy for the home region key
- Get the home region based on the key and the map of the regions
- output the home region and current region

## Usage

- Define the provider specific variables either in [terraform.tfvars](terraform.tfvars) or via ENV variables
- initialize the OCI terraform provider

```bash
terraform init
```

- Plan the configuration changes

```bash
terraform plan -out=home_region.tfplan
```

- Create or update infrastructure

```bash
terraform apply home_region.tfplan
```

## Customisation

tbd

## Tips and Troubleshooting

tbd
