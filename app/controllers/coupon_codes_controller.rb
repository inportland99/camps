class CouponCodesController < ApplicationController
  # GET /coupon_codes
  # GET /coupon_codes.json

  before_action :authenticate_user!, except: :code_lookup

  def index
    @coupon_codes = CouponCode.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @coupon_codes }
    end
  end

  # GET /coupon_codes/1
  # GET /coupon_codes/1.json
  def show
    @coupon_code = CouponCode.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @coupon_code }
    end
  end

  # GET /coupon_codes/new
  # GET /coupon_codes/new.json
  def new
    @coupon_code = CouponCode.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @coupon_code }
    end
  end

  # GET /coupon_codes/1/edit
  def edit
    @coupon_code = CouponCode.find(params[:id])
  end

  # POST /coupon_codes
  # POST /coupon_codes.json
  def create
    @coupon_code = CouponCode.new(coupon_code_params)

    respond_to do |format|
      if @coupon_code.save
        format.html { redirect_to @coupon_code, notice: 'Coupon code was successfully created.' }
        format.json { render json: @coupon_code, status: :created, location: @coupon_code }
      else
        format.html { render action: "new" }
        format.json { render json: @coupon_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coupon_codes/1
  # PATCH/PUT /coupon_codes/1.json
  def update
    @coupon_code = CouponCode.find(params[:id])

    respond_to do |format|
      if @coupon_code.update_attributes(coupon_code_params)
        format.html { redirect_to @coupon_code, notice: 'Coupon code was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @coupon_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coupon_codes/1
  # DELETE /coupon_codes/1.json
  def destroy
    @coupon_code = CouponCode.find(params[:id])
    @coupon_code.destroy

    respond_to do |format|
      format.html { redirect_to coupon_codes_url }
      format.json { head :no_content }
    end
  end

  def code_lookup
    @code = CouponCode.find_by_name!(params[:code_name].upcase)

    respond_to do |format|
      format.json { render json: @code }
    end
  end

  def facebook_share
    @registration = Registration.find(params[:registration_id])

    unless params[:token] == @registration.stripe_charge_token
      redirect_to { redirect_to root_url, notice: 'No need to go there :)' }
    else
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def coupon_code_params
      params.require(:coupon_code).permit(:amount, :description, :name, :coupon_type, :active, :image, :image_uid, :half_day_discount, :full_day_discount)
    end
end
