+++
description = "Start your first Poet project by copying a GitHub template and running the local development server."
layout = "LayoutDocumentationPage"
primary_collection = "docs"
title = "Starting out with a template project"

[[collection]]
name = "docs"
parent = "static-site-generator/starting-out/index"

[[collection]]
name = "create_content"
+++

The easiest way to start a project with Poet is to use one of the template repositories you can find on our GitHub. We currently provide two templates:

- [Minimal template](https://github.com/intentee/poet-template-minimal), a basic template with no content. We will be using this template throughout Poet's documentation to guide you through the process of creating content step by step.
- [Documentation template](https://github.com/intentee/poet-template-docs), a template for creating documentation websites. This template comes with a few example pages organized into a collection with a navigation menu and a few other components typical for documentation pages to help you get started quickly. This documentation itself is built using this template.

## Using template repository

To use a template repository, navigate to its GitHub page (for example, to https://github.com/intentee/poet-template-minimal for the minimal template) and then click the "Use this template" button to create a new repository in your GitHub account:

<Figure 
    alt="Using a template repository"
    src="resources/media/starting-out-with-a-template-project/using-template.avif"
/>

You will be able to name this project anthing you want and also choose whether you want it to be public or private. 

Next, clone the repository to be able to access it locally.

### Cloning the template repository

Alternatively, if you don't want to use GitHub, you can clone the template repository directly using git and clean up its history. The result will be the same in the end.

## Running the project locally

Once you have the template repository cloned, navigate to its folder in your terminal and run (you may need install GNU Make for this):

```bash
make watch
```

This will start a local server; you can access the site in your web browser at `http://127.0.0.1:8050/` and you will see something like this:

<Figure 
    alt="Poet's minimal template running locally"
    src="resources/media/starting-out-with-a-template-project/hello-poet.avif"
/>

Poet comes with a live preload function, so `make watch` will also watch for any changes you make to the project. 

If you only want to watch for the changes in the content files (i.e., files not in assets), you can run:

```bash
poet watch .
```
