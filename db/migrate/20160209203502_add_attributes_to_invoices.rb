class AddAttributesToInvoices < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :attempts, :integer, default: 0
    add_column :invoices, :payment_declined, :boolean, default: false
  end
end
