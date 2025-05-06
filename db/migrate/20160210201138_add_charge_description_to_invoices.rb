class AddChargeDescriptionToInvoices < ActiveRecord::Migration[6.0]
  def change
    add_column :invoices, :charge_description, :string
  end
end
