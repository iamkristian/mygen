module Mygen
  class Generator
    attr_accessor :name, :destination
    def self.descendants
      ObjectSpace.each_object(Class).select { |klass| klass < self }
    end

    def description
      "Plugin has no description"
    end
  end
end
