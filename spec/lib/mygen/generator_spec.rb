require 'spec_helper'

RSpec.describe Mygen::Generator do

  let(:plugins_root) { File.join(Mygen.root, 'spec', 'plugins') }
  before do
    Mygen::Plugins.load(plugins_root)
  end

  context "#generator_name" do
    class TestGeneratorMixed < Mygen::Generator
    end

    it "makes camel case to snake case" do
      expect(TestGeneratorMixed.new.generator_name).to eq "test_generator_mixed"
    end
  end

  context "#template_files" do
    subject { Fiddlesticks.new.template_files }

    it "finds temaplate files" do
      expect(subject).to be_a Array
    end
  end

  context "#file_destination" do
    let(:plugin) { Fiddlesticks.new }

    before do
      plugin.template_source_dir = File.join(plugins_root, plugin.generator_name, "templates")
    end

    it "substitutes erb files" do
      name = "fish"
      b = binding
      file = plugin.template_files.select { |f| f.end_with? "erb" }.first
      expect(plugin.file_destination(File.join("fish"), file, b)).to eq "/lib/fish.rb"
    end

    it "substitutes __ named directories" do
      name = "fish"
      b = binding
      file = plugin.template_dirs.select { |d| d.end_with? "__name" }.first
      expect(plugin.file_destination(File.join("fish"), file, b)).to eq "/lib/fish"
    end
  end
end
