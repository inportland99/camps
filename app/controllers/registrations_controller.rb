class RegistrationsController < ApplicationController
  # GET /registrations
  # GET /registrations.json
  before_filter :authenticate_user!, :except => [:new, :create]

  def index
    @registrations = Registration.all

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
    @camp_offerings = CampOffering.order("week asc, location_id asc")
    @powell_camps = CampOffering.where("location_id=?", 1)
    @new_albany_camps = CampOffering.where("location_id=?", 2)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @registration }
    end
  end

  # GET /registrations/1/edit
  def edit
    @registration = Registration.find(params[:id])
    @camp_offerings = CampOffering.order('location_id ASC')
  end

  # POST /registrations
  # POST /registrations.json
  def create
    @registration = Registration.new(registration_params)

    if current_user && current_user.role?('super_admin') && params[:process_without_payment] == "yes"
      respond_to do |format|
        if @registration.save_without_payment
          PonyExpress.registration_confirmation(@registration).deliver
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
          format.html { redirect_to root_url, notice: 'Registration created!
            An email has been sent confirming this transaction.' }
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
      flash.now[:error] = e.message + "Please enter a valid credit card and reselect your camps."
      render action: :new, location: @registration.location
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

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def registration_params
      params.require(:registration).permit(:emergency_contact_name,
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
                                           {camp_offering_ids: []},
                                           :stripe_card_token,
                                           :process_without_payment)
    end
end
