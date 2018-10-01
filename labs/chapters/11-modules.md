## Modules

Modules will help you to package your Terraform configurations in to groups. This will help us to organize our code in a better way. In fact, when you run terraform apply, the current working directory holding the Terraform files you're applying comprise what is called the `root module`.

Modules are meant to be reused. Thats why it is recommended to abstract the data from code.

### Creating our first module

So far, we have created 4 files in total which are namely,  

  * main.tf  
  * variables.tf  
  * backend.tf  
  * user-data.sh  

Let us convert this into a module. Remember, variables file will not be part of module.

