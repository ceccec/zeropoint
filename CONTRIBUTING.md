# Contributing to Zeropoint 🌌

Thank you for your interest in contributing to Zeropoint! This document provides guidelines and information for contributors.

## 🤝 Code of Conduct

This project adheres to the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

## 🚀 Quick Start

### Prerequisites

- Ruby 3.0.0 or higher
- Rails 7.0 or higher
- Git
- A GitHub account

### Development Setup

1. **Fork the repository**
   ```bash
   git clone https://github.com/YOUR_USERNAME/zeropoint.git
   cd zeropoint
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```

3. **Setup database**
   ```bash
   bundle exec rails db:create db:migrate db:seed
   ```

4. **Run tests to ensure everything works**
   ```bash
   bundle exec rspec
   ```

## 📝 Development Workflow

### 1. Create a Feature Branch

```bash
git checkout -b feature/your-feature-name
# or
git checkout -b fix/your-bug-fix
```

### 2. Make Your Changes

- Write clean, well-documented code
- Follow the existing code style and conventions
- Add tests for new functionality
- Update documentation as needed

### 3. Run Tests and Quality Checks

```bash
# Run the full test suite
bundle exec rspec

# Run linting
bundle exec rubocop

# Run security audit
bundle exec brakeman

# Run performance checks
bundle exec rubocop-performance
```

### 4. Commit Your Changes

Follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

```bash
git commit -m "feat: add consciousness-aware error handling"
git commit -m "fix: resolve vortex streaming issue"
git commit -m "docs: update API documentation"
```

### 5. Push and Create a Pull Request

```bash
git push origin feature/your-feature-name
```

## 🧪 Testing Guidelines

### Writing Tests

- Write tests for all new functionality
- Use descriptive test names
- Follow the existing test patterns
- Aim for high test coverage

### Test Structure

```ruby
RSpec.describe Zeropoint::YourClass do
  describe "#your_method" do
    context "when condition is met" do
      it "returns expected result" do
        # Test implementation
      end
    end
  end
end
```

### Running Tests

```bash
# Run all tests
bundle exec rspec

# Run specific test file
bundle exec rspec spec/zeropoint/your_class_spec.rb

# Run with coverage
bundle exec rspec --coverage

# Run tests in parallel (if available)
bundle exec parallel_rspec spec/
```

## 🔍 Code Quality

### RuboCop

We use RuboCop for code style enforcement. Run it before committing:

```bash
bundle exec rubocop
bundle exec rubocop -a  # Auto-correct issues
```

### Reek

We use Reek for code smell detection:

```bash
bundle exec reek
```

### Brakeman

We use Brakeman for security analysis:

```bash
bundle exec brakeman
```

## 📚 Documentation

### Code Documentation

- Use YARD for code documentation
- Document all public methods and classes
- Include examples in documentation

```ruby
# @param [String] message The error message
# @param [Hash] context Additional context information
# @return [ConsciousnessAwareError] The enhanced error
def consciousness_aware_error(message, context = {})
  # Implementation
end
```

### API Documentation

- Update API documentation for any changes
- Include request/response examples
- Document error codes and messages

### README Updates

- Update README.md for new features
- Add usage examples
- Update installation instructions if needed

## 🏗️ Architecture Guidelines

### Consciousness-Aware Patterns

- Follow consciousness-aware error handling patterns
- Use golden ratio optimization where applicable
- Implement observer-aware patterns for security

### Vortex Mathematics

- Apply vortex mathematics for data flow optimization
- Use appropriate batch sizes for vortex operations
- Implement streaming patterns for large datasets

### GraphQL Integration

- Follow GraphQL best practices
- Implement proper batch loading
- Use persisted queries for performance

## 🚀 Release Process

### Version Management

We follow [Semantic Versioning](https://semver.org/):

- **MAJOR**: Incompatible API changes
- **MINOR**: Backwards-compatible functionality additions
- **PATCH**: Backwards-compatible bug fixes

### Release Checklist

Before releasing:

- [ ] All tests pass
- [ ] Code coverage is adequate
- [ ] Documentation is updated
- [ ] CHANGELOG.md is updated
- [ ] Version is bumped
- [ ] Security audit passes
- [ ] Performance benchmarks are acceptable

## 🐛 Bug Reports

### Before Submitting

1. Check existing issues
2. Search the documentation
3. Try to reproduce the issue
4. Check if it's a known issue

### Bug Report Template

```markdown
**Description**
Brief description of the issue

**Steps to Reproduce**
1. Step one
2. Step two
3. Step three

**Expected Behavior**
What you expected to happen

**Actual Behavior**
What actually happened

**Environment**
- Ruby version:
- Rails version:
- Zeropoint version:
- Operating system:

**Additional Information**
Any other relevant information
```

## 💡 Feature Requests

### Before Submitting

1. Check if the feature already exists
2. Search existing issues and discussions
3. Consider if it aligns with project goals

### Feature Request Template

```markdown
**Problem Statement**
Describe the problem you're trying to solve

**Proposed Solution**
Describe your proposed solution

**Alternative Solutions**
Describe any alternative solutions you've considered

**Additional Context**
Any other relevant information
```

## 🏆 Recognition

Contributors will be recognized in:

- [CHANGELOG.md](CHANGELOG.md)
- [README.md](README.md) contributors section
- GitHub contributors page

## 📞 Getting Help

- **Documentation**: [https://zeropoint.bg/docs](https://zeropoint.bg/docs)
- **Issues**: [GitHub Issues](https://github.com/zeropoint/zeropoint/issues)
- **Discussions**: [GitHub Discussions](https://github.com/zeropoint/zeropoint/discussions)
- **Email**: team@zeropoint.bg

## 🙏 Thank You

Thank you for contributing to Zeropoint! Your contributions help make this framework better for everyone in the consciousness-aware computing community.

---

**Remember**: Every contribution, no matter how small, makes a difference! 🌌✨ 