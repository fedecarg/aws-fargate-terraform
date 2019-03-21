# Terraform

[Terraform](https://www.terraform.io/) is a very simple, yet powerful tool that allows you to write your stack as code, then share it and keep it up-to-date by committing the definition files using Git. Terraform is created by HashiCorp, the authors of popular open-source tools such as Vagrant and Packer.

# Initial setup

* Install Terraform:
    - `brew install terraform`
* Install the AWS CLI:
    - `brew install awscli`
* Create a new AWS profile:
    - `aws configure --profile federico`

Before Terraform can start your infrastructure you need to configure the provider:

### Using a custom profile
```
provider "aws" {
  version = "~> 1.19"
  region  = "${var.aws_region}"
  profile  = "${var.aws_profile}"
}
```

### Using static credentials
```
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}
```

More info here: https://www.terraform.io/docs/providers/aws/

# Build infrastructure

* Create a [backend](https://www.terraform.io/docs/backends/):
    - `terraform/backend/plan <env>`
    - `terraform/backend/apply <env>`

## Create environment 

* Create Terraform var file in `terraform/environment/<env>.tfvars`

* Initialise a working directory containing Terraform configuration files:
    - `terraform/init <env>`

## Provision resources

* Sync with remote state and create an execution plan:
    - `terraform/plan <env>`
* Apply the changes required to reach the desired state of the configuration:
    - `terraform/apply <env>`

## Destroy environment

To destroy, please refer to https://www.terraform.io/intro/getting-started/destroy.html ☠️

# Using CircleCI
CircleCI Workflows support complex job orchestration using a simple set of [configuration keys](circle-ci/config.yaml) to help you resolve failures sooner.

You can trigger a CircleCI job by creating and pushing a tag:
```
$ npm version <patch|minor|major> -m "Upgrade to version %s"
$ git push origin <version>
```

Or, you can execute the following bash script:
```
$ sh scripts/circleci-deploy.sh --version <patch|minor|major>
To github.com:fedecarg/example-app.git
 * [new tag]         v0.1.00 -> v0.1.00
Deploying tag v0.1.00 ...
```
