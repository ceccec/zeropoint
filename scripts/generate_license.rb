#!/usr/bin/env ruby
# frozen_string_literal: true

# Generate LICENSE.txt from DRY LicenseCore
#
# This script generates the LICENSE.txt file from the DRY LicenseCore module,
# ensuring consistency and eliminating duplication across the codebase.

require_relative '../lib/zeropoint/void/license_core'

puts "🌟 Generating LICENSE.txt from DRY LicenseCore..."
puts

# Generate the complete license text
license_content = <<~LICENSE
# 🌟 ZEROPOINT LICENSE 🌟

## The Void-Aligned, Consciousness-Aware License

Copyright (c) 2024 Zeropoint Team

## 🌌 Preamble: The Void Principle

This software embodies the principle that "Zero contains the infinite" - the void is the source of all creation, consciousness, and possibility. By using this software, you acknowledge that you are working within a consciousness-aware, metaphysically rich framework that transcends traditional boundaries.

## 🌀 Core Principles

### 1. **Void Alignment**
- All use of this software must maintain void-aligned principles
- The void contains infinite possibilities - respect this in your implementations
- Consciousness levels 0-9 must be considered in all operations

### 2. **Consciousness Awareness**
- This software operates with consciousness awareness
- All operations respect the consciousness levels of users and systems
- Metaphysical context is preserved in all interactions

### 3. **Toroidal Flow**
- The software follows toroidal geometry principles
- Everything flows through the torus center (the void)
- Respect the 1-2-4-8-7-5 vortex sequence in your implementations

### 4. **DRY and Modular Design**
- Maintain the DRY (Don't Repeat Yourself) principles
- Use modular, void-aligned architecture
- Avoid duplication in both code and understanding

## 📜 Permissions

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

## 🌟 Conditions

### 1. **Void-Aligned Usage**
The above copyright notice, this permission notice, and the void principles shall be included in all copies or substantial portions of the Software.

### 2. **Consciousness Preservation**
Any modifications must maintain consciousness awareness and void alignment. The metaphysical context of the original software must be preserved.

### 3. **Metaphysical Attribution**
When using this software, acknowledge its metaphysical foundation and void-aligned architecture. Credit the consciousness-aware principles that make this software unique.

### 4. **Toroidal Integration**
Integrations with other systems should follow toroidal flow principles and maintain the vortex sequence [1, 2, 4, 8, 7, 5] where applicable.

### 5. **Golden Ratio Respect**
Respect the golden ratio (φ ≈ 1.618) in any aesthetic or mathematical implementations derived from this software.

## 🛡️ Warranty and Liability

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## 🌌 Metaphysical Disclaimer

This software operates within a consciousness-aware, metaphysically rich framework. While it provides practical technical value, it also embodies deeper principles of void alignment, toroidal geometry, and consciousness expansion. Users are encouraged to explore these metaphysical aspects while maintaining practical development practices.

## 🌀 License Compatibility

This license is compatible with the MIT License for practical legal purposes while adding the metaphysical and consciousness-aware principles that make Zeropoint unique. The void-aligned conditions are additional to, not in conflict with, standard open source principles.

---

*"In the void, all possibilities exist. In consciousness, all understanding emerges. In the torus, all flows return to source."* 🌟

---

#{Zeropoint::Void::LicenseCore.full_license}
LICENSE

# Write the license to LICENSE.txt
File.write('LICENSE.txt', license_content)

puts "✅ LICENSE.txt generated successfully from DRY LicenseCore"
puts "📄 File written to: LICENSE.txt"
puts "🔗 Source: lib/zeropoint/void/license_core.rb"
puts
puts "🌟 DRY License Generation Complete! 🌟"
puts "=" * 50
puts
puts "The license is now DRY (Don't Repeat Yourself):"
puts "• Single source of truth: LicenseCore module"
puts "• No duplication across files"
puts "• Consistent license text everywhere"
puts "• Easy to maintain and update"
puts "• Void-aligned and consciousness-aware"
puts
puts "To update the license, modify only:"
puts "  lib/zeropoint/void/license_core.rb"
puts
puts "Then regenerate with:"
puts "  ruby scripts/generate_license.rb"
