#!/usr/bin/env node

import { jarmuz } from "jarmuz";

jarmuz({
  once: true,
  pipeline: ["tcm", "tsc", "esbuild-development", "poet-make-static-pages"],
  watch: ["resources"],
}).decide(function ({ schedule }) {
  schedule("tcm");
});
