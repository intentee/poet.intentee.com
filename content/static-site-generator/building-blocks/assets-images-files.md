+++
layout = "LayoutDocumentationPage"
primary_collection = "docs"
title = "Assets, images, files"

[[collection]]
name = "docs"
after = "static-site-generator/building-blocks/previous-next-navigation"
parent = "static-site-generator/building-blocks/index"

[[collection]]
name = "create_content"
+++

Poet comes with an asset management system that is deeply integrated with [esbuild](https://esbuild.github.io/). That makes it easy to add and render different types of assets in your project. It also generates preload tags for imported resources.

## `context.assets.add()`

The `context.assets.add()` function allows you to add assets to your shortcode files. Its most common use case is to add CSS and JS to your layouts. When you use this function, Poet handles asset optimization by:

- Adding preload tags for imported resources like fonts, images in CSS files, and imported scripts to prevent loading waterfalls
- Appending cache-busting hashes to asset URLs to ensure browsers load the latest version when files change

Here's a practical example of how to use it in your layout file:

```html label:"rhai"
fn template(context, props, content) {
  context.assets.add("resources/css/layout-minimal.css");

  component {
    <!DOCTYPE html>
    <html lang="en">
      <head>
        <link rel="canonical" href={context.reference.canonical_link}>

        <meta charset="UTF-8">

        <title>{context.front_matter.title}</title>

        {context.assets.render()}
      </head>
      <body>
        <div class="page">
          {content}
        </div>
      </body>
    </html>
  }
}
```

## `context.assets.render()`

This function takes all assets added with `context.assets.add()` and renders them in the appropriate place of your HTML document. In the example above, we placed it in the `&lt;head&gt;` section of our layout file. 

Using `context.assets.add()` and `context.assets.render()` functions as presented in the above example results in the assets rendered in the `&lt;head&gt;` of the HTML document as follows (the layout-minimal.css in the above example imports some fonts):

```html
<link rel="preload" href="https://fonts.gstatic.com/s/inter/v19/UcCm3FwrK3iLTcvnUwQT9g.woff2" as="font" crossorigin>
<link rel="preload" href="https://fonts.gstatic.com/s/inter/v19/UcCm3FwrK3iLTcvnUwoT9nA2.woff2" as="font" crossorigin>
<link rel="preload" href="https://fonts.gstatic.com/s/inter/v19/UcCo3FwrK3iLTcviYwY.woff2" as="font" crossorigin>
<link rel="preload" href="https://fonts.gstatic.com/s/inter/v19/UcCo3FwrK3iLTcvsYwYL8g.woff2" as="font" crossorigin>
<link rel="stylesheet" href="http://127.0.0.1:8051/assets/layout-minimal_QPTDF4HX.css">
```

## `context.assets.file()`

The `context.assets.file()` function takes a file name as an argument and then returns the file path. The most common use case for this function is to render images and other files in your content, for example:

```markdown
Lorem ipsum dolor sit amet

<img src={context.assets.file("resources/media/file-name.png")} />

consectetur adipiscing elit.
```
