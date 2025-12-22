+++
id = "install"
description = "Install Poet via Cargo or prebuilt binaries."
layout = "LayoutDocumentationPage"
primary_collection = "docs"
title = "Installation"

[[collection]]
name = "docs"
after = "static-site-generator/introduction/what-is-poet"
parent = "static-site-generator/introduction/index"

[[collection]]
name = "create_content"
+++

Poet is a Rust application distributed as a single binary with no runtime dependencies.

## Install via Cargo
You can install Poet from Cargo by running:

```bash
cargo install poet
```

If you encounter issues with the standard installation, try using the Nightly toolchain:

```bash
cargo +nightly install poet
```
