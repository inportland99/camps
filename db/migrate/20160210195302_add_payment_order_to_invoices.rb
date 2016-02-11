class AddPaymentOrderToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :payment_order, :integer
  end
end
