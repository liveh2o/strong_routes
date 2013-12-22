require 'spec_helper'

require 'action_dispatch'
require 'strong_routes/rails/route_mapper'

describe ::StrongRoutes::Rails::RouteMapper do
  let(:paths) { [ 'users', 'posts', 'user_posts', 'bar', 'trading-post' ] }
  let(:route_set) {
    route_set = ActionDispatch::Routing::RouteSet.new
    route_set.draw do
      resources :users, :only => :index  do
        resources :posts
      end

      resources :posts, :only => :show
      resources :user_posts, :only => :show

      get 'bar/sandwich', :to => 'users#index'
      get 'trading-post', :to => 'posts#show'
    end
    route_set
  }

  describe ".map" do
    it "maps routes to path strings" do
      ::StrongRoutes::Rails::RouteMapper.map(route_set).must_equal paths
    end
  end

  describe "#map" do
    subject { ::StrongRoutes::Rails::RouteMapper.new(route_set) }

    it "maps routes to path strings" do
      subject.map.must_equal paths
    end
  end
end
