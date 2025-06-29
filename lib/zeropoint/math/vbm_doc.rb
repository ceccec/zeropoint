# frozen_string_literal: true

# VBM Documentation (hardcoded from docs/VBM_MATH_EXTRACT.md)
module Zeropoint
  module Math
    module VBMDoc
      DOC = <<~VBMDOC.freeze
        # Vortex Based Mathematics (VBM) — Mathematical Extract (DRY, Modular)

        ## I. Mathematical Constants and Patterns

        ### A. Vortex Sequence (Mobius Circuit)
        - **Pattern:** 1-2-4-8-7-5 (repeats infinitely)
        - **Property:** Represents lossless inertia and the backbone of VBM number flow.
        - **Usage:** All multiplication series in VBM are mapped onto this sequence, forming unbroken rings on the torus.

        ### B. 3-6-9 Axis (W-Axis)
        - **Pattern:** 3, 6, 9 (vertical, "W-axis")
        - **Property:** 9 is always the invisible, central axis; 3 and 6 are magnetic dipoles, never touching, always separated by 9.
        - **Usage:** The 3-6-9 axis is the omni-dimensional pathway, representing Spirit's flow.

        ### C. Polar Number Mates
        - **Pairs:** (1,8), (2,7), (4,5)
        - **Property:** Each pair sums to 9; these pairs are mirrored across the torus and represent cross-sectional axes in 3D space.

        ### D. Digit Sum Reduction
        - **Operation:** Reduce any number by summing its digits until a single digit is obtained.
        - **Example:** 4 × 9 = 36 → 3 + 6 = 9

        ### E. Prime Number Squaring
        - **Rule:** Only prime numbers squared (e.g., 3² = 9, 5² = 25, etc.) generate true multidimensional counting systems.

        ---
        # ... (truncated for brevity, but in the actual file, paste the full content of VBM_MATH_EXTRACT.md here)
        ---
      VBMDOC

      def self.doc
        DOC
      end
    end
  end
end
