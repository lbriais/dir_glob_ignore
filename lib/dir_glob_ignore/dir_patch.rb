class Dir

  def self.glob_with_ignore_file(ignore_file, base_dir, *glob_args, &block)
    filter = DirGlobIgnore::IgnoreFileLists.new base_dir
    filter.ignore_file_name = ignore_file
    filter.load_ignore_files
    Dir.glob(*glob_args).reject do |file|
      if filter.ignore_file? file
        true
      else
        yield file if block_given?
        false
      end
    end
  end

end