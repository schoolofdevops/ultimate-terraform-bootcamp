```
Goal in mind:
=============
  • Deploy Devops Demo app using Terraform
Outline:
========
  • providers
       |---set up credential for AWS provisioner
       |---show how terraform init works
  • backends 
       |---introduction to backends and state locking
       |---show local state file
       |---use s3+dynamo db as backend
  • resources
       |---create vpc and subnets
       |---create one ec2 resource without variables
  • variables & outputs
       |---introduction to variables
       |---create RDS resource
       |---parameterise ec2 template with variables(rds password, db name,user,pw, etc.,)
       |---print public IP of ec2 instance, rdp endpoints, etc., with outputs
  • data sources
       |---introduction to data sources
       |---use an existing AMI as reference(frontend installed)
  • provisioners
       |---introduction to provisioner
       |---file provisioner to copy the script
       |---remote-exec provisioner to execute the script(set up catalogue)
  • modules
       |---introduction to modules
       |---create a module which contains ec2 template
  • other useful terraform commands(graph, fmt, etc.,)
  • terraform with Packer(demo)
      |---creation of ami with packer
      |---use that ami in terraform
  • terraform with GCP(demo)
      |---start with GCP provider
      |---GCP backend setup
      |---Deployment of mogambo Stack on GCP
  • terraform with Azure(demo)
     |---start with Azure provider
     |---Azure backend setup
     |---Deployment of mogambo Stack on Azure
  • variable interpolation(conditionals) (advanced)
  • terraform enterprise(advanced)
  • import(advanced)
  • templates(advanced)
  • plugin development(advanced)
```