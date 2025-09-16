+++
layout = "LayoutDocumentationPage"
primary_collection = "docs"
title = "Code blocks"

[[collection]]
name = "docs"
after = "static-site-generator/building-blocks/assets-images-files"
parent = "static-site-generator/building-blocks/index"

[[collection]]
name = "create_content"
+++

You can display code blocks in your markdown files using the standard markdown syntax for code blocks.

To style the code block and highlight the syntax to your liking, use your own CSS styles. Alternatively, if you like how code is highlighted in this documentation, you can use some styles we provide in the [poet-template-docs template repository](https://github.com/intentee/poet-template-docs) and get results similar to the example below:

```rust
fn main() {
    println!("Hello, Poet!");
}
```
