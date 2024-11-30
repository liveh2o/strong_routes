require "test_helper"

describe StrongRoutes do
  subject { StrongRoutes }

  describe ".config" do
    it "initializes a new config object" do
      _(subject.config).must_be :instance_of?, StrongRoutes::Config
    end
  end
end
