## Getting started with Terraform

### Terraform Commands

You can check the list of commands for Terraform by running, 

`terrform -h`

```
bash-root$ terraform -h
sage: terraform [--version] [--help] <command> [args]

The available commands for execution are listed below.
The most common, useful commands are shown first, followed by
less common or more advanced commands. If you're just getting
started with Terraform, stick with the common commands. For the
other commands, please read the help and docs before usage.

Common commands:
    apply              Builds or changes infrastructure
    console            Interactive console for Terraform interpolations
    destroy            Destroy Terraform-managed infrastructure
    env                Workspace management
    fmt                Rewrites config files to canonical format
    get                Download and install modules for the configuration
    graph              Create a visual graph of Terraform resources
    import             Import existing infrastructure into Terraform
    init               Initialize a Terraform working directory
    output             Read an output from a state file
    plan               Generate and show an execution plan
    providers          Prints a tree of the providers used in the configuration
    push               Upload this Terraform module to Atlas to run
    refresh            Update local state file against real resources
    show               Inspect Terraform state or plan
    taint              Manually mark a resource for recreation
    untaint            Manually unmark a resource as tainted
    validate           Validates the Terraform files
    version            Prints the Terraform version
    workspace          Workspace management

All other commands:
    debug              Debug output management (experimental)
    force-unlock       Manually unlock the terraform state
    state              Advanced state management
```

From those commands, the following are important.
```
terraform plan
terraform apply
terraform destroy
terraform init
terraform fmt
```
### Providers  
Providers are a way to define where you want to create your infrastructure. Usually Providers are,

  * IaaS
  * PaaS
  * SaaS

Mostly we will be using IaaS providers(Ex: AWS, Azure, GCP, etc.,)

`Export AWS Access Key and Secret Key `

```
export AWS_ACCESS_KEY_ID="Access-Key"
export AWS_SECRET_ACCESS_KEY="Secret-Key"
```

`Ex: AWS Provider`
```
provider "aws" {
  region = "us-east-1"
}
```

### Resources  
Resources are the different entities you want to create on given provider. As an example, for AWS provider, if you want to create an EC2 machine, you have to create the following resource.

`Ex: EC2 Resource`

```
resource "aws_instance" "web" {
  ami           = "ami-04169656fea786776"
  instance_type = "t2.micro"
  key_name      = "schoolofdevops"

  tags {
    Name = "terraform-second-machine"
  }
}
```


