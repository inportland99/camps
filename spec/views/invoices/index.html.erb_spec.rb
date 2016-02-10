require 'rails_helper'

RSpec.describe "invoices/index", type: :view do
  before(:each) do
    assign(:invoices, [
      Invoice.create!(
        :registration_id => 1,
        :paid => false,
        :stripe_charge_id => "Stripe Charge",
        :stripe_customer_id => "Stripe Customer",
        :amount => 2
      ),
      Invoice.create!(
        :registration_id => 1,
        :paid => false,
        :stripe_charge_id => "Stripe Charge",
        :stripe_customer_id => "Stripe Customer",
        :amount => 2
      )
    ])
  end

  it "renders a list of invoices" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Stripe Charge".to_s, :count => 2
    assert_select "tr>td", :text => "Stripe Customer".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
