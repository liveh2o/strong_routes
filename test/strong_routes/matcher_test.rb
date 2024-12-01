require "test_helper"

describe StrongRoutes::Matcher do
  describe "initialize" do
    context "when given a regex" do
      let(:matcher) { /foo/ }

      subject { StrongRoutes::Matcher.new(matcher) }

      it "uses the regex as the matcher" do
        _(subject).must_equal matcher
      end
    end

    context "when given a string" do
      let(:matcher) { /\A\/foo/i }

      subject { StrongRoutes::Matcher.new("/foo") }

      it "creates a new matcher" do
        _(subject).must_equal matcher
      end
    end

    context "when given a string with dynamic segments" do
      let(:matcher) { /\A\/.*\/foo\/.*\/bar/i }

      subject { StrongRoutes::Matcher.new("/:id/foo/:foo_id/bar") }

      it "creates a new matcher" do
        _(subject).must_equal matcher
      end
    end
  end
end
