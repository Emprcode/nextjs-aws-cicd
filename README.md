# Next.js on AWS S3 and CloudFront

A production-style deployment of a Next.js app using Amazon S3, CloudFront, Terraform, and GitHub Actions.

The project demonstrates how to build a Next.js application, deploy the generated static files to a private S3 bucket, distribute them globally through CloudFront, and automate deployments using GitHub Actions with AWS OIDC authentication.

## Infrastructure

Terraform in `terraform/` creates a private S3 bucket, a CloudFront distribution, and access controls that let CloudFront read the app files. CloudFront serves the app over HTTPS.

## CI/CD

Every push to `main` triggers `.github/workflows/deploy.yml`:

- **CI:** Install dependencies with `npm ci` and build the app with `npm run build`, generating static files in `out/`.
- **CD:** Authenticate with AWS, sync the built files to S3, and invalidate CloudFront's cache.

```text
GitHub push → main
      │
      ▼
GitHub Actions
      │
      │ OIDC: assume AWS IAM role
      │ 
      ▼
Workflow steps
      │
      ├── Build Next.js
      │
      ├── S3 sync
      │
      └── CloudFront invalidation
```

The build runs on the GitHub Actions runner. The assumed IAM role provides temporary AWS credentials for S3 sync and CloudFront invalidation.

## Local development

```bash
npm ci
npm run dev
```

Open [localhost:3000](http://localhost:3000).
