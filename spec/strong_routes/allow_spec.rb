require 'spec_helper'

def middleware
  ::StrongRoutes::Allow
end

describe ::StrongRoutes::Allow do
  let(:app) { middleware.new(stack) }
  let(:stack) { lambda { |env| [ 200, { "Content-Type" => "text/plain" }, [ "Good" ] ] } }

  context "without allowed routes set" do
    it "does not allow access to /users" do
      get "/users"
      last_response.wont_be :ok?
    end

    it "does not allow access to /users/profile" do
      get "/users/profile"
      last_response.wont_be :ok?
    end

    it "does not allow access to /users/profile/anything" do
      get "/users/profile/anything"
      last_response.wont_be :ok?
    end

    it "does not allow access to /users/profile/anything?stuff=12" do
      get "/users/profile/anything?stuff=12"
      last_response.wont_be :ok?
    end

    it "does not allow empty path" do
      get "/"
      last_response.wont_be :ok?
    end
  end

  context "with allowed routes set" do
    let(:users_path) { [ /\/users/i ] }

    before do
      ::StrongRoutes.config.allowed_routes = users_path
    end

    after do
      ::StrongRoutes.config.allowed_routes = nil
    end

    it "allows access to /users" do
      get "/users"
      last_response.must_be :ok?
    end

    it "does not allow access to /user" do
      get "/user"
      last_response.wont_be :ok?
    end

    it "allows access to /users/profile/anything?stuff=12" do
      get "/users/profile/anything?stuff=12"
      last_response.must_be :ok?
    end
  end

  context "enabled option is false" do
    let(:app) { middleware.new(stack, { :enabled => false }) }

    it "passes request to the next app" do
      get "/users/profile/anything?stuff=12"
      last_response.must_be :ok?
    end
  end

  context "allowed_routes passed to initializer" do
    let(:app) { middleware.new(stack, { :allowed_routes => [ :users ] }) }

    it "allows /users with :users" do
      get "/users"
      last_response.must_be :ok?
    end

    it "does not allow /user :user" do
      get "/user"
      last_response.wont_be :ok?
    end

    it "allows access to /users/profile/anything?stuff=12 with :users" do
      get "/users/profile/anything?stuff=12"
      last_response.must_be :ok?
    end
  end
end
