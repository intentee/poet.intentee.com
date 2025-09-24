+++
id = "templating-engine-initial-page"
layout = "LayoutDocumentationPage"
primary_collection = "docs"
title = "What are Rhai Components?"

[[collection]]
after = "templating-engine/index"
name = "docs"
parent = "templating-engine/index"

[[collection]]
name = "create_content"
+++

Poet's shortcodes syntax is based on the [Rhai scripting language](https://rhai.rs/). 

Rhai is a small, fast, easy-to-use scripting language and evaluation engine that integrates tightly with Rust.

The only extension that Poet makes to Rhai is the `component { ... }` block inside which you can place a JSX-like syntax. This syntax is very simialar to [JSX](https://react.dev/learn/writing-markup-with-jsx) and we explain the differences based on some examples in the [Poet and JSX differences](templating-engine/poet-and-jsx-differences) article.

To learn more about the Rhai syntax itself, you can refer to their [documentation](https://rhai.rs/book/ref/index.html).

<Note>
    A big thank you to [@schungx](https://github.com/schungx) from the Rhai team for helping us with implementing the Rhai components in Poet!
</Note>
