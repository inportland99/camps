require "spec_helper"

describe CampOfferingsController do
  describe "routing" do

    it "routes to #index" do
      get("/camp_offerings").should route_to("camp_offerings#index")
    end

    it "routes to #new" do
      get("/camp_offerings/new").should route_to("camp_offerings#new")
    end

    it "routes to #show" do
      get("/camp_offerings/1").should route_to("camp_offerings#show", :id => "1")
    end

    it "routes to #edit" do
      get("/camp_offerings/1/edit").should route_to("camp_offerings#edit", :id => "1")
    end

    it "routes to #create" do
      post("/camp_offerings").should route_to("camp_offerings#create")
    end

    it "routes to #update" do
      put("/camp_offerings/1").should route_to("camp_offerings#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/camp_offerings/1").should route_to("camp_offerings#destroy", :id => "1")
    end

  end
end
