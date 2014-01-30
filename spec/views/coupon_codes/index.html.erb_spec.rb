require 'spec_helper'

describe "coupon_codes/index" do
  before(:each) do
    assign(:coupon_codes, [
      stub_model(CouponCode,
        :name => "Name",
        :type => "Type",
        :description => "MyText",
        :amount => 1
      ),
      stub_model(CouponCode,
        :name => "Name",
        :type => "Type",
        :description => "MyText",
        :amount => 1
      )
    ])
  end

  it "renders a list of coupon_codes" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
