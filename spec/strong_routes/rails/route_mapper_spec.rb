require "spec_helper"

require "action_dispatch"
require "strong_routes/rails/route_mapper"

describe ::StrongRoutes::Rails::RouteMapper do
  let(:paths) {
    [
      "/",
      "/bar/sandwich",
      "/comments/:id",
      "/comments/:id/edit",
      "/posts/:id",
      "/posts/:id/edit",
      "/posts/:post_id/comments",
      "/posts/:post_id/comments/new",
      "/trading-post",
      "/user_posts/:id",
      "/users",
      "/users/:user_id/posts",
      "/users/:user_id/posts/new"
    ]
  }
  let(:route_set) {
    route_set = ActionDispatch::Routing::RouteSet.new
    route_set.draw do
      resources :users, only: :index do
        resources :posts, shallow: true do
          resources :comments, shallow: true
        end
      end

      resources :user_posts, only: :show

      get "bar/sandwich", to: "users#index"
      get "trading-post", to: "posts#show"

      root to: "posts#index"
    end
    route_set
  }

  describe ".map" do
    it "maps routes to path strings" do
      ::StrongRoutes::Rails::RouteMapper.map(route_set).sort.must_equal paths.sort
    end
  end

  describe "#map" do
    subject { ::StrongRoutes::Rails::RouteMapper.new(route_set) }

    it "maps routes to path strings" do
      subject.map.sort.must_equal paths.sort
    end
  end
end
