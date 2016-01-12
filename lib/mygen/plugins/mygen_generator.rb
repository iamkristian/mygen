require 'mygen/generator'
module Mygen
  module Plugins
    class MygenGenerator < Mygen::Generator
      def description
        "Generates a new mygen generator"
      end

      def call
        puts "create generator named #{name}"
        make_template_tree(true)
        @bleh = "fish"
        @name = name
        b = binding
        parse_templates(b)
      end
    end
  end
end
