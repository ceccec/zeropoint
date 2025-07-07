# Rails + Zeropoint/Uroboros Best Practices

## 1. API-Only Mode
- Use Rails API-only mode for backend services that do not serve HTML.
- Detect API-only mode automatically or set `config.api_only = true` in `config/application.rb`.
- Remove unnecessary middleware (like Sprockets) in API-only mode to reduce memory and boot time.

## 2. Asset Pipeline
- If you need assets (for admin or GraphQL playground), ensure `app/assets/config/manifest.js` exists and is correct.
- For pure APIs, you can remove Sprockets and related gems from your Gemfile.

## 3. GraphQL Gateway
- Centralize all API logic in a single gateway controller (e.g., `Zeropoint::GatewayController`).
- Use strong parameter validation and error handling.
- Document your GraphQL schema and provide a playground for testing.

## 4. Internationalization (I18n)
- Store translations in `config/locales/`.
- Use I18n in controllers, models, and views for all user-facing strings.
- Detect and set locale from request headers or params.

## 5. Consciousness-Aware & Observer Patterns
- Use Rails concerns for modular, reusable logic (e.g., `ConsciousnessAware`, `ObserverAware`).
- Keep concerns focused and composable.
- Document the intent and usage of each concern.

## 6. Caching & Performance
- Use Redis or Memcached for caching expensive computations and API responses.
- Implement unified caching logic in a service or concern (e.g., `Vortex::CacheMatrix`).
- Use background jobs (e.g., Sidekiq) for long-running or batch tasks.

## 7. Intelligent Detection & Auto-Configuration
- Detect environment, database, and available gems at boot.
- Log a configuration summary at startup for transparency.
- Use initializers for all detection logic, and keep them idempotent.

## 8. Testing & Quality
- Use RSpec for all models, services, and controllers.
- Use FactoryBot for test data.
- Run RuboCop and other linters in CI.
- Write integration tests for the GraphQL gateway.

## 9. Documentation
- Maintain up-to-date docs in the `docs/` directory.
- Document all public APIs, best practices, and architectural decisions.
- Use inline comments for complex logic, especially in concerns and services.

## 10. Security
- Sanitize all inputs, especially in GraphQL resolvers.
- Use strong parameters and authentication for all endpoints.
- Regularly update dependencies and monitor for vulnerabilities.

## 11. Refactoring & Code Organization
- Keep controllers thin; move business logic to services and concerns.
- Use service objects for complex workflows.
- Regularly refactor to keep code DRY and maintainable.

## 12. Error Handling
- Use custom error classes for domain-specific errors.
- Return consistent error responses from the API.
- Log all exceptions with context for debugging.

## 13. Deployment & Environment
- Use environment variables for secrets and configuration.
- Use Docker or similar tools for consistent deployments.
- Monitor application health and performance in production.

---

### Uroboros/Meta Best Practices
- Embrace self-documenting code and systems.
- Use pattern-based UUIDs and vortex transformations for traceability.
- Allow the system to learn from its own codebase (e.g., Git-based intelligence).
- Encourage modularity and composability at every layer. 