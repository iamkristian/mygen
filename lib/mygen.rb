require "mygen/version"
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
end
