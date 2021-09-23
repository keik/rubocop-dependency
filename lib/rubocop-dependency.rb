# frozen_string_literal: true

require 'rubocop'

require_relative 'rubocop/dependency'
require_relative 'rubocop/dependency/version'
require_relative 'rubocop/dependency/inject'

RuboCop::Dependency::Inject.defaults!

require_relative 'rubocop/cop/dependency_cops'
