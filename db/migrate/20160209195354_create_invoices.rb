class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :registration_id
      t.boolean :paid, default: false
      t.date :payment_date
      t.string :stripe_charge_id
      t.string :stripe_customer_id
      t.integer :amount

      t.timestamps
    end
  end
end
