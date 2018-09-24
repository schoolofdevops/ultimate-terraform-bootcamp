## Resources - Part 2

The ec2 instance that we have created is not that useful when we don't have access to it. So let us delete it and  we shall set up this again with additional resources. 

Let us create a security group, which allows us to ssh(port 22) into the machine.

`file: main.tf`
```
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "webserver" {
  ami           = "ami-408c7f28"
  instance_type = "t1.micro"
}

resource "aws_security_group" "webserver_sg" {

	name = "webserver-sg"

	ingress {
		from_port   = 22
		to_port     = 22
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
}
```

Here,
  Resource type = aws_security_group,
  Resource name = webserver_sg

This `aws_security_group` resource allows us to ssh into the instance.

We need to create the EC2 instance with this security group. To do that, 

The final requirement is a `key pair` using which we can login to the machine. Let us use [aws_key_pair](https://www.terraform.io/docs/providers/aws/r/key_pair.html) to register the key with AWS and then use in our ec2 instance.

To do this, you will need to create a key pair in your local machine. Run the following commands. This will create one public key and a private key.

```
root@vibe$ ssh-keygen -t rsa

[output]
Generating public/private rsa key pair.
Enter file in which to save the key (/home/vibe/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/vibe/.ssh/id_rsa.
Your public key has been saved in /home/vibe/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:nSnSLKDvnLv22LFX+wKYMa0TvSt3AL406z+Asj/GSak vibe@vibes-MacBook-Air.local
The key's randomart image is:
+---[RSA 2048]----+
|                 |
|                 |
|    .  o         |
|   . .=oo. o     |
|  .  +oOS.+      |
|  ..+ Xo+..      |
|   *.o.* = .     |
|  Eo*++o= +      |
|   +O*==.o o.    |
+----[SHA256]-----+
```

Copy the content of your public key
```
cat ~/.ssh/id_rsa.pub

[output]
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4Q2TBuAD7ijkPjp+/Hl/QnrNo4hoZEz/l+UBsfvlDuJk8zfh0ivnQLtoYyXNuJ3/BjTVVIchrGo8CLZdTco//n+YBvMqgW4Wg5F92JNNkR5L5x04ELRUmC3ed1ZqbwrLmujzB33nMJ8Ld5dJjtS55KJa5MwkCaP7lqGicU2NgXe+if2DhCKW/lZyCpkkvRgmB7oEqj6aBWNjp+FMY4v6BtcmmB/+1Ry+GMvmZJO1EjSeUHAWCec3snX7TxJKHf4opwTHxknmhRKkz8+pS8rxyjiBeyncxP9jL9Tx/Zh6qmExCUfuhAWk87sjbb3j0enVs2LtzJOG9eBZ726wD83TJ vibe@vibes-MacBook-Air.local
```

Paste the content of public key in the public_key

`file: main.tf`
```
[...]

resource "aws_security_group" "webserver_sg" {

	name = "webserver-sg"

	ingress {
		from_port   = 22
		to_port     = 22
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
}

resource "aws_key_pair" "webserver_key" {
  key_name   = "web-admin-key"
  public_key = "ssh-rsa sh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4Q2TBuAD7ijkPjp+/Hl/QnrNo4hoZEz/l+UBsfvlDuJk8zfh0ivnQLtoYyXNuJ3/BjTVVIchrGo8CLZdTco//n+YBvMqgW4Wg5F92JNNkR5L5x04ELRUmC3ed1ZqbwrLmujzB33nMJ8Ld5dJjtS55KJa5MwkCaP7lqGicU2NgXe+if2DhCKW/lZyCpkkvRgmB7oEqj6aBWNjp+FMY4v6BtcmmB/+1Ry+GMvmZJO1EjSeUHAWCec3snX7TxJKHf4opwTHxknmhRKkz8+pS8rxyjiBeyncxP9jL9Tx/Zh6qmExCUfuhAWk87sjbb3j0enVs2LtzJOG9eBZ726wD83TJ vibe@vibes-MacBook-Air.local
}
```

We need to make sure our instance uses this key. To do that, we should add one more attribute to our `aws_instance` module. We will also tag the instace with a name.

`file: main.tf`
```
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "webserver" {
  ami           = "ami-408c7f28"
  instance_type = "t1.micro"
  key_name      = "web-admin-key"

  tags {
    Name = "weberserver"
  }
}

[...]
```

The final file shoudl look like the following.

```
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "webserver" {
  ami           = "ami-408c7f28"
  instance_type = "t1.micro"
  key_name      = "web-admin-key"

  tags {
    Name = "weberserver"
  }
}

resource "aws_security_group" "webserver_sg" {

        name = "webserver-sg"

        ingress {
                from_port   = 22
                to_port     = 22
                protocol    = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }
}

resource "aws_key_pair" "webserver_key" {
  key_name   = "web-admin-key"
  public_key = "ssh-rsa sh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4Q2TBuAD7ijkPjp+/Hl/QnrNo4hoZEz/l+UBsfvlDuJk8zfh0ivnQLtoYyXNuJ3/BjTVVIchrGo8CLZdTco//n+YBvMqgW4Wg5F92JNNkR5L5x04ELRUmC3ed1ZqbwrLmujzB33nMJ8Ld5dJjtS55KJa5MwkCaP7lqGicU2NgXe+if2DhCKW/lZyCpkkvRgmB7oEqj6aBWNjp+FMY4v6BtcmmB/+1Ry+GMvmZJO1EjSeUHAWCec3snX7TxJKHf4opwTHxknmhRKkz8+pS8rxyjiBeyncxP9jL9Tx/Zh6qmExCUfuhAWk87sjbb3j0enVs2LtzJOG9eBZ726wD83TJ vibe@vibes-MacBook-Air.local"
}
```

### Explicit Dependency
When we apply the manifest, we will get the following error.

```
terraform apply

[output]
aws_security_group.webserver_sg: Still creating... (10s elapsed)
aws_security_group.webserver_sg: Creation complete after 11s (ID: sg-0c22a3497351d1caa)

Error: Error applying plan:

2 error(s) occurred:

* aws_instance.webserver: 1 error(s) occurred:

* aws_instance.webserver: Error launching source instance: InvalidKeyPair.NotFound: The key pair 'web-admin-key' does not exist
	status code: 400, request id: 36af6c0c-9016-4dc4-bd3a-7b94fc3dfade
* aws_key_pair.webserver_key: 1 error(s) occurred:

* aws_key_pair.webserver_key: Error import KeyPair: InvalidKey.Format: Key is not in valid OpenSSH public key format
	status code: 400, request id: 8a3697d2-4450-4150-86e0-3b75c0d43b80

Terraform does not automatically rollback in the face of errors.
Instead, your Terraform state file has been partially updated with
any resources that successfully completed. Please address the error
above and apply again to incrementally change your infrastructure.
```

This is because, the ec2 resource tries to use the key even before it is created. We can control the order of execution in two ways.
  1. Implicit Dependecy (Automatic Dependency)  
  2. Explicit Dependency (Manual Dependency)  

We will learn more about `Implicit Dependency` in the next chapter. Now we will focus on adding `Explicit Dependency` to *aws_instance* resource to depend on *aws_key_pair* resource.

This will guarantee the creation of key pair before the instance get's created. In your instance block add the following,

`file: main.tf`
```
[...]
resource "aws_instance" "webserver" {
  ami           = "ami-408c7f28"
  instance_type = "t1.micro"
  key_name      = "web-admin-key"

  depends_on = ["aws_key_pair.webserver_key"]
  tags {
    Name = "weberserver"
  }
}
[...]
```

Syntax: `depends_on = ["resource_type.resource_name"]`

### Idempotency

Finally apply the manifest by running,

```
terraform apply

[output]
Plan: 2 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_key_pair.webserver_key: Creating...
  fingerprint: "" => "<computed>"
  key_name:    "" => "web-admin-key"
  public_key:  "" => "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4Q2TBuAD7ijkPjp+/Hl/QnrNo4hoZEz/l+UBsfvlDuJk8zfh0ivnQLtoYyXNuJ3/BjTVVIchrGo8CLZdTco//n+YBvMqgW4Wg5F92JNNkR5L5x04ELRUmC3ed1ZqbwrLmujzB33nMJ8Ld5dJjtS55KJa5MwkCaP7lqGicU2NgXe+if2DhCKW/lZyCpkkvRgmB7oEqj6aBWNjp+FMY4v6BtcmmB/+1Ry+GMvmZJO1EjSeUHAWCec3snX7TxJKHf4opwTHxknmhRKkz8+pS8rxyjiBeyncxP9jL9Tx/Zh6qmExCUfuhAWk87sjbb3j0enVs2LtzJOG9eBZ726wD83TJ vibe@vibes-MacBook-Air.local"
aws_key_pair.webserver_key: Creation complete after 3s (ID: web-admin-key)
aws_instance.webserver: Creating...
  ami:                          "" => "ami-408c7f28"
  arn:                          "" => "<computed>"
  associate_public_ip_address:  "" => "<computed>"
  availability_zone:            "" => "<computed>"
  cpu_core_count:               "" => "<computed>"
  cpu_threads_per_core:         "" => "<computed>"
  ebs_block_device.#:           "" => "<computed>"
  ephemeral_block_device.#:     "" => "<computed>"
  get_password_data:            "" => "false"
  instance_state:               "" => "<computed>"
  instance_type:                "" => "t1.micro"
  ipv6_address_count:           "" => "<computed>"
  ipv6_addresses.#:             "" => "<computed>"
  key_name:                     "" => "web-admin-key"
  network_interface.#:          "" => "<computed>"
  network_interface_id:         "" => "<computed>"
  password_data:                "" => "<computed>"
  placement_group:              "" => "<computed>"
  primary_network_interface_id: "" => "<computed>"
  private_dns:                  "" => "<computed>"
  private_ip:                   "" => "<computed>"
  public_dns:                   "" => "<computed>"
  public_ip:                    "" => "<computed>"
  root_block_device.#:          "" => "<computed>"
  security_groups.#:            "" => "<computed>"
  source_dest_check:            "" => "true"
  subnet_id:                    "" => "<computed>"
  tags.%:                       "" => "1"
  tags.Name:                    "" => "weberserver"
  tenancy:                      "" => "<computed>"
  volume_tags.%:                "" => "<computed>"
  vpc_security_group_ids.#:     "" => "<computed>"
aws_instance.webserver: Still creating... (10s elapsed)
aws_instance.webserver: Still creating... (20s elapsed)
aws_instance.webserver: Still creating... (30s elapsed)
aws_instance.webserver: Creation complete after 37s (ID: i-0a7d259b3126e16b8)

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
```

If you have noticed, Terraform did not create the security group this time around. The reason for this behaviour is, it had created the security group resource in the first run itself. So it did not create the same resource again when we applied the second time. This behaviour is called `Idempotency`.