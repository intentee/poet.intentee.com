+++
id = "example-page"
layout = "LayoutDocumentationPage"
title = "Example page"

[[collection]]
name = "docs"
parent = "docs/index"
+++

You can take a look at the content below for some useful components and examples.

## Front matter

The front matter uses [TOML syntax](https://toml.io/) and is surrounded by +++ delimiters like this:

```toml
+++
title = "My Page"
layout = "DefaultLayout"
+++
```

Two fields are required in the front matter:

- `title` - The title of the page, which will be displayed in the browser tab and as the main heading on the page
- `layout` - The layout to use for the page

Optionally, you can define:

- `description` - A description of the page. You can then use it, for example, as the description in the meta tags
- `id` - An identifier for the page, which can be used for internal linking (for example, add id = "example-page" to the front matter and link to this page using: {context.link_to("#example-page")})
- `primary_collection` - Used to indicate the primary collection for the page when it belongs to multiple collections
- `props` - A table of additional properties that can be used in the layout
- `render` - If set to false, the page will not be rendered (which can be used for index pages)

You can also optionally define the `[[collection]]` section in the front matter to include the page in a collection and use it to define the navigation structure. In the example below, the page is included in the `docs` collection, placed after the `what-is-poet` page, and under the `docs/index` parent page:

```toml
[[collection]]
after = "docs/what-is-poet"
name = "docs"
parent = "docs/index"
```

## Components

You can create your own components and use them in both the markdown and layout files in the exact same way. 

For example, below is a Note component:

<Note>
    Hello, I am a note.
</Note>

And this is the code for the Note component (you will also find it in the `components/Note.rhai` file):

```html label:"rhai"
fn template(context, props, content) {

  component {
    <div
      class={if "type" in props {
        `formatted-text__note formatted-text__note--${props.type}`
      } else {
        "formatted-text__note"
      }}
    >
      {content}
    </div>
  }
}
```

## Left-side navigation

You can render the navigation to browse through the documentation pages. The navigation is generated based on the `[[collection]]` section in the front matter - you can see the full example of how to use it in the `LayoutDocumentationPage.rhai` file.

## Page headings

You can render the page headings as the page navigation. In this project example, the navigation is displayed on the right and includes only headings at level 2. You can change the level in the `LayoutDocumentationPage.rhai` file.
