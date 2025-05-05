class InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, :except => [:new, :create]

  respond_to :html

  def index
    @invoices = Invoice.order(:id).where("created_at > ?", Date.new(Date.today.year))
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @invoices }
      format.csv { send_data @invoices.to_csv }
    end
  end

  def show
    respond_with(@invoice)
  end

  def new
    @invoice = Invoice.new
    respond_with(@invoice)
  end

  def edit
  end

  def create
    @invoice = Invoice.new(invoice_params)
    @invoice.save
    respond_with(@invoice)
  end

  def update
    @invoice.update(invoice_params)
    respond_with(@invoice)
  end

  def destroy
    @invoice.destroy
    respond_with(@invoice)
  end

  private
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    def invoice_params
      params.require(:invoice).permit(:registration_id, :paid, :payment_date, :stripe_charge_id, :stripe_customer_id, :amount, :due_date, :payment_order, :charge_description, :payment_declined)
    end
end
