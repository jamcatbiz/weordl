# Weordl

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

Weordl is a daily free to play anagram word game. It is a web app built using SvelteKit for frontend, terraform for backend via AWS CloudFront -> S3 origin, and github actions CI/CD for infra and app.

## Table of Contents

- [Background](#background)
- [Install](#install)
- [Infrastructure](#infrastructure)
- [Application](#application)
- [License](#license)

## Background

The infrastructure as code for this app configures a standard cloudfront/s3 SPA with simple caching rules, but it assumes the account is already configured with a Route53 public hosted zone, terraform state buckets, ACM certificate all pre-created, and IAM roles for deployment and reporting.  This IaC was designed to support multiple environments across  multiple accounts. Terraform *.tfvars*  and *.s3.tfbackend* files should all have a prefix that matches a GitHub environment. See the terraform dir for full docs.

The GitHub Actions Workflow files support validating and deploying infrastructure; building, validating, and deploying application code to s3; and cache busting. GitHub environments must exist to support  the following variables:
- AWS_REGION: the target region hosting resources and endpoints
- AWS_DEPLOY_ROLE: the role GitHub Actions will assume to deploy via OIDC. Contains account id information.
- AWS_READ_ROLE: the role GitHub Actions will assume to read for reporting via OIDC. Contains account id information. 

This  repo would be a good quickstart for simple svelte SPAs hosted on AWS S3 with infrastructure, builds, and deployments managed within GitHub Actions.

## Usage

### Repository layout

    .
    ├── .github/workflows       # CI/CD orchestration
    ├── app                     # Application code
    ├── terraform               # Infrastructure as code, .tf files
    │   ├── config              # .tfvars and .s3.tfbackend files
    │   └── templates           # .json files or .json template files
    ├── LICENSE
    └── README.md

### Developing Application Code

Navigate to the `./app` folder

Once you've installed dependencies with `npm install` (or `pnpm install` or `yarn`), start a development server:

```bash
npm run dev

# or start the server and open the app in a new browser tab
npm run dev -- --open
```

### Building for S3 Hosting

```bash
npm run build
```

### Developing and Deploying Infrastructure

Navigate to the `./terraform` folder

Make sure  terraform is installed. This code was tested with import blocks on v1.6.6, so make sure you're using the intended resources and versions. Set up your shell to whatever AWS account you would like to deploy to, edit the `.tfvars` and `.s3.tfbackend` files to target your environment, and run the terraform workflows: init, plan, apply.

See the GitHub Actions workflow files for more details on deploy process.

## Contributing

Not actively looking for contributions, but feel free to contact me with questions or commments.