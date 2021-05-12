class RegistrationsController < ApplicationController
  # GET /registrations
  # GET /registrations.json
  force_ssl if: :ssl_configured?
  before_filter :authenticate_user!, :except => [:new, :create, :total_discounts, :confirmation, :outstanding_payments]

  def index
    @registrations = Registration.where(year: current_year).order('created_at DESC')
    last_year = current_year - 1
    @registrations_last_year = Registration.where(year: last_year).order('created_at DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @registrations }
      format.csv { send_data Registration.all.to_csv }
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
    @extended_care = Camp.find 20
  end

  # POST /registrations
  # POST /registrations.json
  def create
    @registration = Registration.new(registration_params)
    @extended_care = Camp.find 20

    if current_user && (current_user.role?('super_admin') || current_user.role?('admin')) && params[:process_without_payment] == "yes"
      respond_to do |format|
        if @registration.save_without_payment

          # sync to active campaign
          # @registration.active_campaign_actions

          # sync to infusionsoft
          @registration.infusionsoft_actions

          # send notification to slack
          @registration.send_slack_notification

          # process shareable code actions
          # @registration.set_up_code_share

          # send confirmation email
          notice = nil
          begin
            PonyExpress.registration_confirmation(@registration).deliver
          rescue Net::SMTPUnknownError => e
            notice = 'There was an error sending your confirmation email. You should receive it within 24 hours.'\
                     'If you do not receive the confirmation, please email info@mathpluscademy.com and we will resend it.'
          end

          # send reminder if camp scheduled between friday before and monday of camp
          send_reminder = false
          @registration.camp_offerings.each do |offering|
            if CampOffering::OFFERING_WEEKS[offering.week][:start].between?(Date.today, Date.today + 3.days)
              send_reminder = true
            end
          end
          if send_reminder
            PonyExpress.camp_reminder(@registration).deliver
          end

          format.html { redirect_to @registration, notice: notice || 'Registration created' }
          format.json { render json: @registration, status: :created, location: @registration }
        else
          format.html { render action: "new" }
          format.json { render json: @registration.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        if @registration.save_with_payment

          # send notification to slack
          @registration.send_slack_notification

          # send email confirmation
          PonyExpress.registration_confirmation(@registration).deliver

          # send reminder if camp scheduled between friday before and monday of camp
          send_reminder = false
          @registration.camp_offerings.each do |offering|
            if CampOffering::OFFERING_WEEKS[offering.week][:start].between?(Date.today, Date.today + 3.days)
              send_reminder = true
            end
          end
          if send_reminder
            PonyExpress.camp_reminder(@registration).deliver
          end

          # sync to active campaign
          # @registration.active_campaign_actions

          # sync to infusionsoft
          @registration.infusionsoft_actions

          format.html { redirect_to confirmation_registrations_path(:id => @registration.id, :token => @registration.stripe_charge_token) }
          format.json { render json: @registration, status: :created, location: @registration }
        else
          format.html { render action: "new" }
          format.json { render json: @registration.errors, status: :unprocessable_entity }
        end
      end
    end

    rescue Stripe::CardError => e
      redirect_to :back, :flash => { :error => e.message + " Please enter a valid credit card and reselect your camps. If you keep experiencing this issue please call 614-792-6284 or email info@mathplusacademy.com." }

    rescue Stripe::InvalidRequestError => e
      redirect_to :back, :flash => { :error => e.message + " Please enter a valid credit card and reselect your camps." }
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

  def email_reminder
    if params[:id]
      @registration = Registration.find(params[:id])
      send_reminder = false
      @registration.camp_offerings.each do |offering|
        if CampOffering::OFFERING_WEEKS[offering.week][:start].between?(Date.today, Date.today + 7.days)
          send_reminder = true
        end
      end
      if send_reminder
        if PonyExpress.camp_reminder(@registration).deliver
          redirect_to @registration, notice: "Reminder Sent"
        end
      else
        redirect_to @registration, alert: "No Camps Next Week - Reminder not sent"
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
      total_discounts = Registration.total_discounts_by_year(CampOffering::CURRENT_YEAR).round(2)

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

    def current_year
      (params[:current_year] || CampOffering::CURRENT_YEAR).to_i
    end
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
                                           :newsletter,
                                           :referred_by)
    end

    def ssl_configured?
      !Rails.env.development?
    end
end
