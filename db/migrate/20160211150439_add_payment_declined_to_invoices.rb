class AddPaymentDeclinedToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :payment_declined, :boolean, default: false
  end
end
