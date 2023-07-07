# Terraform-Fundamentals
An example repository of working with Terraform (https://developer.hashicorp.com/terraform). This repository followed https://www.youtube.com/watch?v=7xngnjfIlK4. The repository can be found at https://github.com/sidpalas/devops-directive-terraform-course.

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

##### Files and directory overview
* .terraform - contains the code of the downloaded providers specified in main.tf.
* terraform.tfstate - contains metadata about what resources and data has been deployed to the provider via terraform as well as sensitive information like database password. This can be stored locally as in this scenario or in the cloud which allows collaboration easy with other developers.
    * Terraform Cloud
    * Self-managed such as AWS
* terraform.lock.hcl - contains the specific dependencies and providers that are installed in this directory.

##### Modules
* It is a way to bundle up terraform configuration files so that they are reusable else where.
* Examples of some locations of where there modules can be found are:
    * Local path
    * Terraform registry
    * Bibucket/GitHub
    * Git repositories
    * Http urls
    * S3 and GCS buckets

##### Static Checks
* You can use various commands to validate your IaC namely:
    * terraform fmt
    * terraform validate
    * terraform plan

##### 02-Overview
* The main.tf is the most basic terraform configuration that you can have. It creates a EC2 instance running Ubuntu.

##### 03-Basics
###### aws-backend
* The main.tf setups an S3 bucket as well as a Dynamo DB to host and manage the terraform.tfstate file so that multiple people cannot run apply at the same time and cause unwanted results.
* To do the above, we need to do some bootstrapping.
    * We first apply the file with the backend section left out.
    * We then add the backend section and run init.
###### terraform-cloud-backend
* The main.tf hosts the terraform.tfstate file on terraform cloud platform.
##### 04-variables-and-outputs
* The main.tf local variables which are used in specifying the resources to create
* We also create a variables.tf file that holds all our input variables that we have declared.
* The values for those variables are set in terraform.tfvars (terraform looks for this file by default) but can also be set in any other file. You will need to explicity specify the file using -var-file={file path}
    * You can also set variables via environment variables by using TF_VAR_{variable name}
    * Another approach is to use *.auto.tfvars
    * YOu can also set variables using -var="myvariable=variablevalue" -var="myvariable2=variable2value"

##### 05-language-features
* Contains a README.md file specifying the expressions and functions supported by terraform.

##### 06-Organization-and-modules
* Modules are a way to bundle up common deployment structures than can be reused with slight differences which can be exposed via variables.
* main.tf from consul consumes a module from consul from git
* web-app-module encapsulates the common configuration we want to deploy with various variables exposed so that we can slightly changed the naming and configuration of various resources.
* web-app consumes web-app-module and deploys to apps and specifies the values for the various exposed values.

##### 07-Managing-multiple-environments
###### Workspaces
* Worspaces are a way to deploy and manage mulitple environments. 
* The advantages are:
    * Easy to get started.
    * Convenient terraform.workspace expression.
    * Minimizes code duplication.
* The disadvantages are:
    * Prone to human error. You could be on the incorrect workspace and deploy to wrong environment.
    * State stored within same backend.
    * Codebase doesn't unambiguously show deployment configurations.
* Using workspaces we deploy our application to multiple environments. Depending on the workspace enviornment you will see that there are checks for production and then anything else named.
* To view your workspaces run "terraform workspace list".
* To create a new workspace run "terraform workspace new {workspace name}".
* To destroy a workspace run "terraform destroy".
* To switch to a different workspace run "terraform workspace select {workspace name}".
###### File-Structure
* You can use the file structure approach to manage multiple environments as well.
* The advantages are:
    * Isolation of backends.
        * Improved security.
        * Decreased potential for human error.
    * Codebase fully represents deployed state.
* The disadvantages are:
    * Multiple terraform apply required to provision environments
    * More code duplication, but can be minimized with modules.

##### 08-Testing
* You need to ensure that your IaC is correct which means it requires some level of testing.
* You can test by doing some static checking. See README.md.
* You could also automate testing by creating a script file and have that execute your init, plan, apply and destroy terraform commands.
* Another approach is to use terratest with Go as the programming language and rewrite the above script.

##### Other tools
* Cloud-nuke is a tool for cleaning up all resources for an account so that you not charged for resources not used.
* Terragrunt is a wrapper library for terraform which provides additional tools and capabilities.
