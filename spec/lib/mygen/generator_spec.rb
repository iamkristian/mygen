require 'spec_helper'

RSpec.describe Mygen::Generator do

  context "#generator_name" do
    class TestGeneratorMixed < Mygen::Generator
    end

    it "makes camel case to snake case" do
      expect(TestGeneratorMixed.new.generator_name).to eq "test_generator_mixed"
    end
  end

  context "#template_files" do
    before do
      Mygen::Plugins.load(File.join(Mygen.root, 'spec', 'plugins'))
    end
    subject { Fiddlesticks.new.template_files
    it "finds temaplate files" do

    end
  end
end
