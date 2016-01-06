module Mygen
  class Generator
    attr_accessor :name, :destination
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
  end
end
