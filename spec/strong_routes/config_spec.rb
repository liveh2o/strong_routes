require "spec_helper"

describe ::StrongRoutes::Config do
  subject { ::StrongRoutes::Config.new }

  describe "API" do
    it "supports :allowed_routes" do
      subject.respond_to?(:allowed_routes).must_equal true
    end

    it "supports :enabled" do
      subject.respond_to?(:enabled).must_equal true
    end

    it "supports :insert_after" do
      subject.respond_to?(:insert_after).must_equal true
    end

    it "supports :insert_before" do
      subject.respond_to?(:insert_before).must_equal true
    end
  end

  describe "#enabled" do
    it "is enabled by default" do
      subject.must_be :enabled
    end
  end
end
