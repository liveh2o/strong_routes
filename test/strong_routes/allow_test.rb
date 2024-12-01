require "test_helper"

describe StrongRoutes::Allow do
  include Rack::Test::Methods

  let(:app) { StrongRoutes::Allow.new(stack) }
  let(:stack) { lambda { |env| [200, {"Content-Type" => "text/plain"}, ["Good"]] } }

  context "without allowed routes set" do
    before do
      StrongRoutes.config.allowed_routes = []
    end

    it "does not allow access to /users" do
      get "/users"
      _(last_response).wont_be :ok?
    end

    it "does not allow access to /users/profile" do
      get "/users/profile"
      _(last_response).wont_be :ok?
    end

    it "does not allow access to /users/profile/anything" do
      get "/users/profile/anything"
      _(last_response).wont_be :ok?
    end

    it "does not allow access to /users/profile/anything?stuff=12" do
      get "/users/profile/anything?stuff=12"
      _(last_response).wont_be :ok?
    end

    it "does not allow empty path" do
      get "/"
      _(last_response).wont_be :ok?
    end
  end

  context "with allowed routes set" do
    before do
      StrongRoutes.config.allowed_routes = ["/users"]
    end

    it "allows access to /users" do
      get "/users"
      _(last_response).must_be :ok?
    end

    it "allows access to /users?stuff=12" do
      get "/users/?stuff=12"
      _(last_response).must_be :ok?
    end

    it "does not allow access to /user" do
      get "/user"
      _(last_response).wont_be :ok?
    end

    it "allows access to /users/profile/anything?stuff=12" do
      get "/users/profile/anything?stuff=12"
      _(last_response).must_be :ok?
    end
  end

  context "when enabled option is false" do
    it "passes request to the next app" do
      StrongRoutes.config.stub :enabled?, false do
        get "/users/profile/anything?stuff=12"
        _(last_response).must_be :ok?
      end
    end
  end
end
