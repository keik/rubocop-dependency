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
          current_namespace =
            node
            .each_ancestor(:class, :module)
            .map { |a| a.defined_module_name }
            .reverse.join('::')

          if cop_config['Rules']
             .select { |rule|
               Array(rule['BannedConsts']).include?(const_name)
             }
             .any? { |rule|
               Array(rule['FromNamespacePatterns']).any? { |from_pattern|
                 Regexp.new(from_pattern).match?(current_namespace)
               }
             }
            add_offense(node, message: "Const `#{const_name}` cannot use from namespace `#{current_namespace}`.")
          end
        end
      end
    end
  end
end
