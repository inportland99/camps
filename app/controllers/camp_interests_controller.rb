class CampInterestsController < ApplicationController
  before_action :set_camp_interest, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user!, :except => [:new, :create]

  def index
    @camp_interests = CampInterest.all
    respond_with(@camp_interests)
  end

  def show
    respond_with(@camp_interest)
  end

  def new
    @camp_interest = CampInterest.new
    respond_with(@camp_interest)
  end

  def edit
  end

  def create
    @camp_interest = CampInterest.new(camp_interest_params)
    respond_to do |format|
      if @camp_interest.save
        format.html { redirect_to root_url, notice: 'We will notify you when registration opens :)' }
        format.json { render json: @camp_interest, status: :created, location: @camp_interest }
      else
        format.html { redirect_to root_url, flash: { error: 'Either your email is bad or you already filled this out.' }  }
        format.json { render json: @camp_interest.errors, status: :unprocessable_entity }
      end
    end

  end

  def update
    @camp_interest.update(camp_interest_params)
    respond_with(@camp_interest)
  end

  def destroy
    @camp_interest.destroy
    respond_with(@camp_interest)
  end

  private
    def set_camp_interest
      @camp_interest = CampInterest.find(params[:id])
    end

    def camp_interest_params
      params.require(:camp_interest).permit(:name, :email, :year, :newsletter)
    end
end
