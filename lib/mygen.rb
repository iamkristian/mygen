require "mygen/version"
require "mygen/plugins"
require "mygen/generator"
require "erb"

module Mygen


  def self.parse
    # read template files
    # eval generator rb for variables
    # process all template files with generator bindings
    files = Dir.glob("spec/fixtures/template/**")
    erb = ERB.new(File.read(files[0]))
    b = binding
    erb.result b
  end

  def self.root
    File.dirname __dir__
  end
end
