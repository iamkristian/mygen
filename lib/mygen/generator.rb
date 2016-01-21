require 'mygen/naming'

module Mygen
  class Generator
    include Mygen::Naming
    attr_accessor :name, :dest_dir, :dry_run, :template_source_dir, :options

    def initialize
      @template_source_dir = File.join(ENV['HOME'], ".mygen", "plugins", generator_name, "templates")
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

    def template_files(path = template_source_dir)
      Dir.glob(File.join(path, "**/*")).select { |f| File.file? f }
    end

    def template_dirs(path = template_source_dir)
      Dir.glob(File.join(path, "**/*")).select { |f| File.directory? f }
    end

    def internal_template_files
      template_files(internal_template_source_dir)
    end

    def internal_template_source_dir
      File.join(Mygen.root, "templates", generator_name)
    end

    def make_template_tree_in_current_dir
      fileutils.mkdir_p(dest_dir) unless File.exist?(dest_dir)
      fileutils.cp_r(Dir.glob(File.join(template_source_dir, "*")), dest_dir)
    end

    def make_template_tree(internal = false)
      @template_source_dir = internal_template_source_dir if internal
      fileutils.rm_rf(dest_dir) if File.exist?(dest_dir)
      fileutils.cp_r(template_source_dir, dest_dir)
    end

    # rename directories that should be filtered, from __name
    # files should be from the destination, so no dirs needs to be filtered
    # and only files need to be processed.
    #
    def parse_templates(bindings)
      template_dirs(File.join(dest_dir)).each do |dir|
        dest = file_destination(dir, bindings)
        parent_dir = File.expand_path("..", dest)
        fileutils.mkdir_p(parent_dir) if parent_dirs_dont_exist?(dest)
        move_file_in_place(dir, dest)
      end
      # Filter files with erb
      template_files(File.join(dest_dir)).each do |file|
        dest = file_destination(file, bindings)
        # This is where you parse the erb files and fill in the contens
        if file.end_with? 'erb'
          parse(file, bindings)
        end
        move_file_in_place(file, dest)
      end
    end

    def parent_dirs_dont_exist?(path)
      parent_dir = File.expand_path("..", path)
      return false if path.include?('__')
      return !File.exist?(path)
    end

    def parse(file, bindings)
      erb = ERB.new(File.read(file))
      result = erb.result bindings
      File.open(file, "w") { |f| f.write(result) }
    end

    def move_file_in_place(src, dest)
      sf = File.absolute_path(src)
      df = File.absolute_path(dest)
      fileutils.mv(sf, df) unless sf == df
    end

    def parse_and_place_file(file, dest, bindings)
      erb = ERB.new(File.read(file))
      erb.result bindings
    end

    def file_destination(file, bindings)
      # subtract template_source_dir from path, add dest_dir and substitute filenames
      new_file = file.gsub(template_source_dir, '')
      replaced_filename(new_file, bindings)
    end

    private

    def replaced_filename(file, bindings)
      elements = File.basename(file).split('.')
      elements.pop if elements.last == 'erb'
      dirname = File.dirname(file)
      f = elements.map do |element|
        element.start_with?('__') ? eval( element.sub(/^__/, ''), bindings) : element
      end.join('.')
      File.join(dirname, f)
    end
  end
end
