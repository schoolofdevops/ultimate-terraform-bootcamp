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
 * Attributes of a data source
   ```
    The syntax is data.TYPE.NAME.ATTRIBUTE. For example. ${data.aws_ami.ubuntu.id} will interpolate the id attribute from the aws_ami data source named ubuntu. If the data source has a count attribute set, you can access individual attributes with a zero-based index, such as ${data.aws_subnet.example.0.cidr_block}. You can also use the splat syntax to get a list of all the attributes: ${data.aws_subnet.example.*.cidr_block}.
   ```

## Reference Articles
  * https://blog.gruntwork.io/terraform-tips-tricks-loops-if-statements-and-gotchas-f739b
  bae55f9
  * https://medium.com/@hbarcelos/things-i-wish-i-knew-about-terraform-before-jumping-into-it-43ee92a9dd65