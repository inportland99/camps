class CampOfferingsController < ApplicationController
  # GET /camp_offerings
  # GET /camp_offerings.json
  before_action :authenticate_user!

  def index
    @camp_offerings = CampOffering.order(:id).where(year: CampOffering::CURRENT_YEAR)
    @all_camp_offerings = CampOffering.order(:id).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @camp_offerings }
      format.csv { send_data @all_camp_offerings.to_csv }
    end
  end

  # GET /camp_offerings/1
  # GET /camp_offerings/1.json
  def show
    @camp_offering = CampOffering.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @camp_offering }
    end
  end

  # GET /camp_offerings/new
  # GET /camp_offerings/new.json
  def new
    @camp_offering = CampOffering.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @camp_offering }
    end
  end

  # GET /camp_offerings/1/edit
  def edit
    @camp_offering = CampOffering.find(params[:id])
  end

  # POST /camp_offerings
  # POST /camp_offerings.json
  def create
    @camp_offering = CampOffering.new(camp_offering_params)

    respond_to do |format|
      if @camp_offering.save
        format.html { redirect_to @camp_offering, notice: 'Camp offering was successfully created.' }
        format.json { render json: @camp_offering, status: :created, location: @camp_offering }
      else
        format.html { render action: "new" }
        format.json { render json: @camp_offering.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /camp_offerings/1
  # PATCH/PUT /camp_offerings/1.json
  def update
    @camp_offering = CampOffering.find(params[:id])

    respond_to do |format|
      if @camp_offering.update(camp_offering_params)
        format.html { redirect_to camp_offerings_path, notice: 'Camp offering was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @camp_offering.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /camp_offerings/1
  # DELETE /camp_offerings/1.json
  def destroy
    @camp_offering = CampOffering.find(params[:id])
    @camp_offering.destroy

    respond_to do |format|
      format.html { redirect_to camp_offerings_url }
      format.json { head :no_content }
    end
  end

  def import
    CampOffering.import(params[:file])
    redirect_to camp_offerings_path, notice: "Camp offerings imported."
  end

  def week_at_a_glance
    @location = Location.find(params[:info][:location].to_i)
    @week = params[:info][:week]
    @camp_offerings = CampOffering.where('week = ? AND location_id = ? AND year = ?', @week, @location.id, CampOffering::CURRENT_YEAR)
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def camp_offering_params
      params.require(:camp_offering).permit(:assistant, :camp_id, :end_date, :location_id, :start_date, :teacher, :classroom, :time, :week, :hidden, :year, :extended_care, :zoom_link)
    end
end
