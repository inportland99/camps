class AddPaymentOrderToInvoices < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :payment_order, :integer
  end
end
