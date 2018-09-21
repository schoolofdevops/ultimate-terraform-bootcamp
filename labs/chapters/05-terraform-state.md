## Terraform State
One advantage, Terraform has over other configuration management tools like Ansible and Chef is State management. Terraform stores all our infrastructure information(that we have created using Terraform) in a file with the name `terraform.tfstate`. 

In the last chapter, we have ran `terraform apply`. This command would create the above mentioned JSON flavoured statefile. Let us look at its the content.

`terraform.tfstate`
```
{
    "version": 3,
    "terraform_version": "0.11.7",
    "serial": 1,
    "lineage": "138bb0c6-ca69-0d39-aa90-5e08f29c8efb",
    "modules": [
        {
            "path": [
                "root"
            ],
            "outputs": {},
            "resources": {
                "aws_instance.webserver": {
                    "type": "aws_instance",
                    "depends_on": [],
                    "primary": {
                        "id": "i-02489cdf638f05bbd",
                        "attributes": {
                            "ami": "ami-408c7f28",
                            "arn": "arn:aws:ec2:us-east-1:822941572458:instance/i-02489cdf638f05bbd",
                            "associate_public_ip_address": "true",
                            "availability_zone": "us-east-1d",
                            "cpu_core_count": "1",
                            "cpu_threads_per_core": "1",
                            "credit_specification.#": "1",
                            "credit_specification.0.cpu_credits": "standard",
                            "disable_api_termination": "false",
                            "ebs_block_device.#": "0",
                            "ebs_optimized": "false",
                            "ephemeral_block_device.#": "0",
                            "get_password_data": "false",
                            "iam_instance_profile": "",
                            "id": "i-02489cdf638f05bbd",
                            "instance_state": "running",
                            "instance_type": "t1.micro",
                            "ipv6_addresses.#": "0",
                            "key_name": "",
                            "monitoring": "false",
                            "network_interface.#": "0",
                            "network_interface_id": "eni-00fbc08209349bb38",
                            "password_data": "",
                            "placement_group": "",
                            "primary_network_interface_id": "eni-00fbc08209349bb38",
                            "private_dns": "ip-172-31-24-184.ec2.internal",
                            "private_ip": "172.31.24.184",
                            "public_dns": "ec2-34-230-78-138.compute-1.amazonaws.com",
                            "public_ip": "34.230.78.138",
                            "root_block_device.#": "1",
                            "root_block_device.0.delete_on_termination": "true",
                            "root_block_device.0.iops": "0",
                            "root_block_device.0.volume_id": "vol-0cc495c189e5c8dd2",
                            "root_block_device.0.volume_size": "8",
                            "root_block_device.0.volume_type": "standard",
                            "security_groups.#": "1",
                            "security_groups.3814588639": "default",
                            "source_dest_check": "true",
                            "subnet_id": "subnet-e8b3e6a2",
                            "tags.%": "0",
                            "tenancy": "default",
                            "volume_tags.%": "0",
                            "vpc_security_group_ids.#": "1",
                            "vpc_security_group_ids.3314100969": "sg-a42b7ae9"
                        },
                        "meta": {
                            "e2bfb730-ecaa-11e6-8f88-34363bc7c4c0": {
                                "create": 600000000000,
                                "delete": 1200000000000,
                                "update": 600000000000
                            },
                            "schema_version": "1"
                        },
                        "tainted": false
                    },
                    "deposed": [],
                    "provider": "provider.aws"
                }
            },
            "depends_on": []
        }
    ]
}
```

### Usecase 1
This file contains the metadata of our ec2 instance that we have created in the last chapter. This information will be critical when we have to create `other resources which references this` ec2 instance. As we add more resources to the terrform template, this file will get populated with more metadata about each resource.

### Usecase 2
What happens when someone manually changes(which is not desirable) the properties of the instance created by Terraform? We can undo the manual changes just by running `terraform apply` again. One point to keep in mind though is, some property changes forces resource recreation which might result in data loss.