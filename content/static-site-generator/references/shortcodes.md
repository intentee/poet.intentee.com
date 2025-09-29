+++
description = "Create shortcode files to build layouts for your markdown pages and create reusable components."
layout = "LayoutDocumentationPage"
primary_collection = "docs"
title = "Shortcodes"

[[collection]]
name = "docs"
after = "static-site-generator/references/front-matter"
parent = "static-site-generator/references/index"

[[collection]]
name = "create_content"
+++

In Poet, shortcodes are one of two types of files (the second one is the content in the markdown files). You can use shortcodes as reusable pieces of HTML, for example, to create a consistent layout for your documentation pages. Or you can create some smaller repeatable components like a note or a warning box.

## Sharing context

Shortcodes and markdown pages share the same context. This means that you can use the same components and variables in both types of files in the exact same way. A practical example of this fact is the `Note` component we described in the [Repeatable components](static-site-generator/building-blocks/repeatable-components) article.

## Shortcodes files

All shortcode files need to have a `.rhai` extension and should be placed in the `shortcodes` directory at the root of your project. 

This means that if you create a shortcode for a note component, you place it inside the `shortcodes` directory.

And if you create a layout for your documentation pages, you also place it inside the same `shortcodes` directory.

## Shortcodes syntax

Poet's shortcodes are written in a custom syntax based on the [Rhai scripting language](https://rhai.rs/). It's very similar to JSX, and we cover it in more detail in the [Templating engine](templating-engine/what-are-rhai-components) section of this documentation.

All shortcode files follow the same structure. They need the `template` function that takes `context`, `props`, and `content` as arguments. Next, inside the `template()` function, there's the `component { ... }` keyword block that contains the JSX-like content of the page.

## Using shortcodes

To use a shortcode in a markdown file or inside another shortcode, you need to use the name of the shortcode file as a tag. For example, if you have a shortcode file called `MyComponent.rhai`, you can use it as follows:

```markdown
<MyComponent>
    This is the content inside the MyComponent shortcode.
</MyComponent>
```

## Practical examples

### A note component

This is a simple note component that can be created as a shortcode and reused across many markdown pages and inside other shortcode files:

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

You can use this note component in your markdown files as follows:

```markdown
## Practical example: a note component

Throughout this documentation, you may have noticed that we use 

<Note> 
    This note component with a yellow background
</Note>

to highlight important information.
```

### A layout file for the About us page

The following example shows a layout for an "About us" page:

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

Notice that the above example uses another shortcode called `LayoutMinimal` as a wrapper. This is a common pattern to create a consistent layout across multiple pages and an example of how to use a shortcode inside another shortcode.
