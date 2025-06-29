---
title: "RuboCop: Plugin Migration and Cop Namespace Errors"
tags: [rubocop, plugin, migration, cop, namespace, qa]
related: [rubocop_full_run.log, .rubocop.yml]
date: 2024-06-08
---

# RuboCop: Plugin Migration and Cop Namespace Errors

## Problem
- RuboCop reports:
  - `rubocop-performance extension supports plugin, specify plugins: rubocop-performance instead of require: rubocop-performance` in `.rubocop.yml`.
  - `Rails/SelectMap has the wrong namespace - replace it with Performance/SelectMap`.
  - `Error: unrecognized cop or department disable found in .rubocop.yml`.

## Solution
- Update `.rubocop.yml`:
  - Use `plugins:` for `rubocop-performance` instead of `require:`.
  - Change `Rails/SelectMap` to `Performance/SelectMap`.
  - Remove or correct any unrecognized cop or department disables.
- Reference the [RuboCop plugin migration guide](https://docs.rubocop.org/rubocop/plugin_migration_guide.html).

## Example Correction
```yaml
plugins:
  - rubocop-performance
  - rubocop-rspec

Performance/SelectMap:
  Enabled: true
```

## References
- [docs/qa/rubocop_full_run.log](rubocop_full_run.log)
- [.rubocop.yml](../../.rubocop.yml) 