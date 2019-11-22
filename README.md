# How-to-use-aws-ec2-with-ssh-key
This repo will generate ssh key and a ec2 on AWS


# Before you begin
1. You need to have an account on AWS 
2. Installed AWS cli
3. Installed Terraform cli. 
---
4. Rename the `terraform.tfvars.example` to `terraform.tfvars`
5. Put your `secret_key` and `access key` inside `terraform.tfvars`


# Installation
1. Run `terraform init`
2. Run `terraform plan` to view the plan
3. Run `terraform apply -auto-approve` to provision the instance


# Post Installation
1. Open your terminal 
2. Run `ssh -i <your-key-name> ubuntu@<instance-ip>`, the instance ip and ssh key can be obtained by running `terraform output`

# More Information
https://github.com/terraform-providers/terraform-provider-aws/tree/master/examples

https://medium.com/@hmalgewatta/setting-up-an-aws-ec2-instance-with-ssh-access-using-terraform-c336c812322f




