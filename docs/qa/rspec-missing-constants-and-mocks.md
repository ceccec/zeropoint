---
title: "RSpec: Missing Constants and Mocks"
tags: [rspec, errors, missing-constants, mocks, qa]
related: [rspec_full_run.log]
date: 2024-06-08
---

# RSpec: Missing Constants and Mocks

## Problem
- RSpec test run reports errors for missing or uninitialized constants:
  - `Zeropoint::Vortex::Queryable`
  - `Zeropoint::Vortex::StreamProcessor`
- These errors occur in:
  - `spec/vortex/queryable_spec.rb`
  - `spec/vortex/stream_processor_spec.rb`

## Solution
- If these modules/classes were deleted or externalized, either:
  - Remove the affected specs
  - Or provide minimal mock implementations in the spec files to allow the suite to run
- Document the reason for removal or mocking in the QA library

## Example Mock
```ruby
module Zeropoint
  module Vortex
    module Queryable; end
    class StreamProcessor; end
  end
end
```

## References
- [docs/qa/rspec_full_run.log](rspec_full_run.log) 