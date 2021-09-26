# Rubocop::Dependency

[![Coverage Status](https://coveralls.io/repos/github/keik/rubocop-dependency/badge.svg?branch=circleci)](https://coveralls.io/github/keik/rubocop-dependency?branch=circleci)

Code style checking for dependencies control, as an extension to [RuboCop](https://github.com/rubocop/rubocop).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rubocop-dependency', require: false
```

## Usage

Put this into your .rubocop.yml.

```yaml
require: rubocop-dependency
```

## Cops

### Dependency/OverBoundary

Check not to refer constants over dependency boundaries which given from `Rules` config.

When the following `Rules` is given,

```yaml
Rules:                      # Array of each rules
  - BannedConsts: Foo       # Array<String> | String.
    FromNamespacePatterns:  # Array<String> | String. This value is used as Regexp pattern.
      - \ABar(\W|\z)
```

The following code is considered problems.

```ruby
class Bar
  Foo
  ^^^ Const `Foo` cannot use from namespace `Bar`.
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/keik/rubocop-dependency.
