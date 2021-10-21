require 'spec_helper'

RSpec.describe AbstractListImages do
  let(:instance) { DummyListImages.instance }

  let(:file_path) do
    File.expand_path(
      File.join(
        File.dirname(__FILE__),
        '../../data/dummy.txt'
      )
    )
  end

  before(:all) do
    class DummyListImages < AbstractListImages
      def file_name
        'dummy.txt'
      end
    end
  end

  before do
    File.write(file_path, '')
    instance.instance_variable_set(:@backend, nil)
    instance.send(:load_backend!)
  end

  after do
    File.delete(file_path) if File.exist?(file_path)
  end

  describe '#add' do
    subject { instance.add(string) }

    before do
      File.open(file_path, 'w') { |f| f.write("tree\nplatane")}
    end

    let(:string) { 'hello' }

    it 'adds to file' do
      expect(File.read(file_path)).not_to include(string)

      subject

      expect(File.read(file_path)).to include(string)
    end

    it 'adds to backend' do
      expect(instance.include?(string)).to eq(false)

      subject

      expect(instance.include?(string)).to eq(true)
    end
  end

  describe '#include?' do
    subject { instance.include?(string) }

    let(:valid_string) { 'hello' }

    before do
      instance.add(valid_string)
    end

    context do
      let(:string) { valid_string }

      it { is_expected.to eq(true) }
    end

    context do
      let(:string) { "#{valid_string} nope" }

      it { is_expected.to eq(false) }
    end
  end
end
