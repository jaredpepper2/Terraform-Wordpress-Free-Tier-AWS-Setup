provider "aws" {
  access_key = "${var.Acccess_Key}"
  secret_key = "${var.Secret_Key}"
  region     = "${var.Region}"
}

// Creates the instance
resource "aws_instance" "WordPress" {
  ami           = "${var.AMI_ID}"
  instance_type = "${var.Instance_Size}"
  security_groups = [
    "wordpress_SG"
  ]
  monitoring = "true"
  key_name = "${var.Publlic_Key_Name}"
  depends_on = ["aws_security_group.wordpress_SG"]
}

// Creates the Security Group that will be associated to the instance. - SSH is set up on port 22.
resource "aws_security_group" "wordpress_SG" {
  name        = "wordpress_SG"
  description = "Allow all inbound traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // SSH on Port 22
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

// Creates the Key Pair that the instance will be associated with
resource "aws_key_pair" "WP_ec2_key" {
  key_name = "WP_ec2_key"
  public_key = "${file(var.path)}"
}

// An S3 bucket where all the WordPress Files can be Synced
resource "aws_s3_bucket" "wp-filesync" {
  bucket = "wp-filesync"
  acl    = "private"

  tags {
    Name        = "All Synced Wordpress Files "
    Environment = "Prod"
  }
}

// Outputs the Host name that can be used in Putty for a SSH connection
output "HostName" {
  value = ["${var.username}","${aws_instance.WordPress.*.public_dns}"]
}
