# Providers
In Terraform, Providers are responsible for understanding API interactions from IaaS(AWS, Azure, etc.,), PaaS(Heroku) or SaaS(CloudFlare, DNSSimple, DNSMadeEasy, etc.,). 

## Example Provider
Let's look at AWS Provider as an example.

```
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "us-east-1"
}
```

As seen in the above given example, Provider is a way to instruct Terraform to interact with AWS API. Every provider needs some kind of credentials to get authenticated with the API. In our example, we have porvided AWS access key and secret key to perform the same. 

## Setting up our environment for AWS
Let us set up our environment by creating a directory called `aws`.

```
mkdir aws
cd aws
```

After changing directory into `aws`, we need to create a file named `main.tf`.

```
touch main.tf
```

Define your Provider details in this main manifest. Change the region if you want to create the resources elsewhere.

```
provider "aws" {
  region = "us-east-1"
}
```

Export your AWS access and secret keys as environment variables.

```
export AWS_ACCESS_KEY_ID="AKIAI3NYUWMNORYTDYBC"
export AWS_SECRET_ACCESS_KEY="toOh/ejVKe44wx3ujr7scaehdy4"
```

Finally run the following command to initialize your environment.

```
terraform init

[output]
Initializing provider plugins...
- Checking for available provider plugins on https://releases.hashicorp.com...
- Downloading plugin for provider "aws" (1.37.0)...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.aws: version = "~> 1.37"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
``` 
This should initialize the environment for our course.

## Reference
If you want to learn more about providers, you can visit [this link](https://www.terraform.io/docs/providers/).