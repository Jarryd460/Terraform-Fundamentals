# Terraform-Fundamentals
An example repository of working with Terraform

### Description
Terraform is an open-source Infrastructure-As-Code software tool (IaC) that enables developers to use a high-level configuration language called HCL (HashiCorp Configuration Language) to describe the desired “end-state” cloud or on-premises infrastructure for running an application. It then generates a plan for reaching that end-state and executes the plan to provision the infrastructure. Unlike Cloud Formation (AWS), Azure Resource Manager (Microsoft Azure) and Google Cloud Deployment Manager (Google) which is specific to the cloud provider, Terraform is agnostic and can be used with multiple cloud providers. Pulumi is another agnostic IaC.

### Installation
* To install Terraform, you will require chocolately to be installed (package manager). Once installed, you can run "choco install terraform" to install Terraform.
* With Visual Studio Code, you can then install "HashiCorp Terraform" extension to help with syntax highlighting, intellisense and more.
* To install the amazon cli you can go to https://aws.amazon.com/cli/ or Google amazon cli and you should find links about how to install the cli.

### Prerequisites
* Create a user (IAM service) and add them to a user group with access to the following policies:
    * AmazonRDSFullAccess
    * AmazonEC2FullAccess
    * IAMFullAccess
    * AmazonS3FullAccess
    * AmazonDynamoDBFullAccess
    * AmazonRoute53FullAccess
* Create an access key to be used by the AWS cli (Terraform uses this same credentials when connecting to AWS).
    * Run "aws configure" in terminal.
    * Provide the access key Id and the secret access key.
    * Specify "us-east-1" as the default region and "json" as the default output format.
    * This generates your config and credentials in C:\Users\JarrydDeane\.aws.

### Terraform Exercises
* To download the provider associated with your infrastructure as code file (.tf) and to intialize terraform, go to the directory of the .tf file and run "terraform init". This will download the provider (aws for example) and other prerequisites and put them into a directory called .terraform.
* You can then run "terraform plan" which will check what is already configured on the provider and compare to what is specified in the .ts file.
* Once the results have been reviewed, you can apply them by running "terraform apply".
* To undo what has been applied, you can run "terraform destroy".

##### 02-Overview
* The main.tf is the most basic terraform configuration that you can have. It creates a EC2 instance running Ubuntu.