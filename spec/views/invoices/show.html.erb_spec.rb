require 'rails_helper'

RSpec.describe "invoices/show", type: :view do
  before(:each) do
    @invoice = assign(:invoice, Invoice.create!(
      :registration_id => 1,
      :paid => false,
      :stripe_charge_id => "Stripe Charge",
      :stripe_customer_id => "Stripe Customer",
      :amount => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/Stripe Charge/)
    expect(rendered).to match(/Stripe Customer/)
    expect(rendered).to match(/2/)
  end
end
