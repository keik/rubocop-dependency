# frozen_string_literal: true

require_relative "lib/rubocop/dependency/version"

Gem::Specification.new do |spec|
  spec.name = "rubocop-dependency"
  spec.version = RuboCop::Dependency::VERSION
  spec.authors = ["KATO Kei"]
  spec.email = ["k4t0.kei@gmail.com"]
  spec.summary = "Code style checking for dependencies control."
  spec.description = <<-DESCRIPTION
    Code style checking for dependencies control.
    A plugin for the RuboCop code style enforcing & linting tool.
  DESCRIPTION
  spec.homepage = "https://github.com/keik/rubocop-dependency"
  spec.licenses = ['MIT']

  spec.required_ruby_version = Gem::Requirement.new(">= 2.5.0")
  spec.require_paths = ["lib"]
  spec.files = Dir[
    'lib/**/*',
    'config/default.yml',
    '*.md'
  ]
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/keik/rubocop-dependency"
  spec.metadata["changelog_uri"] = "https://github.com/keik/rubocop-dependency/CHANGELOG.md"

  spec.add_runtime_dependency 'rubocop'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'simplecov-lcov'
end
