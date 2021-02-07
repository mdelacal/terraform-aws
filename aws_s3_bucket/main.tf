# Private Bucket with tags
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#private-bucket-w-tags
resource "aws_s3_bucket" "tf-bucket-miguel" {
  bucket = "tf-bucket-miguel"
  acl    = "private"

  tags = {
    Description = "Bucket created with Terraform"
    Environment = "Test"
  }
}


# Uploading a file to a bucket:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object#uploading-a-file-to-a-bucket
resource "aws_s3_bucket_object" "provider_object" {
  bucket = "tf-bucket-miguel"
  key    = "provider.tf"
  source = "./provider.tf"
}

resource "aws_s3_bucket_object" "main_object" {
  bucket = "tf-bucket-miguel"
  key    = "main.tf"
  source = "./main.tf"
}
