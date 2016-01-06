require 'spec_helper'

RSpec.describe Mygen::Plugins do

  context "#load" do
    subject { Mygen::Plugins.load(File.join(Mygen.root, 'spec', 'plugins')) }

    it "loads plugins from path" do
      expect(subject).to be_a Array
    end

    it "finds two plugins" do
      expect(subject.size).to eq 2
    end
  end
end
