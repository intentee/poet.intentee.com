+++
layout = "LayoutDocumentationPage"
primary_collection = "docs"
title = "Create your first page"

[[collection]]
after = "static-site-generator/starting-out/starting-out-with-a-template-project"
name = "docs"
parent = "static-site-generator/starting-out/index"

[[collection]]
name = "create_content"
+++

When you run the minimal template project for the first time, it comes with basically no content, but you'll notice the minimal project structure needed to make anything appear in your web browser. 

Let's take a look at it more closely.

## Content organization

All of your content files are located in the `/content` directory. You can organize your content into any number of subdirectories you need to keep it organized, but at a minimum, you need at least a single `index.md` file with a front matter section to run the project.

The front matter uses [TOML syntax](https://toml.io/) and is surrounded by `+++` delimiters. The `index.md` file in the template project comes with the minimal configuration:

```toml
+++
layout = "LayoutMinimal"
title = "Poet"
+++
```

Two fields are required in the front matter:

- `title` - The title of the page, which will be displayed in the browser tab and as the main heading on the page
- `layout` - The layout to use for the page

You can read more about the possible fields in the [Front matter](static-site-generator/building-blocks/front-matter) article.

## Layouts

Now that we have the `index.md` file in the content directory, we also need a layout for it. The minimal template project comes with a basic layout called `LayoutMinimal`. All layouts are located in the `/shortcodes` directory. 

<Note>
    Poet's design principle is that everything is either a shortcode or a markdown page. There are no other moving parts like templates or sections. This means that layouts are implemented as shortcodes and are located in the `/shortcodes` directory with other reusable pieces of content.
</Note>

The `LayoutMinimal` layout is a very basic layout that only renders a simple "Hello, Poet!" header. But together with the `index.md` file, it is what makes up the first page created in Poet.

This is what the `LayoutMinimal` layout looks like:

```html label:"rhai"
fn template(context, props, content) {
  context.assets.add("resources/css/layout-minimal.css");

  if context.is_watching {
    context.assets.add("resources/ts/global-live-reload.mjs");
  }

  component {
    <!DOCTYPE html>
    <html lang="en">
      <head>
        <link rel="canonical" href={context.reference.canonical_link}>

        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        {if !context.front_matter.description.is_empty() {
          component {
            <meta name="description" content={context.front_matter.description}>
          }
        }}

        <title>{context.front_matter.title}</title>

        {context.assets.render()}
      </head>
      <body>
        <div class="page">
          <h1 class="page-title">
            Hello, Poet!
          </h1>
        </div>
      </body>
    </html>
  }
}
```

## Shortcodes syntax

Shortcodes are written in a custom JSX-like syntax based on the [Rhai scripting language](https://rhai.rs/). When you take a look at the example above, you can notice that it starts with the `template` function that takes `context`, `props`, and `content` as arguments. Next, there's the `component` keyword block that contains the JSX-like content of the page. All shortcode files follow this structure. 

Now that we have the first page created, let's add more content to the project.
