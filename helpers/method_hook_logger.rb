module Ruboty
  module Helpers
    module MethodHookLogger
      def self.included(klass)
        klass.public_instance_methods(false).each do |method|
          klass.class_eval do
            alias_method "original_#{method}", method
            define_method(method) do
              class_name = self.class.to_s.split('::')[-1]
              puts "start : #{class_name} #{method}"
              result = send("original_#{method}".to_sym)
              puts "finish: #{class_name} #{method}"
              result
            end
          end
        end
      end
    end
  end
end
