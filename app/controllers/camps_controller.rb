class CampsController < ApplicationController

  before_filter :authenticate_user!, except: [:show, :descriptions]

  def descriptions
    @camps = Camp.order(title: :asc).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @camps }
    end
  end

  # GET /camps
  # GET /camps.json
  def index
    @camps = Camp.order(:id).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @camps }
      format.csv { send_data @camps.to_csv }
    end
  end

  # GET /camps/1
  # GET /camps/1.json
  def show
    @camp = Camp.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @camp }
    end
  end

  # GET /camps/new
  # GET /camps/new.json
  def new
    @camp = Camp.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @camp }
    end
  end

  # GET /camps/1/edit
  def edit
    @camp = Camp.find(params[:id])
  end

  # POST /camps
  # POST /camps.json
  def create
    @camp = Camp.new(camp_params)

    respond_to do |format|
      if @camp.save
        format.html { redirect_to @camp, notice: 'Camp was successfully created.' }
        format.json { render json: @camp, status: :created, location: @camp }
      else
        format.html { render action: "new" }
        format.json { render json: @camp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /camps/1
  # PATCH/PUT /camps/1.json
  def update
    @camp = Camp.find(params[:id])

    respond_to do |format|
      if @camp.update_attributes(camp_params)
        format.html { redirect_to @camp, notice: 'Camp was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @camp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /camps/1
  # DELETE /camps/1.json
  def destroy
    @camp = Camp.find(params[:id])
    @camp.destroy

    respond_to do |format|
      format.html { redirect_to camps_url }
      format.json { head :no_content }
    end
  end

  def import
    Camp.import(params[:file])
    redirect_to camps_path, notice: "Camps imported."
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def camp_params
      params.require(:camp).permit(:age, :capacity, :description, :price, :title, :show_description, :girls_only, :video_url, :online, :active)
    end
end
