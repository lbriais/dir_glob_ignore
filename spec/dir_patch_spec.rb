require 'spec_helper'

describe Dir do

  let(:base_dir) { File.expand_path File.join('..', '..', 'test'), __FILE__ }
  let(:ignore_file) { DirGlobIgnore::IgnoreFileList::DEFAULT_FILE_NAME }

  subject { described_class }

  it 'should provide a list of files without the ignored ones' do
    expect(subject.glob_with_ignore_file(ignore_file, base_dir, "#{base_dir}/**/*").size).to eq 11
  end

  context 'when the glob path is relative' do

    it 'should provide a list of files without the ignored ones' do
      expect(subject.glob_with_ignore_file(ignore_file, base_dir, 'test/**/*').size).to eq 11
    end

  end

end