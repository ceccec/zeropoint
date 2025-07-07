## Defensive Frozen Hash Pattern

### Rationale

In Ruby, hashes loaded from JSON, cache, or external APIs may be frozen for safety or performance. Attempting to modify a frozen hash raises a runtime error. To ensure robust, mutation-safe code, Zeropoint provides a core utility to defensively duplicate hashes only when necessary.

### Implementation

The pattern is implemented in `lib/zeropoint/core/defensive_frozen_hash.rb`:

```ruby
module Zeropoint::Core::DefensiveFrozenHash
  def self.ensure_unfrozen_hash(hash)
    return hash unless hash.is_a?(Hash)
    hash.frozen? ? hash.dup : hash
  end
end
```

### Usage

Before mutating any hash that may be frozen:

```ruby
hash = Zeropoint::Core::DefensiveFrozenHash.ensure_unfrozen_hash(hash)
hash.merge!(other_hash)
```

This pattern is used throughout Zeropoint in configuration, caching, session, i18n, and learning systems. 