require 'spec_helper'

RSpec.describe Mygen::Naming do
  include Mygen::Naming

  context "#camel_case" do
    it "converts snake case into camel case" do
      expect(camel_case("this_is_a_string")).to eq "ThisIsAString"
    end

    it "converts words with dash into camel case" do
      expect(camel_case("this-is-a-string")).to eq "ThisIsAString"
    end
  end

  context "#snake_case" do
    it "converts camel case into snake case" do
      expect(snake_case("ThisIsAnExampleOfCamelCase")).to eq "this_is_an_example_of_camel_case"
    end
  end

  context "#dash_case" do
    it "converts camel case into dash case" do
      expect(dash_case("ThisIsAnExampleOfCamelCase")).to eq "this-is-an-example-of-camel-case"
    end

    it "converts snake case into dash case" do
      expect(dash_case("this_is_an_example_of_camel_case")).to eq "this-is-an-example-of-camel-case"
    end
  end

  context "#no_case" do
    it "converts - or _ into nothing, and downcases" do
      expect(no_case("This-is_A-String")).to eq "thisisastring"
    end
  end

  context "#method_name" do
    it "converts a string into camel case and downcases the first letter" do
      expect(method_name("user_device")).to eq "userDevice"
    end
  end
end

