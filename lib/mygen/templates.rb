module Mygen
  module Templates
    def make_template_tree_in_current_dir
      fileutils.mkdir_p(dest_dir) unless File.exist?(dest_dir)
      files = Dir.glob(File.join(template_source_dir, "/*"))
      fileutils.cp_r(files, dest_dir)
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

    def parse(file, bindings)
      erb = ERB.new(File.read(file))
      result = erb.result bindings
      File.open(file, "w") { |f| f.write(result) }
    end
  end
end
