# Pin npm packages by running ./bin/importmap

# Core Rails imports
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true

# Zeropoint-specific imports
pin "zeropoint", to: "zeropoint/index.js"
pin "zeropoint/controllers", to: "zeropoint/controllers/index.js"
pin "zeropoint/utils", to: "zeropoint/utils/index.js"

# Application entry point
pin_all_from "app/javascript/controllers", under: "controllers" 