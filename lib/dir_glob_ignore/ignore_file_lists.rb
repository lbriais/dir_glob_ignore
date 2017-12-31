module DirGlobIgnore

  class IgnoreFileLists

    DEFAULT_FILE_NAME = '.ignore'.freeze

    attr_writer :ignore_file_name, :base_dir

    def initialize(base_dir = nil)
      self.base_dir = base_dir
    end

    def ignore_file_name
      @ignore_file_name ||= DEFAULT_FILE_NAME
    end

    def base_dir
      @base_dir ||= Dir.pwd
    end

    def load_ignore_files
      @cache = {}
      ignore_files.each do |ignore_file|
        cache[File.expand_path File.dirname ignore_file] = {
            ignore_file: ignore_file,
            patterns: load_ignore_file(ignore_file),
            ignored_files: []
        }
      end
      build_cached_ignore_lists
    end

    def ignore_file?(file)
      cache.values.each do |info|
        return true if info[:ignored_files].include? File.expand_path(file)
      end
      false
    end

    private

    attr_reader :cache

    def build_cached_ignore_lists
      cache.each do |dir, info|
        info[:patterns].each do |pattern|
          info[:ignored_files].concat Dir.glob(File.join(dir, pattern), File::FNM_DOTMATCH)
        end
      end
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