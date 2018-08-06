# ultimate-terraform-bootcamp
UTB supporting code repository

## Assumptions
 * AWS/GCP/Azure Accounts are already present
 * GCP Project is already present
 * Terraform backend bucket is already present

## Commands Used
```
 export GOOGLE_CREDENTIALS=PATH_TO_CREDS_JSON
 terraform init
```

## Tips
 * Interpolations(variables) cannot be used in backend configuration. [reason](https://www.terraform.io/docs/configuration/terraform.html#description): *The terraform block is loaded very early in the execution of Terraform and interpolations are not yet available.*
 * [Random Provider](https://www.terraform.io/docs/providers/random/index.html) used to create random strings.
 * If you face `403 unauthorized` errors for valid authentication, then remove `.terraform` directory from your workspace and try again.