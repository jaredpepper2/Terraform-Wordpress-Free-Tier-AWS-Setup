
// Enter the Path to where your generated Public Key is stored. Please fill in the path value (Directory of your Terraform Project).
variable "path" {
   default = "XXXXXXX\\SSH_Keys\\Public\\WP_ec2_key"
}

// Public Key
variable "Publlic_Key_Name" {
   default = "WP_ec2_key"
}
