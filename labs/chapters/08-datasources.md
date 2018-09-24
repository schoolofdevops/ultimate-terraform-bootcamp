## Data Source

Data sources are read only information that Terraform can get from Provider's API. When we use data source, Terraform doesn't create/modify anything. It just queries the API, so that the data can be used by other resources.

Let us create a ELB which will loadbalance our application which we are gonna deploy in the next chapter.

`file: main.tf`
```
resource "aws_elb" "demo-elb" {
	name = 
}
```