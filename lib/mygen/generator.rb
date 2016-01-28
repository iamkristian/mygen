require 'mygen/files'
require 'mygen/naming'
require 'mygen/templates'
# require 'byebug'

module Mygen
  class Generator
    include Mygen::Naming
    include Mygen::Files
    include Mygen::Templates

    attr_accessor :name, :dest_dir, :dry_run, :template_source_dir, :options

    def initialize
      @template_source_dir = File.join(ENV['HOME'], ".mygen", "plugins", generator_name, "templates").tr('\\', '/')
    end

    def self.descendants
      ObjectSpace.each_object(Class).select { |klass| klass < self }
    end

    def description
      "Plugin has no description"
    end

    def generator_name
      snake_case(self.class.name)
    end

    def fileutils
      dry_run ? FileUtils::DryRun : FileUtils::Verbose
    end

    def parent_dirs_dont_exist?(path)
      parent_dir = File.expand_path("..", path)
      return false if path.include?('__')
      return !File.exist?(path)
    end
  end
end
