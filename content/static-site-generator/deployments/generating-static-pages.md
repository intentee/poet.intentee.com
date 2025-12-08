+++
description = "Generate static HTML files from your Poet project for deployment to any hosting provider."
layout = "LayoutDocumentationPage"
primary_collection = "docs"
title = "Generating static pages"

[[collection]]
name = "docs"
after = "static-site-generator/deployments/index"
parent = "static-site-generator/deployments/index"

[[collection]]
name = "create_content"
+++

When you're ready to deploy your site, use the `make static-pages` command to generate static HTML files:
```bash
poet make static-pages <source_directory> --output-directory <output_dir> --public-path <base_url>
```

For example:
```bash
poet make static-pages . --output-directory ./public --public-path "https://example.com/"
```

## Parameters

- `&lt;source_directory&gt;` - the path to your Poet project (use `.` for the current directory). This directory must already exist.
- `--output-directory` - where to write the generated HTML files. This directory will be created if it doesn't exist.
- `--public-path` - the base URL path for your site 

## What gets generated

The command compiles your shortcodes, processes all markdown content, and outputs static HTML files along with your assets. The output folder is self-contained and can be deployed to any static hosting provider.
