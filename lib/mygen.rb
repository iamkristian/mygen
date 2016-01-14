require "mygen/version"
require "mygen/plugins"
require "mygen/plugins/mygen_generator"
require "mygen/generator"
require "mygen/naming"
require "erb"

module Mygen
  def self.root
    File.dirname __dir__
  end
end
