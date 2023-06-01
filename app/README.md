
# Weordl
Weordl is a daily free to play anagram word game. It is a web app built using SvelteKit for frontend, AWS CloudFront -> S3 SPA backend, and github actions CI/CD.

## Developing

Once you've installed dependencies with `npm install` (or `pnpm install` or `yarn`), start a development server:

```bash
npm run dev

# or start the server and open the app in a new browser tab
npm run dev -- --open
```

## Building

```bash
npm run build
```

This produces a *build* folder

You can preview the production build with `npm run preview`.

## Deploy

Currently hosted as a SPA with cloudfront -> s3, acm for cert, route 53 for registrar and DNS. AWS resources were made manually, state not currently managed with IaC.

Using github actions to manage uploads to s3 buckets upon pull request to master branch.