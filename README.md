# Next.js on AWS S3 and CloudFront

A Next.js app hosted on AWS S3 and served through CloudFront, with infrastructure managed by Terraform and automated deployment using GitHub Actions.

## Infrastructure

Terraform in `terraform/` creates a private S3 bucket, a CloudFront distribution, and access controls that let CloudFront read the app files. CloudFront serves the app over HTTPS.

## CI/CD

Every push to `main` triggers `.github/workflows/deploy.yml`:

- **CI:** Install dependencies with `npm ci` and build the app with `npm run build`, generating static files in `out/`.
- **CD:** Authenticate with AWS, sync the built files to S3, and invalidate CloudFront's cache.

## Local development

```bash
npm ci
npm run dev
```

Open [localhost:3000](http://localhost:3000).
