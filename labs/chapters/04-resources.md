## Resources

Resources are the building block in Terraform. These the actual cloud entities that you are either creating/deleting or modifying. To do so, you will have to define them in a terraform manifest and apply them. 

### Creating our first Resource

Let us create an EC2 instance, which is going to be our first resource on AWS using Terraform. 

Every resorce has the following syntax.

`resource syntax`
```
resource "resource_type" "resource_name" {
  config1 = value1
  config2 = value2
}
```
Here, 
  resource_type = The type of the resouce that we create/delete/modfiy
  resource_name = Give the resource a name for Terraform internal references.
  config(1-n)   = The properties of the reosurce your manipulating.

In your main.tf, add this block next to your Provider definition. 

`an ec2 resource`
```
resource "aws_instance" "webserver" {
  ami           = "ami-408c7f28"
  instance_type = "t1.micro"
}
```
Here, to compare it with the syntax,
  resource_type = aws_instance
  resource_name = webserver
  config1       = ami
  value1        = ami-408c7f28(ubuntu-14.04)
  config2       = instance_type
  value2        = t1.micro

Your `main.tf` file should look like the following. 

```
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "webserver" {
  ami           = "ami-408c7f28"
  instance_type = "t1.micro"
}
```

### Terraform Plan

Then run `terraform plan` to see what will happen if we apply the manifest.

```
terraform plan

[output]
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.


------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  + aws_instance.webserver
      id:                           <computed>
      ami:                          "ami-408c7f28"
      arn:                          <computed>
      associate_public_ip_address:  <computed>
      availability_zone:            <computed>
      cpu_core_count:               <computed>
      cpu_threads_per_core:         <computed>
      ebs_block_device.#:           <computed>
      ephemeral_block_device.#:     <computed>
      get_password_data:            "false"
      instance_state:               <computed>
      instance_type:                "t1.micro"
[...]

Plan: 1 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.
```

### Terraform Apply

Then run, `terraform apply` to actually create the resource on AWS.

```
terraform apply

[output]
[...]
aws_instance.webserver: Still creating... (10s elapsed)
aws_instance.webserver: Still creating... (20s elapsed)
aws_instance.webserver: Still creating... (30s elapsed)
aws_instance.webserver: Still creating... (40s elapsed)
aws_instance.webserver: Creation complete after 49s (ID: i-02489cdf638f05bbd)

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

We have successfully created our first reosource on AWS. Please check your AWS console to check the properties(AMI and instance type) of the machine.

![terraform apply](./images/04-resources-apply.png)

## Resource Lifecycles  

In Terraform, a resource can be,  
  * Created (+)  
  * Destroyed (-)  
  * Recreated (-/+) or  
  * Updated (~)  
Like in the previous example, when Terraform creates a resource, it represents it with `+` symbol. Similarly Destroy, Recreate and Modify are represented with `-`, `-/+` and `~` respectively.  

### Resource Update  
Let us see what happens when we apply a tag to the instance from `main.tf`.  
`file: main.tf`
```
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "webserver" {
  ami           = "ami-408c7f28"
  instance_type = "t1.micro"

  tags {
    Name = "instance-01"
  }
}
```
We have added a tag block with in *aws_instance* resource which will add the name `instance-01` for our EC2 instance.

```
terraform plan
terraform apply

[output]
Acquiring state lock. This may take a few moments...
aws_instance.webserver: Refreshing state... (ID: i-0f6ab73cdd9d6882c)

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  ~ update in-place

Terraform will perform the following actions:

  ~ aws_instance.webserver
      tags.%:    "0" => "1"
      tags.Name: "" => "instance-01"


Plan: 0 to add, 1 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_instance.webserver: Modifying... (ID: i-0f6ab73cdd9d6882c)
  tags.%:    "0" => "1"
  tags.Name: "" => "instance-01"
aws_instance.webserver: Still modifying... (ID: i-0f6ab73cdd9d6882c, 10s elapsed)
aws_instance.webserver: Modifications complete after 12s (ID: i-0f6ab73cdd9d6882c)

Apply complete! Resources: 0 added, 1 changed, 0 destroyed.
Releasing state lock. This may take a few moments...
```  
This did not recreate the instance, but just updated it. The instance still has the same internal and external IPs and other properties.

### Resource Recreation  
Now let us change the *ami* for the instance from *ami-408c7f28*(ubuntu 14.04) to *ami-0c11a0129f63fb571*(ubuntu 16.04).  

`file: main.tf`

```
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "webserver" {
  ami           = "ami-0c11a0129f63fb571"
  instance_type = "t1.micro"

  tags {
    Name = "instance-01"
  }
}
```

## Reference  

If you need further details about resources, please visit this [link](https://www.terraform.io/docs/configuration/resources.html)