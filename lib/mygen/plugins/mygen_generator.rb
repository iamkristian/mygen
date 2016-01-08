require 'mygen/generator'
module Mygen
  module Plugins
    class MygenGenerator < Mygen::Generator
      def description
        "Generates a new mygen generator"
      end

      def call
        puts "create generator named #{@name}"
        b = binding
        fileutils.mkdir(@name)

      end
    end
  end
end
