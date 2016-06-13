class RegistrationsController < ApplicationController
  # GET /registrations
  # GET /registrations.json
  force_ssl if: :ssl_configured?
  before_filter :authenticate_user!, :except => [:new, :create, :total_discounts, :confirmation, :outstanding_payments]

  def index
    @registrations = Registration.where(year: 2).order('created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @registrations }
    end
  end

  # GET /registrations/1
  # GET /registrations/1.json
  def show
    @registration = Registration.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @registration }
      format.pdf do
        render :pdf => "invoice"
      end
    end
  end

  # GET /registrations/new
  # GET /registrations/new.json
  def new
    @registration = Registration.new
    @camp_offerings = CampOffering.where(year: 2).order("week asc, location_id asc")
    @powell_camps = CampOffering.where("location_id=? AND year=?", 1, 2)
    @new_albany_camps = CampOffering.where("location_id=? AND year=?", 2, 2)
    @extended_care = Camp.find 20

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @registration }
    end
  end

  # GET /registrations/1/edit
  def edit
    @registration = Registration.find(params[:id])
    @locations = Location.order(:id)
  end

  # POST /registrations
  # POST /registrations.json
  def create
    @registration = Registration.new(registration_params)

    if current_user && (current_user.role?('super_admin') || current_user.role?('admin')) && params[:process_without_payment] == "yes"
      respond_to do |format|
        if @registration.save_without_payment
          # send confirmation email
          PonyExpress.registration_confirmation(@registration).deliver

          #add to infusionsoft if not already added and tag as purchasing a summer camp.
          @registration.infusionsoft_actions

          #process shareable code actions
          # @registration.set_up_code_share

          format.html { redirect_to @registration, notice: 'Registration created' }
          format.json { render json: @registration, status: :created, location: @registration }
        else
          format.html { render action: "new" }
          format.json { render json: @registration.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        if @registration.save_with_payment
          PonyExpress.registration_confirmation(@registration).deliver
          #add to infusionsoft if not already added and tag as purchasing a summer camp.
          @registration.infusionsoft_actions

          #process shareable code actions
          # @registration.set_up_code_share

          format.html { redirect_to confirmation_registrations_path(:id => @registration.id, :token => @registration.stripe_charge_token) }
          format.json { render json: @registration, status: :created, location: @registration }
        else
          format.html { render action: "new" }
          format.json { render json: @registration.errors, status: :unprocessable_entity }
        end
      end
    end

    rescue Stripe::CardError => e
      flash.now[:error] = e.message + " Please enter a valid credit card and reselect your camps."
      render action: :new, location: @registration.location

    rescue Stripe::InvalidRequestError => e
      flash.now[:error] = e.message + " Please enter a valid credit card and reselect your camps."
      render action: :new, location: @registration.location
  end

  def confirmation
    @registration = Registration.find(params[:id])

    unless params[:token] == @registration.stripe_charge_token
      redirect_to { redirect_to root_url, notice: 'No need to go there :)' }
    end
  end

  def email_confirmation
    if params[:id]
      @registration = Registration.find(params[:id])

      if PonyExpress.registration_confirmation(@registration).deliver
        redirect_to root_url, notice: "Confirmation Sent"
      end
    else
      redirect_to root_url
    end
  end

  # PATCH/PUT /registrations/1
  # PATCH/PUT /registrations/1.json
  def update
    @registration = Registration.find(params[:id])

    respond_to do |format|
      if @registration.update_attributes(registration_params)
        format.html { redirect_to @registration, notice: 'Registration was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registrations/1
  # DELETE /registrations/1.json
  def destroy
    @registration = Registration.find(params[:id])
    @registration.destroy

    respond_to do |format|
      format.html { redirect_to registrations_url }
      format.json { head :no_content }
    end
  end

  def total_discounts
    if params[:token] == 'OGGfBcPNINciwXYJRx4ccNW0'
      total_discounts = Registration.total_discounts_by_year(1).round(2)

      render plain: "#{total_discounts}"

    else
      render nothing: true
    end
  end

  def outstanding_payments
    if params[:token] == 'eToGH4RlfHPz2C96yIjRenxS'
      outstanding_invoice_total = (Invoice.where(paid: false).sum(:amount).to_f/100).round(2)
      registrations = Registration.where(year: CampOffering::CURRENT_YEAR)

      total_camps_count = 0
      half_day_count = 0
      registrations.each do |reg|
        camp_offerings = reg.camp_offerings
        camp_offerings = camp_offerings.reject{ |co| co.extended_care? }
        half_day_camp_offerings = camp_offerings.reject{ |co| co.time == "All Day" }
        total_camps_count += reg.camp_offerings.reject{ |co| co.extended_care? }.count
        half_day_count += half_day_camp_offerings.count
      end
      full_day_count = total_camps_count - half_day_count

      render plain: "Total # of Registrations: #{registrations.count}\n Total Rev: $#{registrations.sum(:total)/100}\nAvg. Spend per Registration: $#{(registrations.average(:total).to_f/100).round(2)}\n# of Registrations on Payment Plan: #{Registration.where(year: CampOffering::CURRENT_YEAR, payment_plan: true).count}\nOutstanding Payment Plan Payments: $#{outstanding_invoice_total}\nCurrent # of Declined Invoices: #{Invoice.where(payment_declined: true).count}\n Total Camps Purchased: #{total_camps_count}\nFull Day Camps Purchased: #{full_day_count}\n Half Day Camps Purchased: #{half_day_count}"

    else
      render nothing: true
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def registration_params
      params.require(:registration).permit(:id,
                                           :emergency_contact_name,
                                           :emergency_contact_phone,
                                           :parent_address_1,
                                           :parent_address_2,
                                           :parent_city,
                                           :parent_state,
                                           :parent_zip,
                                           :location_id,
                                           :parent_email,
                                           :parent_first_name,
                                           :parent_last_name,
                                           :parent_phone,
                                           :student_allergies,
                                           :student_first_name,
                                           :student_grade,
                                           :student_last_name,
                                           :total,
                                           :coupon_code,
                                           :year,
                                           {camp_offering_ids: []},
                                           :stripe_card_token,
                                           :process_without_payment,
                                           :camp_campaign,
                                           :payment_plan,
                                           :newsletter)
    end

    def ssl_configured?
      !Rails.env.development?
    end
end
