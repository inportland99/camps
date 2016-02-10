require 'rails_helper'

RSpec.describe "invoices/edit", type: :view do
  before(:each) do
    @invoice = assign(:invoice, Invoice.create!(
      :registration_id => 1,
      :paid => false,
      :stripe_charge_id => "MyString",
      :stripe_customer_id => "MyString",
      :amount => 1
    ))
  end

  it "renders the edit invoice form" do
    render

    assert_select "form[action=?][method=?]", invoice_path(@invoice), "post" do

      assert_select "input#invoice_registration_id[name=?]", "invoice[registration_id]"

      assert_select "input#invoice_paid[name=?]", "invoice[paid]"

      assert_select "input#invoice_stripe_charge_id[name=?]", "invoice[stripe_charge_id]"

      assert_select "input#invoice_stripe_customer_id[name=?]", "invoice[stripe_customer_id]"

      assert_select "input#invoice_amount[name=?]", "invoice[amount]"
    end
  end
end
