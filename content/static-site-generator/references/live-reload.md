+++
description = "Add and render a live reload script to automatically refresh the browser when you make changes to your files. Exclude specific content from being reloaded."
layout = "LayoutDocumentationPage"
primary_collection = "docs"
title = "Live reload"

[[collection]]
name = "docs"
after = "static-site-generator/references/using-props"
parent = "static-site-generator/references/index"

[[collection]]
name = "create_content"
+++

Poet's templates ([template minimal](https://github.com/intentee/poet-template-minimal) or [template docs](https://github.com/intentee/poet-template-docs)) come with a live reload script that automatically refreshes your browser when you make changes to your files:

```js label:"typescript"
import { liveReload } from "jarmuz-preset-poet/live-reload";

liveReload(function ({ morphDocument, updatedHTMLWithoutDoctype }) {
  morphDocument(updatedHTMLWithoutDoctype);
});
```

This script is based on [Jarmuz](https://github.com/intentee/jarmuz), a project building tool created by our team. 


## Using the live reload script in your layout

Poet never adds any code without you explicitly asking for it. To use the live reload script, you need to add it to your layout file using the `context.assets.add()` function and then render it using the `context.assets.render()` function.

If you're using one of our templates, the live reload script is already added and rendered in the `MinimalLayout` file:

```html label:"rhai"
fn template(context, props, content) {

  if context.is_watching {
    context.assets.add("resources/ts/global-live-reload.mjs");
  }

  component {
    <!DOCTYPE html>
    <html lang="en">
      <head>
        {context.assets.render()}
      </head>
    </html>
  }
}
```

## Excluding content from being reloaded

If you want part of your page to be excluded from being reloaded, you can add the `data-poet-permanent` attribute to your HTML tags. Any element with this attribute will persist during live reloading, along with all of its content.

## Custom live reload implementation

You can also implement your own live reload script and use it similarly to the one provided in our templates.
