require "spec_helper"

describe WeeklyProgramsController do
  describe "routing" do

    it "routes to #index" do
      get("/weekly_programs").should route_to("weekly_programs#index")
    end

    it "routes to #new" do
      get("/weekly_programs/new").should route_to("weekly_programs#new")
    end

    it "routes to #show" do
      get("/weekly_programs/1").should route_to("weekly_programs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/weekly_programs/1/edit").should route_to("weekly_programs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/weekly_programs").should route_to("weekly_programs#create")
    end

    it "routes to #update" do
      put("/weekly_programs/1").should route_to("weekly_programs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/weekly_programs/1").should route_to("weekly_programs#destroy", :id => "1")
    end

  end
end
