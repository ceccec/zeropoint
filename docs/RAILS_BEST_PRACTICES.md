# Rails Best Practices Guide

This guide outlines Rails best practices as applied in the Zeropoint project. Following these conventions ensures maintainability, scalability, and a seamless developer experience.

---

## 1. Project Structure
- **Controllers**: Located in `app/controllers/`, namespaced by feature/domain.
- **Views**: Located in `app/views/`, matching controller namespaces and actions.
- **Models**: Located in `app/models/`, one class per file, singular names.
- **Helpers**: Located in `app/helpers/`, for view logic only.
- **Services**: Located in `app/services/`, for business logic not belonging in models/controllers.
- **Concerns**: Shared code in `app/concerns/` for models/controllers.
- **Middleware**: Custom middleware in `app/middleware/`.
- **Specs/Tests**: All tests in `spec/` (RSpec) or `test/` (Minitest).
- **Configs**: All configuration in `config/` (routes, initializers, locales, etc).

---

## 2. Controllers
- **Skinny Controllers**: Keep controllers minimal; delegate logic to models/services.
- **RESTful Actions**: Use standard REST actions (`index`, `show`, `new`, `create`, `edit`, `update`, `destroy`).
- **Strong Parameters**: Use `params.require(...).permit(...)` for mass assignment.
- **Render Views**: Use `render` to display views; never embed HTML in controllers.
- **Filters**: Use `before_action`, `after_action`, and `around_action` for cross-cutting concerns.
- **Inheritance**: Inherit from `ApplicationController` for shared behavior.
- **Error Handling**: Use `rescue_from` for error management.

---

## 3. Views
- **No Logic in Views**: Keep logic out of views; use helpers for formatting.
- **Partial Templates**: Use partials (`_partial.html.erb`) for reusable view fragments.
- **Layouts**: Use layouts for shared page structure.
- **Content Security**: Escape output with `<%= %>` (not `<%== %>`), unless safe.
- **Asset Pipeline**: Use Rails asset helpers for images, stylesheets, and JavaScript.

---

## 4. Models
- **Skinny Models**: Business logic belongs in models, but keep them focused.
- **Validations**: Use `validates` for data integrity.
- **Associations**: Use `has_many`, `belongs_to`, etc. for relationships.
- **Scopes**: Use scopes for reusable query logic.
- **Callbacks**: Use judiciously; prefer service objects for complex flows.
- **Single Responsibility**: Each model should represent one concept.

---

## 5. Services & Concerns
- **Service Objects**: Place business logic that doesn't fit models/controllers in `app/services/`.
- **Concerns**: Use for shared code across models or controllers.
- **Naming**: Name services for their action (e.g., `UserSignupService`).

---

## 6. Routing
- **Resourceful Routes**: Use `resources` for RESTful controllers.
- **Namespacing**: Namespace routes for APIs or admin sections.
- **Custom Actions**: Use `member` or `collection` for non-RESTful actions.

---

## 7. Configuration & Initializers
- **Environment Config**: Use `config/environments/` for environment-specific settings.
- **Initializers**: Place app/library setup in `config/initializers/`.
- **Secrets**: Use Rails credentials or environment variables for sensitive data.

---

## 8. Internationalization (i18n)
- **Locale Files**: Store translations in `config/locales/`.
- **t() Helper**: Use `t('key')` for all user-facing strings.
- **Locale Switching**: Support user locale selection and detection.

---

## 9. Testing
- **RSpec/Minitest**: Use RSpec or Minitest for automated tests.
- **Factories**: Use FactoryBot for test data.
- **Request Specs**: Test controllers via request specs.
- **Model Specs**: Test validations, associations, and methods.
- **Service Specs**: Test service objects in isolation.
- **Continuous Integration**: Run tests on every commit (see `.github/workflows/`).

---

## 10. Security
- **Strong Parameters**: Always whitelist params.
- **Authentication**: Use secure authentication (Devise, has_secure_password, etc.).
- **Authorization**: Use Pundit, CanCanCan, or custom policies.
- **CSRF Protection**: Enabled by default; skip only for APIs if needed.
- **Escape Output**: Always escape user input in views.

---

## 11. Performance
- **Eager Loading**: Use `includes` to avoid N+1 queries.
- **Caching**: Use fragment, page, or Russian doll caching as appropriate.
- **Background Jobs**: Use ActiveJob for long-running tasks.
- **Database Indexes**: Add indexes for frequently queried columns.

---

## 12. Documentation
- **Inline Docs**: Use YARD/RDoc for public methods/classes.
- **README**: Keep `README.md` up to date with setup and usage.
- **Changelogs**: Maintain `CHANGELOG.md` for release notes.
- **API Docs**: Document API endpoints and usage.

---

## 13. Miscellaneous
- **Use Bundler**: Manage gems with `Gemfile` and `bundle install`.
- **Follow RuboCop**: Use RuboCop for style and linting.
- **Keep Dependencies Updated**: Regularly update gems and libraries.
- **Use Environment Variables**: For configuration that varies by environment.
- **Monitor Logs**: Use Rails logs for debugging and monitoring.

---

## References
- [Rails Guides](https://guides.rubyonrails.org/)
- [Ruby Style Guide](https://rubystyle.guide/)
- [RuboCop](https://github.com/rubocop/rubocop)
- [Better Specs](https://www.betterspecs.org/)

---

**Following these best practices ensures your Rails app is robust, maintainable, and a joy to work on!** 