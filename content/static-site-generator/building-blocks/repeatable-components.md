+++
layout = "LayoutDocumentationPage"
primary_collection = "docs"
title = "Repeatable components"

[[collection]]
name = "docs"
after = "static-site-generator/building-blocks/internal-links"
parent = "static-site-generator/building-blocks/index"

[[collection]]
name = "create_content"
+++

To create repeatable components in your project, you can use shortcodes.

As is the case with all shortcodes, you need to follow the same structure: first define the `template()` function taking `context`, `props`, and `content` as arguments. Next, use Poet's JSX-like syntax inside the `component { ... }` block to define the content of your component.

The shortcode file needs a .rhai extension and should be placed in the `shortcodes` directory at the root of your project.

In Poet, **shortcodes and markdown pages share the same context**. This means that you can use the same components and variables in both types of files in the exact same way. 

## Practical example: a note component

Throughout this documentation, you may have noticed that we use 

<Note> 
    this note component with a yellow background
</Note>

to highlight important information. Let's use it as an example of how to create a reusable component.

## Shortcode definition

Our note component's code is created as follows:

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

## Placing the shortcode in a markdown file

First, let's see what the note on this particular page looks like as markdown code:

```markdown
## Practical example: a note component

Throughout this documentation, you may have noticed that we use 

<Note> 
    this note component with a yellow background
</Note>

to highlight important information. Let's use it as an example of how to create a reusable component.
```

Notice that we're using the `&lt;Note&gt; ... &lt;/Note&gt;` tags to wrap the content that we want to be displayed inside the note component. The name of the tag needs to be the same as the name of the shortcode file (without the .rhai extension).

## Placing the shortcode in another shortcode

To place the note component inside another shortcode (the most common use case would be to place it inside some of the shortcode files that contain page layouts), we need to use the `&lt;Note&gt; ... &lt;/Note&gt;` tags in the exact same way as in markdown files. For example:

```html label:"rhai"
fn template(context, props, content) {
  context.assets.add("resources/css/page-about.css");

  component {
    <LayoutMinimal>
      <div class="page page-about">
        <h1 class="docs__title">
          {context.front_matter.title}
        </h1>
        <Note> 
            Welcome to the About page!
        </Note>       
        {content}
      </div>
    </LayoutMinimal>
  }
}
```
