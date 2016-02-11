class AddChargeDescriptionToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :charge_description, :string
  end
end
