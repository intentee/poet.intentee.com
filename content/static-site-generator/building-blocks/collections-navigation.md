+++
layout = "LayoutDocumentationPage"
primary_collection = "docs"
title = "Collections navigation"

[[collection]]
name = "docs"
after = "static-site-generator/building-blocks/index"
parent = "static-site-generator/building-blocks/index"

[[collection]]
name = "create_content"
+++

Collections let you group related content together and build navigation components in the UI based on the relationships between the content items.

The primary use case for collections in Poet is to create navigation menus and organize the order of items inside. You can think of it as a way to put content pages into different folders without actually needing to follow a specific folder structure in your project. Instead of using folders, the hierarchy and order of the items inside navigation menus is achieved using the `parent` and `after` fields in the `[[collection]]` section of the front matter.

In this article, we'll provide a practical example you can use to build a left-side navigation menu for documentation pages, like the one you can see in the screenshot below. We'll also explain how to achieve that step by step.

<Figure 
    alt="Documentation page with a left-side navigation"
    src="resources/media/collections-navigation/documentation-page-navigation.avif"
/>

## Creating markdown pages in the collection

To achieve the result from the screenshot above, we'll start with the corresponding markdown pages. The content structure will look like this:

```
my-poet-project/
├─ content/
│  ├─ documentation/
│  │  ├─ index.md 
│  │  ├─ installation.md 
│  │  ├─ introduction.md 
│  │  ├─ gettings-started.md 
│  ├─ tutorials/
│  │  ├─ index.md 
│  │  ├─ first lesson.md 
│  ├─ index.md
```

Let's now build the necessary markdown files. We will use the `[[collection]]` section in the front matter to achieve the desired hierarchy and order.

### Pages in the "documentation" category

The following are the front matter sections of the pages that will make up the "documentation" part of the navigation.

**content/documentation/index.md**

The `index.md` page itself will not be rendered (we achieve that by setting `render = false`), but we will use this page as the parent for the other documentation pages. We will also use its title as the title of the "Documentation" category in the left-side menu:

```toml
+++
layout = "LayoutDocumentationPage"
render = false
title = "Documentation"

[[collection]]
name = "documentation_pages"
+++
```

**content/documentation/introduction.md**

The `introduction.md` page will be the first item inside the "Documentation" category of the left-side menu. We achieve that by setting the `parent` field to `documentation/index`:):

```toml
+++
layout = "LayoutDocumentationPage"
title = "Introduction"

[[collection]]
name = "documentation_pages"
parent = "documentation/index"
+++
```

**content/documentation/installation.md**

The `installation.md` page will be the second item, after the `introduction.md`. We achieve that by setting the `parent` field to `documentation/index` and the `after` field to `documentation/introduction`:

```toml
+++
layout = "LayoutDocumentationPage"
title = "Installation"

[[collection]]
after = "documentation/introduction"
name = "documentation_pages"
parent = "documentation/index"
+++
```

**content/documentation/getting-started.md**

And finally, the `getting-started.md` page will be the third item, by setting the `parent` field to `documentation/index` and the `after` field to `documentation/installation`:

```toml
+++
layout = "LayoutDocumentationPage"
title = "Getting started"

[[collection]]
after = "documentation/installation"
name = "documentation_pages"
parent = "documentation/index"
+++
```

### Pages in the "tutorials" category

Let's say that we also want to have some pages that will be grouped under the "Tutorials" category in the left-side menu, just like in the screenshot presented at the beginning of this article. We can achieve that by creating a similar set of pages as we did for the "Documentation" category.

**content/tutorials/index.md**

We start with the `index.md` that will be used as the parent page and also to display the category title.

```toml
+++
layout = "LayoutDocumentationPage"
render = false
title = "Tutorials"

[[collection]]
after = "documentation/index"
name = "documentation_pages"
+++
```

**content/tutorials/first-lesson.md**

And let's also add at least one page inside the "Tutorials" category:

```toml
+++
layout = "LayoutDocumentationPage"
title = "First Lesson"

[[collection]]
name = "documentation_pages"
parent = "tutorials/index"
+++
```

## Creating the layout

We now need a layout (and a corresponding CSS file) that will render the left-side menu based on the pages we just created. 

The project structure will look like this:

```
my-poet-project/
├─ content/
│  ├─ documentation/
│  │  ├─ index.md 
│  │  ├─ installation.md 
│  │  ├─ introduction.md 
│  │  ├─ gettings-started.md 
│  ├─ tutorials/
│  │  ├─ index.md 
│  │  ├─ first lesson.md 
│  ├─ index.md
├─ resources/
│  ├─ css/
│  │  ├─ layout-documentation-page.css
├─ shortcodes/
│  ├─ LayoutDocumentationPage.rhai
```

As usual, the layout is implemented as a file with the .rhai extension and located in the `shortcodes` folder. 

The code that will let us achieve the structure from the screenshot can look like this:

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

Let's now analyze the code of the layout in relation to the collections we created earlier in the markdown pages.

## How does the layout code work?

The markdown pages have metadata fields in the `[[collection]]` section in their front matter that define the hierarchy and order of the items in the left-side menu:

- `parent` - defines the hierarchical relationships (which document is treated as a parent of which other documents)
- `after` - defines the order of the items inside a given level of the hierarchy (which document should be displayed after which other document)

Poet takes these parent/after relationships and creates a topologically sorted hierarchy. This hierarchy is then available in the layout code via `context.primary_collection.hierarchy`. Thanks to the topological sorting, we ensure that:

- All dependencies are resolved (parents come before their children)
- The order of the items is consistent with the `after` relationships defined in the front matter


<Note>
A single markdown page can belong to many collections. This is why Poet also has a concept of the `primary_collection` field. This field is defined in the front matter outside of the `[[collection]]` section, and there can be only one `primary_collection` per page. This is particularly useful when you want to use the same layout file for pages that belong to different collections and render the navigation menu based on the `primary_collection`. 

If you don't specify the `primary_collection` field, and there's only one collection defined in the `[[collection]]` section, Poet will automatically use that collection as the primary one. 

Poet will raise an error when building the site if you reference the primary collection somewhere (for example, in a layout) and you have multiple collections defined in the `[[collection]]` section but haven't defined which collection is primary.
</Note>

The `render_hierarchy()` function is a built-in Poet helper function that walks the tree structure and calls `render_menu()` for each node in the hierarchy. It provides variables like `node`, `level`, and `nested` to the `render_menu()` function, enabling recursive rendering of the menu structure.

The `render_menu()` function is a custom function (it doesn't come with Poet) defined in the layout that:

- Handles different levels of the hierarchy differently:

    - Level 0: Renders as a non-clickable category title (in our example, this is provided by the `index.md` pages in the `documentation` and `tutorials` folders)
    - Other levels: Renders as clickable links to the corresponding pages
    
- Processes nested content: The `{nested}` part contains the rendered children of the current node, allowing the function to build the complete menu structure recursively
