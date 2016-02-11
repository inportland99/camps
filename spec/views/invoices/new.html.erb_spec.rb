require 'rails_helper'

RSpec.describe "invoices/new", type: :view do
  before(:each) do
    assign(:invoice, Invoice.new(
      :registration_id => 1,
      :paid => false,
      :stripe_charge_id => "MyString",
      :stripe_customer_id => "MyString",
      :amount => 1
    ))
  end

  it "renders new invoice form" do
    render

    assert_select "form[action=?][method=?]", invoices_path, "post" do

      assert_select "input#invoice_registration_id[name=?]", "invoice[registration_id]"

      assert_select "input#invoice_paid[name=?]", "invoice[paid]"

      assert_select "input#invoice_stripe_charge_id[name=?]", "invoice[stripe_charge_id]"

      assert_select "input#invoice_stripe_customer_id[name=?]", "invoice[stripe_customer_id]"

      assert_select "input#invoice_amount[name=?]", "invoice[amount]"
    end
  end
end
