# Important Terraform Commands  

## Terraform Plan

 When you run `terraform plan` it will present you with the `execution plan`. This will show you which resources are going to be created/deleted or modified. This is more like a dry run, if you want to see what your code will do before you apply it. 

 `Example`  

```
terrform plan 

[output]
 Acquiring state lock. This may take a few moments...
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

aws_security_group.webserver_sg: Refreshing state... (ID: sg-04b81bcdfa7f287b0)
aws_key_pair.webserver_key: Refreshing state... (ID: web-admin-key)
aws_instance.webserver: Refreshing state... (ID: i-00ddea272445bd4ec)

------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
-/+ destroy and then create replacement

Terraform will perform the following actions:

-/+ aws_instance.webserver (tainted) (new resource required)
      id:                                "i-00ddea272445bd4ec" => <computed> (forces new resource)
      ami:                               "ami-408c7f28" => "ami-408c7f28"
      arn:                               "arn:aws:ec2:us-east-1:822941572458:instance/i-00ddea272445bd4ec" => <computed>
      associate_public_ip_address:       "true" => <computed>
      availability_zone:                 "us-east-1a" => <computed>
      cpu_core_count:                    "1" => <computed>
      cpu_threads_per_core:              "1" => <computed>
      ebs_block_device.#:                "0" => <computed>
      ephemeral_block_device.#:          "0" => <computed>
      get_password_data:                 "false" => "false"
      instance_state:                    "running" => <computed>
      instance_type:                     "t1.micro" => "t1.micro"
      ipv6_address_count:                "" => <computed>
      ipv6_addresses.#:                  "0" => <computed>
      key_name:                          "web-admin-key" => "web-admin-key"
      network_interface.#:               "0" => <computed>
      network_interface_id:              "eni-0e92356540e1a2f47" => <computed>
      password_data:                     "" => <computed>
      placement_group:                   "" => <computed>
      primary_network_interface_id:      "eni-0e92356540e1a2f47" => <computed>
      private_dns:                       "ip-172-31-38-119.ec2.internal" => <computed>
      private_ip:                        "172.31.38.119" => <computed>
      public_dns:                        "ec2-35-173-130-100.compute-1.amazonaws.com" => <computed>
      public_ip:                         "35.173.130.100" => <computed>
      root_block_device.#:               "1" => <computed>
      security_groups.#:                 "1" => <computed>
      source_dest_check:                 "true" => "true"
      subnet_id:                         "subnet-d363e58f" => <computed>
      tags.%:                            "1" => "1"
      tags.Name:                         "demo-server" => "demo-server"
      tenancy:                           "default" => <computed>
      volume_tags.%:                     "0" => <computed>
      vpc_security_group_ids.#:          "1" => "1"
      vpc_security_group_ids.3215502186: "sg-04b81bcdfa7f287b0" => "sg-04b81bcdfa7f287b0"


Plan: 1 to add, 0 to change, 1 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.

Releasing state lock. This may take a few moments...

```

## Terraform Apply
Terraform apply is command which creates the resources for us. The output will look similar to `terraform plan` but this time you will be prompted for permisson on your console. The output is truncated from the original.

`Example`

```
aws_security_group.webserver_sg: Refreshing state... (ID: sg-04b81bcdfa7f287b0)
aws_key_pair.webserver_key: Refreshing state... (ID: web-admin-key)
aws_instance.webserver: Refreshing state... (ID: i-00ddea272445bd4ec)

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
-/+ destroy and then create replacement

Terraform will perform the following actions:

-/+ aws_instance.webserver (tainted) (new resource required)
      id:                                "i-00ddea272445bd4ec" => <computed> (forces new resource)
      ami:                               "ami-408c7f28" => "ami-408c7f28"
      arn:                               "arn:aws:ec2:us-east-1:822941572458:instance/
      [...]
      volume_tags.%:                     "0" => <computed>
      vpc_security_group_ids.#:          "1" => "1"
      vpc_security_group_ids.3215502186: "sg-04b81bcdfa7f287b0" => "sg-04b81bcdfa7f287b0"


Plan: 1 to add, 0 to change, 1 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_instance.webserver: Destroying... (ID: i-00ddea272445bd4ec)
aws_instance.webserver: Destruction complete after 49s
[...]
```

## Terraform Destroy  
This command will delete everything that terraform manages for you. So we need to be really careful when we run this command and only run it when you know what you are doing. 

`Example`

```
terraform destroy

[output]
Acquiring state lock. This may take a few moments...
aws_security_group.webserver_sg: Refreshing state... (ID: sg-04b81bcdfa7f287b0)
aws_key_pair.webserver_key: Refreshing state... (ID: web-admin-key)
aws_instance.webserver: Refreshing state... (ID: i-04264d266661e096d)

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  - aws_instance.webserver

  - aws_key_pair.webserver_key

  - aws_security_group.webserver_sg


Plan: 0 to add, 0 to change, 3 to destroy.

Do you really want to destroy?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes
  [...]
```
## Terraform init
The terraform init command is used to initialize a working directory containing Terraform configuration files. This is the first command that should be run after writing a new Terraform configuration or cloning an existing one from version control. It is safe to run this command multiple times.

`Example`

```
terraform init

[Output]

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

## Terraform fmt
The terraform fmt command is used to rewrite Terraform configuration files to a canonical format and style.
