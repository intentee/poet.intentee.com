+++
description = "Pass data to components using props for customization, including front matter props that cascade through layouts."
layout = "LayoutDocumentationPage"
primary_collection = "docs"
title = "Using props"

[props]
always_show_cat = true

[[collection]]
name = "docs"
after = "static-site-generator/references/managing-assets"
parent = "static-site-generator/references/index"

[[collection]]
name = "create_content"
+++

Props are data you pass to components to customize how they look and behave. 

In Poet, props work just like in React - you pass them as attributes when using a component, and access them through the `props` parameter in your template function.

Below you will find a practical example of using props in Poet.

## Example: A note component with props

Here's a note component that uses props to customize its styling:

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

## Using the component with props

You can use this component in your markdown or other shortcodes by passing props as attributes. 

Here's a markdown file example:

```markdown
<Note>
  This is a basic note.
</Note>

<Note type="warning">
  This is a warning note with different styling.
</Note>

<Note type="error">
  This is an error note.
</Note>
```

The `type` prop gets passed to the component and determines which CSS class is applied, allowing you to create different visual variants of the same component.

## Example: using props in front matter

As you probably noticed, there's a cat at the bottom of this page. 🐈‍⬛ 😊

This cat is actually another example of using props in Poet, this time in the front matter, to apply the cat only to this particular "Using props" page. Let's take a look at how it works.

The way the prop is used is that it is trickled down from the front matter of the particular markdown page where we want to show the cat, to the layout of that page, and finally to the layout that actually contains the cat video element.

In the front matter, we define a `props` table with a property called `always_show_cat` set to `true`:

```toml
+++
layout = "LayoutDocumentationPage"
primary_collection = "docs"
title = "Using props"

[props]
always_show_cat = true

[[collection]]
name = "docs"
after = "static-site-generator/references/managing-assets"
parent = "static-site-generator/references/index"

[[collection]]
name = "create_content"
+++
```

This prop is then passed to the layout used by this page (`LayoutDocumentationPage`). 

Next, in the `LayoutDocumentationPage` we pass it down to its parent layout:

``` html label:"rhai"
<LayoutMinimal always_show_cat={"always_show_cat" in props && props.always_show_cat}>
```

And finally, we use this prop in the parent `LayoutMinimal` of the documentation page in the following way:

```html label:"rhai"
<video
  autoplay
  class={if "always_show_cat" in props && props.always_show_cat {
    "page-cat page-cat--always-visible"
  } else {
    "page-cat"
  }}
  data-poet-permanent
  disablepictureinpicture
  loop
  muted
  playsinline
>
  <source src={context.assets.file("resources/media/cat.webm")} type="video/webm">
</video>
```

The prop in the `LayoutMinimal` is used to conditionally apply a CSS class to the cat video element. Finally, we use this class in the CSS file to control the visibility of the cat, making it always visible when `always_show_cat` is `true`.
