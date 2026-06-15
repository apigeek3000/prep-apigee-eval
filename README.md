# prep-apigee-eval

Terraform to prepare a Google Cloud project for the creation of an Apigee eval organization. It:
1. Enables the needed APIs
2. Disables the project-level `compute.requireShieldedVm` org policy (sets `enforce = FALSE`).
3. Creates a default-equivalent VPC (auto-mode network + the four standard firewall rules), unless one already exists.

All Terraform lives in [`terraform/`](./terraform).

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.5
- The [gcloud CLI](https://cloud.google.com/sdk/docs/install), authenticated for Application Default Credentials:
```bash
gcloud init
gcloud auth application-default login
gcloud auth application-default set-quota-project
```
- GCP Project and Admin IAM Role
- Bootstrap APIs enabled once (Terraform manages APIs *via* these, so they must already be on — Terraform cannot enable them for you):
```bash
gcloud services enable cloudresourcemanager.googleapis.com serviceusage.googleapis.com --project=PROJECT_ID
```

## Check for an existing default VPC

Terraform creates a network named `default`. If the project already has one
(projects created with auto-networking do), the apply will fail with an
"alreadyExists" error. Check first:

```bash
export PROJECT_ID=$(gcloud config get-value project 2> /dev/null)
gcloud compute networks list --project=PROJECT_ID
```

If a `default` network is listed, set `create_default_vpc = false` in your
tfvars (see below) to skip creating it.

## Deploy

```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
# edit terraform.tfvars: set project_id (and create_default_vpc if needed)

terraform init
terraform plan
terraform apply
```

## Apigee Eval Deployment (Wizard)

Now you are ready to [create your Apigee Evaluation Organization](https://docs.cloud.google.com/apigee/docs/api-platform/get-started/eval-orgs#apigee-evaluation-organization)!
- Note: from the [Apigee homepage](https://console.cloud.google.com/apigee/welcome), be sure to select the "try Apigee for free" option. Other options will lead you towards a pay-as-you-go entitlement.
- Note: to get up and running quickly, enable external access and utilize the default nip.io address provisioned for you.