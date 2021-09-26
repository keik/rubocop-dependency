# frozen_string_literal: true

module RuboCop
  module Cop
    module Dependency
      # Check not to refer constants over dependency boundaries which given from `Rules` config.
      #
      # @example
      #   # Rules:
      #   #   - BannedConsts: Foo
      #   #     FromNamespacePatterns:
      #   #       - \ABar(\W|\z)
      #
      #   class Bar
      #     # Bad. Cannot refer Foo from Bar namespace
      #     Foo
      #   end
      #
      class OverBoundary < Base
        def on_const(node)
          const_name = node.const_name
          parent_module_name = node.parent_module_name

          if cop_config['Rules']
             .select { |rule|
               Array(rule['BannedConsts']).include?(const_name)
             }
             .any? { |rule|
               Array(rule['FromNamespacePatterns']).any? { |from_pattern|
                 Regexp.new(from_pattern).match?(parent_module_name)
               }
             }
            add_offense(node, message: "Const `#{const_name}` cannot use from namespace `#{parent_module_name}`.")
          end
        end
      end
    end
  end
end
