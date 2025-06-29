# RuboCop Auto-Fixable Errors - Documentation

This document summarizes the types of RuboCop offenses that were automatically fixed (`-A`/`--autocorrect-all`) in the Zero Point gem codebase, with examples and explanations.

## 1. Layout/TrailingWhitespace
**Description:** Removes unnecessary spaces at the end of lines.
**Example (before):**
```ruby
puts 'Hello, world!' 
```
**Example (after):**
```ruby
puts 'Hello, world!'
```

## 2. Layout/TrailingEmptyLines
**Description:** Ensures files end with a single newline.
**Example (before):**
```ruby
puts 'Done!'
    
```
**Example (after):**
```ruby
puts 'Done!'
```

## 3. Layout/ArgumentAlignment & Layout/FirstHashElementIndentation
**Description:** Aligns arguments and hash elements for readability.
**Example (before):**
```ruby
some_method(
  foo: 1,
bar: 2
)
```
**Example (after):**
```ruby
some_method(
  foo: 1,
  bar: 2
)
```

## 4. Style/TrailingCommaInArrayLiteral & Style/TrailingCommaInHashLiteral
**Description:** Ensures a trailing comma after the last item in multiline arrays/hashes.
**Example (before):**
```ruby
arr = [
  1,
  2
]
```
**Example (after):**
```ruby
arr = [
  1,
  2,
]
```

## 5. Style/SymbolArray & Style/WordArray
**Description:** Uses `%i[]` for symbol arrays and `%w[]` for word arrays.
**Example (before):**
```ruby
[:foo, :bar, :baz]
['foo', 'bar', 'baz']
```
**Example (after):**
```ruby
%i[foo bar baz]
%w[foo bar baz]
```

## 6. Style/ExpandPathArguments
**Description:** Uses `expand_path('..', __dir__)` instead of `expand_path('../..', __FILE__)`.
**Example (before):**
```ruby
File.expand_path('../..', __FILE__)
```
**Example (after):**
```ruby
File.expand_path('..', __dir__)
```

## 7. Style/BlockDelimiters
**Description:** Uses `do...end` for multiline blocks instead of `{...}`.
**Example (before):**
```ruby
[1, 2, 3].each { |n|
  puts n
}
```
**Example (after):**
```ruby
[1, 2, 3].each do |n|
  puts n
end
```

## 8. Style/RedundantBegin
**Description:** Removes unnecessary `begin` blocks.
**Example (before):**
```ruby
begin
  do_something
rescue
  handle_error
end
```
**Example (after):**
```ruby
do_something
rescue
  handle_error
```

## 9. Style/SymbolProc
**Description:** Uses `&:method_name` instead of `{ |x| x.method_name }`.
**Example (before):**
```ruby
arr.any? { |x| x.nil? }
```
**Example (after):**
```ruby
arr.any?(&:nil?)
```

## 10. Layout/EmptyLinesAroundBlockBody
**Description:** Removes extra empty lines at the start/end of blocks.
**Example (before):**
```ruby
do

  something

end
```
**Example (after):**
```ruby
do
  something
end
```

## 11. Layout/IndentationWidth
**Description:** Ensures consistent indentation (usually 2 spaces).
**Example (before):**
```ruby
    puts 'indented'
```
**Example (after):**
```ruby
  puts 'indented'
```

## 12. Layout/HashAlignment
**Description:** Aligns hash keys for readability.
**Example (before):**
```ruby
{
foo: 1,
  bar: 2
}
```
**Example (after):**
```ruby
{
  foo: 1,
  bar: 2
}
```

## 13. Style/DefWithParentheses
**Description:** Omits parentheses for methods with no arguments.
**Example (before):**
```ruby
def foo()
  42
end
```
**Example (after):**
```ruby
def foo
  42
end
```

## 14. Style/TrailingCommaInArguments
**Description:** Ensures a trailing comma after the last argument in multiline method calls.
**Example (before):**
```ruby
some_method(
  foo,
  bar
)
```
**Example (after):**
```ruby
some_method(
  foo,
  bar,
)
```

## 15. Lint/DuplicateRequire
**Description:** Removes duplicate `require` statements.
**Example (before):**
```ruby
require 'ostruct'
require 'ostruct'
```
**Example (after):**
```ruby
require 'ostruct'
```

## 16. Lint/UnusedBlockArgument & Lint/UnusedMethodArgument
**Description:** Renames unused block/method arguments to `_` or `_arg`.
**Example (before):**
```ruby
def foo(bar)
end
```
**Example (after):**
```ruby
def foo(_bar)
end
```

## 17. Layout/EmptyLineAfterGuardClause
**Description:** Adds an empty line after guard clauses for readability.
**Example (before):**
```ruby
return unless something?
do_something
```
**Example (after):**
```ruby
return unless something?

do_something
```

---

**Note:**
- These fixes were applied automatically by running `rubocop -A`.
- Some remaining offenses require manual refactoring (e.g., method/class length, complexity, naming conventions, RSpec best practices).
- The codebase is now much cleaner and more consistent as a result of these auto-fixes. 