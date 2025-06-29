# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )

# Manifest-driven asset precompilation from canonical seed
Rails.application.config.assets.precompile += Zeropoint::Manifest.manifestation(:assets)[:all]

# Add TypeScript assets to the asset pipeline
Rails.application.config.assets.paths << Rails.root.join("typescript")
Rails.application.config.assets.paths << Rails.root.join("app", "assets", "javascripts")

# Precompile TypeScript files
Rails.application.config.assets.precompile += %w[
  typescript/index.js
  typescript/controllers/*.js
  typescript/hooks/*.js
  typescript/utils/*.js
]
