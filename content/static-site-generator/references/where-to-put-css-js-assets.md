+++
layout = "LayoutDocumentationPage"
primary_collection = "docs"
title = "Where to put CSS, JS, and other assets"

[[collection]]
name = "docs"
after = "static-site-generator/references/layouts"
parent = "static-site-generator/references/index"

[[collection]]
name = "create_content"
+++

## Location for the CSS, JS, and other files

Poet comes with a preset for [Jarmuz](https://github.com/intentee/jarmuz), a project building tool created by our team. This preset is created specifically for using it for Poet and esbuild and if you want to use it, you need to place your CSS, JS, and other asset files in their corresponding subdirectories in the `/resources/` directory. Specifically, you should place:

- CSS files in the `/resources/css/` directory
- JS files in the `/resources/js/` directory
- Image, videos, and other files in the `/resources/media/` directory

<Note>
    Alternatively, you can configure esbuild yourself according to your preferences. In that case, you can place your CSS and other asset files anywhere you want, but you will need to set up esbuild to ensure it generates the `esbuild-meta.json` file.
</Note>

## Adding CSS, JS and other files to your layouts

To include CSS, JS and other files in your layouts, you need to use the `context.assets.add()` function inside the `template()` function of your layout. 

The `context.assets.add()` function takes the path to the file as an argument, for example:

```html label:"rhai"
fn template(context, props, content) {
  context.assets.add("resources/css/styles.css");

  component {
    <div class="page">
      {content}
    </div>
  }
}
```

Adding the file this way results in this file being included in the final HTML output of the page using a `&lt;link&gt;` tag in the `&lt;head&gt;` section or anywhere else you decide to render the assets using the `context.assets.render()` function.

## Rendering the assets

<Note>
    Poet never adds code without you explicitly asking for it. So, to render the assets, you need to use the `context.assets.render()` function in your layout.
</Note>

Here's an example of using the `context.assets.render()` function in a layout:

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
        {context.assets.render()}
      </head>
      <body>
        {content}
      </body>
    </html>
  }
}
```
