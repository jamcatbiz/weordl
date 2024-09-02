# Weordl

Weordl is a daily free to play anagram word game. It is a web app built using SvelteKit for frontend, terraform for backend via AWS CloudFront -> S3 origin, and github actions CI/CD for orchestrating infrastructure and application workflows like building, deploying, and reporting. This repo only deploys the S3 backend origin, not the serving CDN.

## Table of Contents

- [Usage](#usage)
- [Contributing](#contributing)

## Usage

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

This repo contains a `./infra/` folder with a terraform/opentofu project for configuring an s3 bucket to be an origin for some externally managed CDN, in our case AWS CloudFront.

Project can easily be run locally, but a workflow `./github/workflows/deploy.yml` is provided for continuous deployment with a trunk based development/release paradigm.

## Contributing

Not actively looking for contributions, but feel free to contact me with questions or commments. Thanks!
