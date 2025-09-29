+++
description = "Display a table of contents navigation based on the headings from your markdown page."
layout = "LayoutDocumentationPage"
primary_collection = "docs"
title = "Table of contents"

[[collection]]
name = "docs"
after = "static-site-generator/building-blocks/collections-navigation"
parent = "static-site-generator/building-blocks/index"

[[collection]]
name = "create_content"
+++

Another convenient building block you may want to use in your project is navigation within a page (table of contents). This is especially useful for long-form content, such as documentation or tutorials, where you want to help users quickly jump to different sections of the page based on the headings.

An example may look like this:

<Figure 
    alt="Navigation witin a page based on headings"
    src="resources/media/table-of-contents/table-of-contents.avif"
/>

In this article, you will find a practical example you can reuse in your own project to build a navigation based on the headings in your markdown content.

## Define headings in your markdown content

Let's first create a simple markdown page with a few headings so that we have something to render in the navigation. The content of the page may look like this:

```markdown
Welcome to the Documentation section.

## Overview

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

## Features

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

## Getting Help

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
```

## Create a layout with the page navigation

We can first create a custom `render_heading()` function that will be responsible for rendering a single heading in the navigation. It takes the `heading` object and turns it into a clickable table-of-contents link (creating anchor links so that users can click the headings and get navigated to a specific section of the page).

```html label:"rhai"
fn render_heading(context, heading) {
  component {
    <a
      class="documentation-page__toc__link-list__link"
      href={`#${heading.id}`}
    >
      {heading.content}
    </a>
  }
}
```

Next, we can create the content of the layout that actually renders the page navigation:

```html label:"rhai"
<nav class="documentation-page__toc">
  <div class={clsx(#{
    "documentation-page__toc__content": true,
    "documentation-page__toc__content--empty": context.table_of_contents.headings.is_empty(),
  })}>{if !context.table_of_contents.headings.is_empty() {
    component {
      <div class="documentation-page__toc__title">
        On this page
      </div>
      <div class="documentation-page__toc__link-list">{
        context
          .table_of_contents
          .headings
          .filter(|heading| heading.depth == 2)
          .map(render_heading.curry(context))
      }</div>
    }
  }}</div>
</nav>
```

The code above creates the "On this page" section that you could see in the screenshot. This section shows links to different headings within the page. 

Here's exactly how it works:

- If the page doesn't contain any headings (`context.table_of_contents.headings.is_empty()`), it adds an "empty" CSS class for styling
- If headings are present, they are taken from the `context.table_of_contents.headings`, and in this particular example, we filter them to only include level-2 headings (i.e., `## Heading` in markdown). You can adjust this to include other heading levels if needed
- Finally, we map over the filtered headings and use the `render_heading` function to render each heading as a clickable link

Of course, both the `render_heading` function and the navigation element need to be placed inside the layout code. Here's how the complete layout may look like:

```html label:"rhai"
fn render_heading(context, heading) {
  component {
    <a
      class="documentation-page__toc__link-list__link"
      href={`#${heading.id}`}
    >
      {heading.content}
    </a>
  }
}

fn template(context, props, content) {
  context.assets.add("resources/css/layout-documentation-page.css");

  component {
    <LayoutMinimal>
      <div class="documentation-page">
        <nav class="documentation-page__toc">
          <div class={clsx(#{
            "documentation-page__toc__content": true,
            "documentation-page__toc__content--empty": context.table_of_contents.headings.is_empty(),
          })}>{if !context.table_of_contents.headings.is_empty() {
            component {
              <div class="documentation-page__toc__title">
                On this page
              </div>
              <div class="documentation-page__toc__link-list">{
                context
                  .table_of_contents
                  .headings
                  .filter(|heading| heading.depth == 2)
                  .map(render_heading.curry(context))
              }</div>
            }
          }}</div>
        </nav>
        <div class="documentation-page__content">
          <div class="formatted-text">
            <h1>
              {context.front_matter.title}
            </h1>
            {content}
          </div>
        </div>
      </div>
    </LayoutMinimal>
  }
}
```
