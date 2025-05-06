namespace :charge do
  desc "Send weekly registration report."
  task invoices: :environment do
    charge_invoices
  end
end

def charge_invoices
  date = Date.today
  invoices_due = Invoice.where("due_date = ? AND paid = ?", date, false)
  success_count = 0
  decline_count = 0

  if invoices_due
    invoices_due.each do |invoice|
      registration = invoice.registration
      begin
        charge = Stripe::Charge.create(
                                        amount: invoice.amount,
                                        currency: "usd",
                                        customer: invoice.stripe_customer_id,
                                        description: "2016 Summer Camp Registration id #{registration.id}. Payment #{invoice.payment_order} of 3"
                                      )
        if charge
          invoice.update paid: true, payment_date: date
          success_count += 1
        end
      rescue Stripe::CardError => e
        invoice.update paid: false, payment_declined:true, charge_description: e.to_s
        decline_count += 1
      end
    end
  else
    puts "No invoices due."
  end

  puts "#{success_count} - Charges succeeded"
  puts "#{decline_count} - Charges declined"
end
