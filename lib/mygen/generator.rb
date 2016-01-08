module Mygen
  class Generator
    attr_accessor :name, :destination, :dry_run, :template_source_dir

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
      self.class.name.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").
        split('/').last.
        downcase
    end

    def fileutils
      dry_run ? FileUtils::DryRun : FileUtils::Verbose
    end

    def parse
      # read template files
      # eval generator rb for variables
      # process all template files with generator bindings
      files = Dir.glob("spec/fixtures/template/**")
      erb = ERB.new(File.read(files[0]))
      b = binding
      erb.result b
    end

    def mkdir(path)

    end

    # Check if the file exist - if so should content be overwritten,
    # or appended
    #
    def write_to_path(path, content)
    end

    def template_files(path = template_source_dir)
      Dir.glob(File.join(path, "**/*"))
    end

    def internal_template_files
      template_files(internal_template_source_dir)
    end

    def internal_template_source_dir
      File.join(Mygen.root, "templates", generator_name)
    end

    def make_template_tree(internal = false)
      @template_source_dir = internal_template_source_dir if internal
      fileutils.cp_r(template_source_dir, name)
    end

    def parse_template_files(files, bindings)
      files.each do |file|
        dest = file_destination(File.join(name), file, bindings)
      end
    end

    def parse_and_place_file(file, dest, bindings)
      erb = ERB.new(File.read(file))
      erb.result bindings
    end

    def file_destination(dest_dir, file, bindings)
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
