require 'byebug'
module Mygen
  module Files
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

    def file_destination(file, bindings)
      # subtract template_source_dir from path, add dest_dir and substitute filenames
      new_file = file.gsub(template_source_dir, '')
      replaced_filename(new_file, bindings)
    end

    def move_file_in_place(src, dest)
      sf = File.absolute_path(src)
      df = File.absolute_path(dest)
      file_exist = File.exist?(df)
      fileutils.mv(sf, df) if sf != df && !file_exist

      if file_exist && sf != df
        Dir.glob(File.join(sf, "/*")).each do |f|
          next if f == sf
          file = f.sub(sf, '')
          new_name = File.join(df, file)
          next if directory_exists? new_name
          fileutils.mv(f, File.join(df, file))
        end
        fileutils.rm_rf(sf)
      end
    end

    def directory_exists?(path)
      File.directory?(path) && File.exist?(path)
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
