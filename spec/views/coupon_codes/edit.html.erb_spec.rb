require 'spec_helper'

describe "coupon_codes/edit" do
  before(:each) do
    @coupon_code = assign(:coupon_code, stub_model(CouponCode,
      :name => "MyString",
      :type => "",
      :description => "MyText",
      :amount => 1
    ))
  end

  it "renders the edit coupon_code form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", coupon_code_path(@coupon_code), "post" do
      assert_select "input#coupon_code_name[name=?]", "coupon_code[name]"
      assert_select "input#coupon_code_type[name=?]", "coupon_code[type]"
      assert_select "textarea#coupon_code_description[name=?]", "coupon_code[description]"
      assert_select "input#coupon_code_amount[name=?]", "coupon_code[amount]"
    end
  end
end
