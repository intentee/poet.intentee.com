+++
layout = "LayoutDocumentationPage"
primary_collection = "docs"
title = "Organize your pages as collections"

[[collection]]
name = "docs"
after = "static-site-generator/starting-out/add-more-pages"
parent = "static-site-generator/starting-out/index"

[[collection]]
name = "create_content"
+++

In this article, we'll cover organizing your markdown pages as collections. 

## What are collections?

Collections let you group related content together. For example, if you're using Poet for a documentation website, you might organize your pages into collections such as "Docs" or "API". Or if you're building a help center, you can use collections to organize your articles into different categories. 

The primary use case for collections in Poet is to create navigation menus and organize the order of items inside. You can think about it as a way of putting content pages into different folders without actually needing to have any specific folder structure in your project. Instead of using folders, you can specify the name of the collection and fields like `parent` and `after` to define the hierarchy and order of pages within the collection. 

## Adding pages to collections

Adding pages to collections is optional. To do so, you need to add a `[[collection]]` section to the front matter of your markdown page and specify the `name` of the collection. You can also specify the `parent` and `after` fields to define the hierarchy and order of pages. For example:

```toml
[[collection]]
after = "documentation/introduction"
name = "documentation_pages"
parent = "documentation/index"
```

A single markdown page can belong to many collections. This is why Poet also has a concept of the `primary_collection` field. This field is defined in the front matter outside of the `[[collection]]` section, and there can be only one `primary_collection` per page. This is particularly useful when you want to use the same layout file for pages that belong to different collections and render the navigation menu based on the `primary_collection`. 

If you don't specify the `primary_collection` field, and there's only one collection defined in the `[[collection]]` section, Poet will automatically use that collection as the primary one. 

Poet will raise an error when building the site if you reference the primary collection somewhere (for example, in a layout) and you have multiple collections defined in the `[[collection]]` section but haven't defined which collection is primary.

## Practical example

Let's now see collections in action by adding more content to our project and then creating a layout that will leverage the collections to create a left-side menu, like on the screenshot below:

<Figure 
    alt="Documentation page with a left-side navigation"
    src="resources/media/starting-out-with-a-template-project/documentation-page.avif"
/>

We'll create a new `content/documentation` folder and three new pages, to have a structure like this:

```
my-poet-project/
├─ content/
│  ├─ documentation/
│  │  ├─ index.md <- new file
│  │  ├─ introduction.md <- new file
│  │  ├─ installation.md <- new file
│  ├─ about.md
│  ├─ index.md
├─ resources/
│  ├─ css/
│  │  ├─ layout-minimal.css
│  │  ├─ page-about.css
├─ shortcodes/
│  ├─ LayoutMinimal.rhai
│  ├─ PageAbout.rhai
```

### `index.md`

The `index.md` page will be responsible for rendering the "Documentation" collection title in the left-side menu. And this will be its only job in this example; the page itself won't be rendered thanks to the `render = false` field in the front matter. 

```markdown
+++
layout = "LayoutDocumentationPage"
render = false
title = "Documentation"

[[collection]]
name = "documentation_pages"
+++
```

### `introduction.md`

Next, we'll have the `introduction.md` page that will be the first page in the "Documentation" collection. It will belong to the `documentation_pages` collection, use the `parent` field to specify that it should be listed under the title coming from the `index.md` page, and use the `after` field to specify that it should be listed directly after the `index.md` page.

```markdown
+++
layout = "LayoutDocumentation"
title = "Introduction"

[[collection]]
after = "documentation/index"
name = "documentation_pages"
parent = "documentation/index"
+++

Welcome to the Documentation section.
```

### `installation.md`

Finally, we'll have the `installation.md` page that will be the second page in the "Documentation" collection. It will also belong to the `documentation_pages` collection, use the `parent` field to make it listed under the title from`index.md` page, and use the `after` field to put it directly after the `introduction.md` page.

```markdown
+++
layout = "LayoutDocumentation"
title = "Installation"

[[collection]]
after = "documentation/introduction"
name = "documentation_pages"
parent = "documentation/index"
+++

This is a quick installation setup.
```

### Creating the layout

Finally, let's create the `LayoutDocumentation` and the corresponding CSS file for the pages we just created that will render the left-side menu based on the `documentation_pages` collection.

The project structure will now look like this:

```
my-poet-project/
├─ content/
│  ├─ documentation/
│  │  ├─ index.md
│  │  ├─ introduction.md
│  │  ├─ installation.md
│  ├─ about.md
│  ├─ index.md
├─ resources/
│  ├─ css/
│  │  ├─ layout-documentation-page.css <- new file
│  │  ├─ layout-minimal.css
│  │  ├─ page-about.css
├─ shortcodes/
│  ├─ LayoutDocumentationPage.rhai <- new file
│  ├─ LayoutMinimal.rhai
│  ├─ PageAbout.rhai
```

An example of the layout code can look like this:

```html label:"rhai"
fn render_menu(context, node, level, nested) {
  component {
    <div class={`documentation-page__menu__section documentation-page__menu__section--level-${level}`}>
      {switch level {
        0 => component {
          <div class="documentation-page__menu__section__title">
            {node.reference.front_matter.title}
          </div>
          <div class="documentation-page__menu__section__content">
            {nested}
          </div>
        },
        _ => component {
          <a
            class={clsx(#{
            "documentation-page__menu__link": true,
            "documentation-page__menu__link--active": context.is_current_page(node.reference.basename),
            })}
            href={context.link_to(node.reference.basename)}
          >
            {node.reference.front_matter.title}
          </a>
        }
    }}
    </div>
  }
}

fn template(context, props, content) {
  context.assets.add("resources/css/layout-documentation-page.css");

  let menu_hierarchy = context.primary_collection.hierarchy;

  component {
    <LayoutMinimal>
      <div class="documentation-page">
        <div class="documentation-page__menu">
          <div class="documentation-page__menu__content">
            {render_hierarchy(
              menu_hierarchy,
              render_menu.curry(context)
            )}
          </div>
        </div>
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

The layout code above does two things, essentially. 

The first is creating the `render_menu` function that is responsible for rendering the navigation manu based on the items from the collections. It uses a switch statement to differentiate between the 0-level pages and the rest of the pages. Titles of the 0-level pages are rendered as plain text so that we can have a non-clickable title for the collection. Other pages are rendered as links.

And the second thing in this layout is, as usual, the `template` function that extends the `LayoutMinimal` layout and is responsible for rendering the actual page, including the left-side navigation and the main content area.

The order of the pages in the menu is determined by the `after` field in the front matter of each page.

After adding some CSS, the end result can look something like this:

<Figure 
    alt="Documentation page with a left-side navigation"
    src="resources/media/starting-out-with-a-template-project/documentation-page.avif"
/>

You can read more about collections in the [Collections navigation](static-site-generator/building-blocks/collections-navigation) article.
