+++
description = "Use a ready to use script to deploy your project to GitHub Pages."
layout = "LayoutDocumentationPage"
primary_collection = "docs"
title = "GitHub Pages"

[[collection]]
name = "docs"
after = "static-site-generator/deployments/index"
parent = "static-site-generator/deployments/index"

[[collection]]
name = "create_content"
+++

If you started your Poet project from one of our templates ([template minimal](https://github.com/intentee/poet-template-minimal) or [template docs](https://github.com/intentee/poet-template-docs)), you can use the script below to deploy your site to GitHub Pages:

```yaml
name: Deploy Poet to GitHub Pages

on:
  workflow_dispatch:
  push:
    branches:
      - main

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: true

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Setup Pages
        uses: actions/configure-pages@v5

      - name: Install Poet
        uses: taiki-e/cache-cargo-install-action@v2
        with:
          tool: poet@0.3.0

      - name: Build with Poet
        run: make public

      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: ./public

  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```
