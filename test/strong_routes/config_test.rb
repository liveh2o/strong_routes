require "test_helper"

describe ::StrongRoutes::Config do
  subject { ::StrongRoutes::Config.new }

  describe "API" do
    it "supports :allowed_routes" do
      _(subject.respond_to?(:allowed_routes)).must_equal true
    end

    it "supports :enabled" do
      _(subject.respond_to?(:enabled)).must_equal true
    end

    it "supports :insert_after" do
      _(subject.respond_to?(:insert_after)).must_equal true
    end

    it "supports :insert_before" do
      _(subject.respond_to?(:insert_before)).must_equal true
    end
  end

  describe "#enabled" do
    it "is enabled by default" do
      _(subject).must_be :enabled
    end
  end
end
