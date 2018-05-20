provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_instance" "WordPress" {
  ami           = "ami-ed3e0c88"
  instance_type = "t2.micro"
  security_groups = [
    "wordpress_SG"
  ]


  connection {
            user = "${var.username}"
            type = "ssh"
            private_key = "${file(var.ppk)}"
        }

  monitoring = "true"
  key_name = "WP_ec2_key"
  depends_on = ["aws_security_group.wordpress_SG"]
}

resource "aws_security_group" "wordpress_SG" {
  name        = "wordpress_SG"
  description = "Allow all inbound traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

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

resource "aws_key_pair" "WP_ec2_key" {
  key_name = "WP_ec2_key"
  public_key = "${file(var.path)}"
}

resource "aws_s3_bucket" "wp-filesync" {
  bucket = "wp-filesync"
  acl    = "private"

  tags {
    Name        = "All Synced Wordpress Files "
    Environment = "Prod"
  }
}

output "PuttyHostName" {
  value = ["${var.username}","${aws_instance.WordPress.*.public_dns}"]
}
