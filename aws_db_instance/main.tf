# Basic Usage
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance#basic-usage
resource "aws_db_instance" "tf-rds-miguel" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  identifier           = "tfrdsmiguel"
  name                 = "tfrdsmiguel"
  username             = "miguel"
  password             = "Passw0rd!"
  parameter_group_name = "default.mysql5.7"

  # Do not create a final snapshot on DB delete
  skip_final_snapshot  = "true"

  # Public access
  publicly_accessible  = "true"

  tags = {
    Description = "RDS created with Terraform"
    Environment = "Test"
  }
}
