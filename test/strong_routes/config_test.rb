require "test_helper"

describe StrongRoutes::Config do
  subject { StrongRoutes::Config.new }

  describe "API" do
    it "supports :allowed_routes" do
      _(subject.respond_to?(:allowed_routes)).must_equal true
    end

    it "supports :content" do
      _(subject.respond_to?(:content)).must_equal true
    end

    it "supports :content_type" do
      _(subject.respond_to?(:content_type)).must_equal true
    end

    it "supports :enabled" do
      _(subject.respond_to?(:enabled)).must_equal true
    end

    it "supports :insert_after" do
      _(subject.respond_to?(:insert_after)).must_equal true
    end

    it "supports :insert_after?" do
      _(subject.respond_to?(:insert_after?)).must_equal true
    end

    it "supports :insert_before" do
      _(subject.respond_to?(:insert_before)).must_equal true
    end

    it "supports :insert_before?" do
      _(subject.respond_to?(:insert_before?)).must_equal true
    end

    it "supports :status=" do
      _(subject.respond_to?(:status=)).must_equal true
    end
  end

  describe "#allowed_routes=" do
    it "maps allowed routes to matchers" do
      subject.allowed_routes = ["/users"]
      _(subject.route_matchers).must_equal [StrongRoutes::Matcher.new("/users")]
    end
  end

  describe "#enabled?" do
    it "is true" do
      _(subject).must_be :enabled
    end
  end

  describe "#headers" do
    it "is an empty hash" do
      _(subject.headers).must_equal({})
    end

    context "with content_type: 'text/plain'" do
      it "is an empty hash" do
        subject.content_type = "text/plain"
        _(subject.headers).must_equal({})
      end
    end

    context "with content: 'Nope' and content_type: nil" do
      it "contains Content-Type headers" do
        subject.content = "Nope"
        _(subject.headers).must_equal({"content-type" => "text/plain"})
      end
    end

    context "with content: 'Nope' and content_type: 'text/plain'" do
      it "contains Content-Type headers" do
        subject.content = "Nope"
        subject.content_type = "text/plain"
        _(subject.headers).must_equal({"content-type" => "text/plain"})
      end
    end
  end

  describe "#status" do
    it "is 404" do
      _(subject.status).must_equal 404
    end
  end
end
