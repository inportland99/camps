class RegistrationsController < ApplicationController
  # GET /registrations
  # GET /registrations.json
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
  end

  # POST /registrations
  # POST /registrations.json
  def create
    @registration = Registration.new(registration_params)

    if @registration.camp_offerings == []
        redirect_to :back, flash: { error: "You have not selected any camps." }
    else
      respond_to do |format|
        if @registration.save_with_payment
          format.html { redirect_to @registration, notice: 'Registration was successfully created.' }
          format.json { render json: @registration, status: :created, location: @registration }
        else
          format.html { render action: "new" }
          format.json { render json: @registration.errors, status: :unprocessable_entity }
        end
      end
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

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def registration_params
      params.require(:registration).permit(:emergency_contact_name, :emergency_contact_phone, :parent_address_1, :parent_address_2, :parent_email, :parent_first_name, :parent_last_name, :parent_phone, :student_allergies, :student_first_name, :student_grade, :student_last_name, {camp_offering_ids: []}, :stripe_card_token)
    end
end
