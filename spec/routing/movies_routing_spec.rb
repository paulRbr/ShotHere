require "spec_helper"

describe MoviesController do
  describe "routing", type: :routing do

    it "routes to #index" do
      expect(get: "/movies").to route_to("movies#index")
    end

    it "routes to #new" do
      expect(get: "/movies/new").to route_to("movies#new")
    end

    it "routes to #show" do
      expect(get: "/movies/1").to route_to("movies#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get: "/movies/1/edit").to route_to("movies#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post: "/movies").to route_to("movies#create")
    end

    it "routes to #update" do
      expect(put: "/movies/1").to route_to("movies#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete: "/movies/1").to route_to("movies#destroy", :id => "1")
    end

  end
end
