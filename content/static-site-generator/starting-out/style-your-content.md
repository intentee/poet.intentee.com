+++
layout = "LayoutDocumentationPage"
primary_collection = "docs"
title = "Style your content"

[[collection]]
name = "docs"
after = "static-site-generator/starting-out/organize-your-pages-as-collections"
parent = "static-site-generator/starting-out/index"

[[collection]]
name = "create_content"
+++

We already added a few CSS files in our previous examples, and this article summarizes how to style your content in Poet.

## Location for the CSS files

Poet comes with a preset for [Jarmuz](https://github.com/intentee/jarmuz), a project building tool created by our team. This preset is created specifically for using it for Poet and esbuild and if you want to use it, you need to place your CSS files in the `/resources/css` directory.

<Note>
    Alternatively, you can configure esbuild yourself according to your preferences. In that case, you can place your CSS and other asset files anywhere you want, but you will need to set up esbuild to ensure it generates the esbuild-meta.json file.
</Note>

## Adding CSS files to your layouts

To include CSS files in your layouts, you need to use the `context.assets.add()` function inside the `template` function of your layout. 

The `context.assets.add()` function takes the path to the CSS file as an argument, for example:

```html label:"rhai"
fn template(context, props, content) {
  context.assets.add("resources/css/styles.css");

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

Adding the file this way results in this file being included in the final HTML output of the page using a `&lt;link&gt;` tag in the `&lt;head&gt;` section or anywhere else you decide to render the assets using the `context.assets.render()` function.
