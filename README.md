# terraform-aws
Terraform automations with AWS cloud provider.

In this project you will find different directories with automations for Terraform for AWS.

## Requirements
Terraform and AWS account.

## Init, plan & apply
You just need to change to the desired directory and then run the following commands to start Terraform automations:
```
$ terraform init
$ terreform plan
$ terraform apply -auto-approve
```

## Destroy
If you want to destroy all resources created with Terraform, then you can run the following command in the same directory:
```
$ terraform destroy -auto-approve
```
