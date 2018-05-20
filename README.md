Launch a WordPress Site Through Terraform

AWS docs provide a step to step guide for launching a WordPress site on the free tier membership: - https://aws.amazon.com/getting-started/tutorials/launch-a-wordpress-website/

These scripts perform this above setup, all in one go. Please install the Terraform client, and run 'terraform apply', to build the WordPress infrastructure.

These scripts will:

- Create a Linux instance with the Bitnami AMI (t2.micro).
- Create the same Security Groups used in the guide.
- Create a Key Pair, so that you can SSH into your Linux Instance.
- Create an S3 Bucket, and sync all of your WordPress Files here.

The hostname of your instance will be output into the console. Please use this hostname/computer name to SSH into the Linux Instance. I use Putty to SSH into my instances from a Window machine. Putty can be downloaded from here:

- https://www.putty.org/

The only changes that need performing on the scripts are:

- Fill in your AWS access key into the 'AWS_Keys_And_Region' file.
- Fill in your AWS secret key into the 'AWS_Keys_And_Region' file.
- Fill in your region into the 'AWS_Keys_And_Region' file.
- Generate a public key and place is in the '/SSH_Keys/Public' folder.
- Generate a private key (using your public key), and place it in the '/SSH_Keys/Private' folder

Public keys can be generated from 'PuTTYgen' (Comes with the download of the PuTTY client). Private keys are created from your public keys. See the following guide for help on this.

- https://docs.joyent.com/public-cloud/getting-started/ssh-keys/generating-an-ssh-key-manually/manually-generating-your-ssh-key-in-windows
