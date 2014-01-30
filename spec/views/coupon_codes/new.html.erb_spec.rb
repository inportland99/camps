require 'spec_helper'

describe "coupon_codes/new" do
  before(:each) do
    assign(:coupon_code, stub_model(CouponCode,
      :name => "MyString",
      :type => "",
      :description => "MyText",
      :amount => 1
    ).as_new_record)
  end

  it "renders new coupon_code form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", coupon_codes_path, "post" do
      assert_select "input#coupon_code_name[name=?]", "coupon_code[name]"
      assert_select "input#coupon_code_type[name=?]", "coupon_code[type]"
      assert_select "textarea#coupon_code_description[name=?]", "coupon_code[description]"
      assert_select "input#coupon_code_amount[name=?]", "coupon_code[amount]"
    end
  end
end
