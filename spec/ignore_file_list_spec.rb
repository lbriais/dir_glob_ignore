require 'spec_helper'

describe DirGlobIgnore::IgnoreFileList do

  let(:test_root) { File.expand_path File.join('..', '..', 'test'), __FILE__ }

  let(:test_class) do
    class TestClass
      include DirGlobIgnore::IgnoreFileList
    end
  end

  subject do
    s = test_class.new
    s.base_dir = test_root
    s
  end

  it 'should start the search of ignore files from a base dir' do
    expect(subject.base_dir).to eq test_root
  end

  it 'should search for all specified ".ignore" files' do
    expect(subject.send(:ignore_files).size).to eq 3
  end

  context 'when load ignore files' do

    it 'should load ignore file content into the cache' do
      expect {subject.load_ignore_files}.not_to raise_error
      cache = subject.send :cache
      expect(cache.size).to eq 3
      expect(cache[test_root].size).to eq 2
    end

  end

end