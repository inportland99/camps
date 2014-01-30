require "spec_helper"

describe CouponCodesController do
  describe "routing" do

    it "routes to #index" do
      get("/coupon_codes").should route_to("coupon_codes#index")
    end

    it "routes to #new" do
      get("/coupon_codes/new").should route_to("coupon_codes#new")
    end

    it "routes to #show" do
      get("/coupon_codes/1").should route_to("coupon_codes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/coupon_codes/1/edit").should route_to("coupon_codes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/coupon_codes").should route_to("coupon_codes#create")
    end

    it "routes to #update" do
      put("/coupon_codes/1").should route_to("coupon_codes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/coupon_codes/1").should route_to("coupon_codes#destroy", :id => "1")
    end

  end
end
