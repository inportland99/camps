require "spec_helper"

describe CampInterestsController do
  describe "routing" do

    it "routes to #index" do
      get("/camp_interests").should route_to("camp_interests#index")
    end

    it "routes to #new" do
      get("/camp_interests/new").should route_to("camp_interests#new")
    end

    it "routes to #show" do
      get("/camp_interests/1").should route_to("camp_interests#show", :id => "1")
    end

    it "routes to #edit" do
      get("/camp_interests/1/edit").should route_to("camp_interests#edit", :id => "1")
    end

    it "routes to #create" do
      post("/camp_interests").should route_to("camp_interests#create")
    end

    it "routes to #update" do
      put("/camp_interests/1").should route_to("camp_interests#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/camp_interests/1").should route_to("camp_interests#destroy", :id => "1")
    end

  end
end
