require 'spec_helper'

describe DirGlobIgnore::IgnoreFileLists do

  let(:test_root) { File.expand_path File.join('..', '..', 'test'), __FILE__ }

  let(:an_ignored_file) { File.join test_root, 'file1.txt'}
  let(:a_non_ignored_file) { File.join test_root, 'file2.rb'}

  subject { described_class.new test_root }

  it 'should start the search of ignore files from a base dir' do
    expect(subject.base_dir).to eq test_root
  end

  it 'should search for all specified ".ignore" files' do
    expect(subject.send(:ignore_files).size).to eq 3
  end

  context 'when loading ignore files' do

    it 'should build lists of files to be ignored into a cache' do
      expect {subject.load_ignore_files}.not_to raise_error
      cache = subject.send :cache
      # There are 3 .ignore files in tests
      expect(cache.size).to eq 3
      # each path leads to an ignore list
      cache.values.each do |info|
        expect(info[:ignored_files]).to be_an Array
        expect(info[:ignored_files]).not_to be_empty
      end
    end

    it 'should tell if a file should be ignored or not' do
      subject.load_ignore_files
      expect(subject.ignore_file? an_ignored_file).to be_truthy
      expect(subject.ignore_file? a_non_ignored_file).to be_falsey

    end

  end

end