module DirGlobIgnore

  module IgnoreFileList

    DEFAULT_FILE_NAME = '.ignore'.freeze

    attr_writer :ignore_file_name, :base_dir

    def ignore_file_name
      @ignore_file_name ||= DEFAULT_FILE_NAME
    end

    def base_dir
      @base_dir ||= Dir.pwd
    end

    def load_ignore_files
      @cache = {}
      ignore_files.each do |ignore_file|
        cache[File.dirname ignore_file] = load_ignore_file ignore_file
      end
      puts build_ignore_list.inspect
    end

    private

    attr_reader :cache

    def build_ignore_list
      ignore_list = []
      cache.each do |dir, patterns|
        patterns.each do |pattern|
          ignore_list.concat Dir.glob(File.join(dir, pattern), File::FNM_DOTMATCH)
        end
      end
      ignore_list
    end

    def load_ignore_file(ignore_file)
      File.readlines(ignore_file).map(&:chomp).reject do |entry|
        if entry =~ /^\s*#/
          # Ignore commented lines
          true
        elsif entry =~ /^\s*$/
          # Ignore empty lines
          true
        else
          false
        end
      end
    end

    def ignore_files
      file_pattern = File.join base_dir, '**', ignore_file_name
      Dir.glob file_pattern
    end


  end

end