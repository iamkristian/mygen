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
        parse_template_files(internal_template_files, b)
      end
    end
  end
end
