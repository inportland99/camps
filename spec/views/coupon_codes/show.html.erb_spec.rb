require 'spec_helper'

describe "coupon_codes/show" do
  before(:each) do
    @coupon_code = assign(:coupon_code, stub_model(CouponCode,
      :name => "Name",
      :type => "Type",
      :description => "MyText",
      :amount => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Type/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
  end
end
