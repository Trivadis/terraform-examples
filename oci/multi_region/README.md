# Home Region

This example contains Terraform configuration to get the home region for the current tenancy. This is used to create IAM resouces (see [Provision Oracle Cloud Infrastructure Home Region IAM resources in a multi-region Terraform configuration](https://medium.com/oracledevs/provision-oracle-cloud-infrastructure-home-region-iam-resources-in-a-multi-region-terraform-f997a00ae7ed))

## What this example covers

- Query the tenancy for the home region key
- Get the home region based on the key and the map of the regions
- Create a compartment *multi_region* in the root compartment

## Usage

### Configure Terraform configuration

- Define the provider specific variables either in [terraform.tfvars](terraform.tfvars) or via ENV variables
- initialize the OCI terraform provider

```bash
terraform init
```

### Deploy the Terraform configuration

- Plan the configuration changes

```bash
terraform plan -out=multi_region.tfplan

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # oci_identity_compartment.compartment will be created
  + resource "oci_identity_compartment" "compartment" {
      + compartment_id = "ocid1.tenancy.oc1..xyz"
      + defined_tags   = (known after apply)
      + description    = "Example compartment multi_region created by terraform"
      + enable_delete  = true
      + freeform_tags  = (known after apply)
      + id             = (known after apply)
      + inactive_state = (known after apply)
      + is_accessible  = (known after apply)
      + name           = "multi_region"
      + state          = (known after apply)
      + time_created   = (known after apply)
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + home_region = "eu-zurich-1"
  + region      = "us-ashburn-1"

------------------------------------------------------------------------

This plan was saved to: multi_region.tfplan

To perform exactly these actions, run the following command to apply:
    terraform apply "multi_region.tfplan"
```

- Create or update infrastructure

```bash
terraform apply multi_region.tfplan

oci_identity_compartment.compartment: Creating...
oci_identity_compartment.compartment: Still creating... [10s elapsed]
oci_identity_compartment.compartment: Still creating... [20s elapsed]
oci_identity_compartment.compartment: Still creating... [30s elapsed]
oci_identity_compartment.compartment: Still creating... [40s elapsed]
oci_identity_compartment.compartment: Still creating... [50s elapsed]
oci_identity_compartment.compartment: Still creating... [1m0s elapsed]
oci_identity_compartment.compartment: Still creating... [1m10s elapsed]
oci_identity_compartment.compartment: Creation complete after 1m13s [id=xxx]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

The state of your infrastructure has been saved to the path
below. This state is required to modify and destroy your
infrastructure, so keep it safe. To inspect the complete state
use the `terraform show` command.

State path: terraform.tfstate

Outputs:

home_region = "eu-zurich-1"
region = "us-ashburn-1"
```

### Remove the Terraform Configuration

- run Terraform destroy

```bash
terraform destroy

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # oci_identity_compartment.compartment will be destroyed
  - resource "oci_identity_compartment" "compartment" {
      - compartment_id = "ocid1.tenancy.oc1..xyz" -> null
      - defined_tags   = {
          - "Oracle-Tags.CreatedBy" = "stefan.oehrli@trivadis.com"
          - "Oracle-Tags.CreatedOn" = "2021-02-15T20:05:25.274Z"
        } -> null
      - description    = "Example compartment multi_region created by terraform" -> null
      - enable_delete  = true -> null
      - freeform_tags  = {} -> null
      - id             = "ocid1.compartment.oc1..xyz" -> null
      - is_accessible  = true -> null
      - name           = "multi_region" -> null
      - state          = "ACTIVE" -> null
      - time_created   = "2021-02-15 20:05:25.626 +0000 UTC" -> null
    }

Plan: 0 to add, 0 to change, 1 to destroy.

Changes to Outputs:
  - home_region = "eu-zurich-1" -> null
  - region      = "us-ashburn-1" -> null

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

oci_identity_compartment.compartment: Destroying... [id=ocid1.compartment.oc1..aaaaaaaauq7qitiozpda3kajlbhggd3klapqe4cdfrggefex6eprfuky3ica]
oci_identity_compartment.compartment: Still destroying... [id=ocid1.compartment.oc1..xyz, 10s elapsed]
...
oci_identity_compartment.compartment: Still destroying... [id=ocid1.compartment.oc1..xyz, 3m50s elapsed]
oci_identity_compartment.compartment: Destruction complete after 3m56s

Destroy complete! Resources: 1 destroyed.
```

## Customisation

Update the [terraform.tfvars](terraform.tfvars) or define the `TF_VAR_*` environment variables.

## Tips and Troubleshooting

tbd
