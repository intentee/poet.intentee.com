+++
description = "Create internal links to your content pages by using simplified Markdown syntax."
layout = "LayoutDocumentationPage"
primary_collection = "docs"
title = "Internal links"

[[collection]]
name = "docs"
after = "static-site-generator/building-blocks/code-blocks"
parent = "static-site-generator/building-blocks/index"

[[collection]]
name = "create_content"
+++

Internal links in this static site generator follow standard Markdown link syntax but with a simplified path structure. 

To create an internal link, use the format `[Link Text](path/to/page)` where the path is relative to your content folder and excludes the .md file extension.

For example, if you have a page located at `content/guides/getting-started.md`, you would link to it in the following way: 

```markdown
To get started, check out the [Getting Started Guide](guides/getting-started).
```
