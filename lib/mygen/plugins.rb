module Mygen
  #
  # Load plugins from a dir (default to $HOME/.mygen/plugins)
  # Add all subdirs to $LOAD_PATH, and get ancestors of the generator class
  # And register them in the myg shell command
  #
  module Plugins
    home = ENV['HOME'].gsub /\\/, '/'
    def self.load(path = File.join(, ".mygen", "plugins"))
      dirs = Dir.glob(File.join(path, "**/*.rb"))
      dirs.each do |d|
        register_plugin(d)
      end
      Generator.descendants
    end

    def self.register_plugin(plugin)
      dir = File.dirname(plugin)
      $LOAD_PATH.unshift(dir) unless $LOAD_PATH.include?(dir)
      klass = File.basename(plugin, '.rb').downcase
      require klass
    end
  end
end
