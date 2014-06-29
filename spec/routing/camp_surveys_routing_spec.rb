require "spec_helper"

describe CampSurveysController do
  describe "routing" do

    it "routes to #index" do
      get("/camp_surveys").should route_to("camp_surveys#index")
    end

    it "routes to #new" do
      get("/camp_surveys/new").should route_to("camp_surveys#new")
    end

    it "routes to #show" do
      get("/camp_surveys/1").should route_to("camp_surveys#show", :id => "1")
    end

    it "routes to #edit" do
      get("/camp_surveys/1/edit").should route_to("camp_surveys#edit", :id => "1")
    end

    it "routes to #create" do
      post("/camp_surveys").should route_to("camp_surveys#create")
    end

    it "routes to #update" do
      put("/camp_surveys/1").should route_to("camp_surveys#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/camp_surveys/1").should route_to("camp_surveys#destroy", :id => "1")
    end

  end
end
