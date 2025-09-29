+++
description = "Learn about the biggest differences between JSX and Poet's syntax by comparing code examples written in JSX and Poet."
layout = "LayoutDocumentationPage"
primary_collection = "docs"
title = "Poet and JSX differences"

[[collection]]
after = "templating-engine/what-are-rhai-components"
name = "docs"
parent = "templating-engine/index"

[[collection]]
name = "create_content"
+++

In this article, we will present a few examples that cover the biggest differences in the syntax between Poet ans [JSX](https://react.dev/learn/writing-markup-with-jsx).

The examples follow the same structure: both present code that achieves the same result, first in JSX and then in Poet's Rhai-based syntax.

## No need for `&lt;Fragment&gt;`

While the HTML code in Poet needs to be correct, there's no need for the <Fragment> wrapper. You can use the component block and put the elements directly inside it.

```js label:"JSX"
function MyComponent() {
  return (
    <>
      <h1>Title</h1>
      <p>Paragraph</p>
    </>
  );
}
```

```html label:"rhai"
fn template(context, props, content) {
  component {
    <h1>Title</h1>
    <p>Paragraph</p>
  }
}
```

## if-else statements

Instead of using ternary operators, you can use regular if-else statements because they are treated as expressions in Rhai.

For example, here we're checking if the "type" property exists in props and then I modify the class accordingly:

```js label:"JSX"
function Note(props) {
  return (
    <div
      className={
        "type" in props 
          ? `note note--${props.type}`
          : "note"
      }
    >
      {props.children}
    </div>
  );
}
```

```html label:"rhai"
fn template(context, props, content) {
  component {
    <div
      class={if "type" in props {
        `note note--${props.type}`
      } else {
        "note"
      }}
    >
      {content}
    </div>
  }
}
```
And here, we're checking if the description property in the front matter is empty:

```js label:"JSX"
<meta 
  name="description" 
  content={
    context.frontMatter.description.length === 0
      ? "Static content should no longer be static"
      : context.frontMatter.description
  }
/>
```

```html label:"rhai"
<meta name="description" 
  content={if context.front_matter.description.is_empty() {
    "Static content should no longer be static."
  } else {
    context.front_matter.description
  }}
>
```

## switch statement

Rhai treats switches as expressions so they can be placed them directly inside shortcodes.

```js label:"JSX"
function Card(props) {
  return (
    <div>{function () {
      switch (props.type) {
        case "note":
          return <Note>{props.children}</Note>;
        case "banner":
          return <Banner>{props.children}</Banner>;
      }
    }()}</div>    
  );
}
```

```html label:"rhai"
fn template(context, props, content) {
  component {
    <div>{switch props.type {
      "note" => component {
        <Note>{content}</Note>
      },
      "banner" => component {          
        <Banner>{props.children}</Banner>
      }
    }}</div>
  }
}
```

## class instead of className

In Poet, you use `class` instead of `className` to define CSS classes.

```js label:"JSX"
<div className="homepage">
  <h1 className="homepage__title">
    Keep AI on your own servers
  </h1>
  <a className="homepage__button" href="/docs">
    Get Started
  </a>
</div>
```

```html label:"rhai"
component {
  <div class="homepage">
    <h1 class="homepage__title">
      Keep AI on your own servers
    </h1>
    <a class="homepage__button" href="/docs">
      Get Started
    </a>
  </div>
}
```

## error() global function

An example of an error function that raises an error with a custom message.

```js label:"JSX"
if (!props.role) { 
  throw new Error("Role required");
}
```

```html label:"rhai"
if !props.role {
  error("Role required");
}
```

## clsx() global function

Another example of a global function in Poet is the clsx() for conditionally composing classe:

```html label:"rhai"
<div class={clsx(#{
  "documentation-page__toc__content": true,
  "documentation-page__toc__content--empty": context.table_of_contents.headings.is_empty(),
})}>
```
