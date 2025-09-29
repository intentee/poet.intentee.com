+++
description = "Display previous/next navigation links on your pages based on the after field in the front matter and using before and after functions in the layout file."
layout = "LayoutDocumentationPage"
primary_collection = "docs"
title = "Previous/Next navigation"

[[collection]]
name = "docs"
after = "static-site-generator/building-blocks/table-of-contents"
parent = "static-site-generator/building-blocks/index"

[[collection]]
name = "create_content"
+++

In this article, we'll cover creating a previous/next navigation for your markdown pages. It is typically  something that you place at the bottom of your content pages, to help users quickly navigate through related content items (it's especially useful on mobile!).

This navigation feature builds on Poet's collection system, which you can learn more about in our [Collections navigation](static-site-generator/building-blocks/collections-navigation) article. The previous/next links follow the order you've defined for your content in the collection.

Here's what we'll be building:

<Figure 
    alt="Previous / next navigation example"
    src="resources/media/previous-next-navigation/previous-next-navigation.avif"
/>

## Create a layout with the previous / next navigation

First, we will define the `menu_hierarchy` variable so we can find the previous and next pages in the collection sequence.

```html label:"rhai"
let menu_hierarchy = context.primary_collection.hierarchy;
```

Next, we will use the `menu_hierarchy` in the content of the layout that is responsible for rendering the previous / next navigation. An example code may look like this:

```html label:"rhai"
<div class="documentation-page__related-pages">
  {
    let prev = menu_hierarchy.before(context.reference.basename);

    if has(prev) {
      component {
        <a
          class="documentation-page__related-pages__link documentation-page__related-pages__link--prev"
          href={prev.canonical_link}
        >
          <span class="documentation-page__related-pages__link__text">{prev.front_matter.title}</span>
        </a>
      }
    }
  }
  {
    let next = menu_hierarchy.after(context.reference.basename);

    if has(next) {
      component {
        <a
          class="documentation-page__related-pages__link documentation-page__related-pages__link--next"
          href={next.canonical_link}
        >
          <span class="documentation-page__related-pages__link__text">{next.front_matter.title}</span>
        </a>
      }
    }
  }
</div>
```

What's happening in the code above is that we are creating the "previous" section:

- `menu_hierarchy.before(context.reference.basename)` finds the page that comes before the current page in the collection hierarchy 
- if a previous page exists (`if has(prev)`), the code renders a link with the previous page's title and URL

And the "next" section is created in the same way, but using `menu_hierarchy.after(context.reference.basename)` to find the page that comes after the current page.

The previous/next order follows the `after` field relationships you define in your pages' front matter.

The final layout code may look like this:

```html label:"rhai"
fn template(context, props, content) {
  context.assets.add("resources/css/layout-documentation-page.css");

  let menu_hierarchy = context.primary_collection.hierarchy;

  component {
    <LayoutMinimal>
      <div class="documentation-page">
        <div class="documentation-page__content">
          <div class="formatted-text">
            <h1>
              {context.front_matter.title}
            </h1>
            {content}
          </div>
          <div class="documentation-page__related-pages">
            {
              let prev = menu_hierarchy.before(context.reference.basename);

              if has(prev) {
                component {
                  <a
                    class="documentation-page__related-pages__link documentation-page__related-pages__link--prev"
                    href={prev.canonical_link}
                  >
                    <span class="documentation-page__related-pages__link__text">{prev.front_matter.title}</span>
                  </a>
                }
              }
            }
            {
              let next = menu_hierarchy.after(context.reference.basename);

              if has(next) {
                component {
                  <a
                    class="documentation-page__related-pages__link documentation-page__related-pages__link--next"
                    href={next.canonical_link}
                  >
                    <span class="documentation-page__related-pages__link__text">{next.front_matter.title}</span>
                  </a>
                }
              }
            }
          </div>
        </div>
      </div>
    </LayoutMinimal>
  }
}
```

<Note>
If you're on the first page in the collection, no "Previous" link will appear. And similarly, if you're on the last page, no "Next" link will be shown.
</Note>
