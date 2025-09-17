+++
layout = "LayoutDocumentationPage"
primary_collection = "docs"
title = "Add more pages"

[[collection]]
after = "static-site-generator/starting-out/create-your-first-page"
name = "docs"
parent = "static-site-generator/starting-out/index"

[[collection]]
name = "create_content"
+++

Let's now see how to add more pages to the project, for example, a simple "About us" page. We will create a separate layout, a markdown page, and a CSS file, and see how it all works together.

At the end of this process, the project structure will look like this:

```
my-poet-project/
├─ content/
│  ├─ about.md <- new file
│  ├─ index.md
├─ resources/
│  ├─ css/
│  │  ├─ layout-minimal.css
│  │  ├─ page-about.css <- new file
├─ shortcodes/
│  ├─ LayoutMinimal.rhai
│  ├─ PageAbout.rhai
```

## Creating a layout

The layout for the "About us" follows the same rules as the `LayoutMinimal` - it needs a `template` function and the `component { ... }` block to place the content of the page. A basic layout for the "About us" page can be called `PageAbout`. It needs to have the `.rhai` file extension and be located inside the `/shortcodes` directory. Here's what it could look like:

```html label:"rhai"
fn template(context, props, content) {
  context.assets.add("resources/css/page-about.css");

  component {
    <LayoutMinimal>
      <div class="page page-about">
        <h1 class="title">
          {context.front_matter.title}
        </h1>
        {content}
      </div>
    </LayoutMinimal>
  }
}
```

Notice that we are using the `LayoutMinimal` layout as a wrapper for our new layout, by putting the "About us" page's content inside the `&lt;LayoutMinimal&gt;` tag. This can be useful, for example, if we later add a top navigation and a footer to the `LayoutMinimal` layout to have them appear on all pages. But in order for it to work, we need to put a `{content}` variable in the `LayoutMinimal` to indicate where the content of the child layout should go. We can, for example, replace the existing "Hello, Poet" header with it.

## Adding a CSS file

If you want to have a separate CSS file for a particular layout, you can create it and put it inside the `/resources/css` directory. In our case, we can create a `page-about.css`. Next, to make sure the layout uses the CSS, we need to add it inside the `template` function using the `context.assets.add` function. This is shown in the example above.

<Note>
    The `PageAbout` layout uses the `LayoutMinimal` layout as a wrapper, so the CSS file added in the `LayoutMinimal` layout will also be used by the "About us" page.
</Note>

## Creating a markdown page

Finally, we need the markdown page. We can create a new file called `about.md` inside the `/content` directory. At a minimum, the markdown page needs to have a front matter section with the `layout` and `title` fields. In the case of our "About us" page, since we just created a new layout for it, we need to specify it in the front matter:

```toml
+++
layout = "PageAbout"
title = "Poet"
+++
```

## Accessing the page
And that's it! You can now access the "About us" page in your web browser at `http://127.0.0.1:8050/about/`. The URL is generated based on the name of the markdown file.
