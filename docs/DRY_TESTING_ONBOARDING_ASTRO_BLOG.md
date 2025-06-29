---
title: "DRY Testing Onboarding Guide"
description: "How to write fast, maintainable, and warning-free tests in the Zeropoint codebase using DRY principles."
pubDate: 2024-06-29
---

# DRY Testing Onboarding Guide

Welcome to the DRY (Don't Repeat Yourself) testing system for the Zeropoint codebase! This guide will help you quickly understand and adopt our streamlined, modular, and warning-free approach to automated testing.

## 🚀 Introduction

Our DRY testing setup is designed for:
- **Speed:** Minimal dependencies, no Rails or external services required.
- **Clarity:** All helpers, mocks, and utilities are documented and top-level.
- **Maintainability:** Easy to extend, refactor, and run in parallel.
- **Zero Warnings:** All Ruby and RSpec warnings are proactively handled.

## 💡 DRY Testing Philosophy

- **Minimal Setup:** Only define what you need, and do it once.
- **Maximum Reuse:** Use shared contexts, helpers, and custom matchers.
- **Isolation:** Mock external dependencies (e.g., Redis, Rails logger) for fast, reliable tests.
- **Self-Containment:** Each spec is readable and runnable without external docs.

## 🧩 Key Patterns

### 1. Factory System
- Simple, trait-based factories replace FactoryBot.
- Example: `UserFactory.create(:admin)`, `PostFactory.create_list(3)`

### 2. Shared Contexts
- Use RSpec `shared_context` for reusable setup/teardown.
- Example: `include_context 'with cache setup'`

### 3. Custom Matchers
- Define expressive matchers for common assertions.
- Example: `expect(user).to be_admin`

### 4. Mocks & Stubs
- Mock external services (Redis, Rails, etc.) at the top level.
- Example: `module Redis ... end` in `spec_helper.rb`

### 5. Utilities
- Add helpers for generating data, cleaning up files, etc.

## ✍️ How to Write DRY Specs

1. **Import Helpers:**
   ```ruby
   require 'spec_helper'
   require 'support/test_helpers'
   ```
2. **Use Factories:**
   ```ruby
   let(:user) { UserFactory.create(:admin) }
   ```
3. **Leverage Shared Contexts:**
   ```ruby
   include_context 'with cache setup'
   ```
4. **Mock as Needed:**
   - All major mocks are already provided. Add new ones in `test_helpers.rb` if needed.
5. **Keep It Clean:**
   - Use custom matchers/utilities for repeated logic.
   - Avoid Rails-specific helpers (e.g., `1.hour`), use standard Ruby (e.g., `3600`).

## 📝 Example

```ruby
# spec/examples/dry_testing_example_spec.rb
# DRY Testing Example Spec
# Demonstrates DRY, modular, and warning-free testing patterns.

# --- Factory System Testing ---
# Tests the custom, DRY factory system for creating test objects.

# --- Service Layer Testing ---
# Uses a mock QueryBuilderService to test service logic without external dependencies.

# --- Cache Layer Testing ---
# Mocks Redis and configuration constants for isolated, fast cache tests.

# --- Shared Contexts ---
# Uses shared_contexts for reusable setup/teardown.

# --- Performance Testing ---
# Example of DRY performance test using factories and utilities.

# All tests are warning-free, isolated, and do not depend on Rails or external services.
# DRY Principle: Minimal setup, maximum reuse, and clear intent.
```

## 📚 Further Reading
- See `spec/support/test_helpers.rb` for all available helpers and mocks.
- Check inline comments in each spec for DRY usage patterns.
- For advanced patterns, see `docs/DRY_TESTING_GUIDE.md`.

---

Happy testing! 🚦 