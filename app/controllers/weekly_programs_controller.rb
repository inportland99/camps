class WeeklyProgramsController < ApplicationController
  before_action :set_weekly_program, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @weekly_programs = WeeklyProgram.all
    respond_with(@weekly_programs)
  end

  def show
    respond_with(@weekly_program)
  end

  def new
    @weekly_program = WeeklyProgram.new
    respond_with(@weekly_program)
  end

  def edit
  end

  def create
    @weekly_program = WeeklyProgram.new(weekly_program_params)
    @weekly_program.save
    respond_with(@weekly_program)
  end

  def update
    @weekly_program.update(weekly_program_params)
    respond_with(@weekly_program)
  end

  def destroy
    @weekly_program.destroy
    respond_with(@weekly_program)
  end

  private
    def set_weekly_program
      @weekly_program = WeeklyProgram.find(params[:id])
    end

    def weekly_program_params
      params.require(:weekly_program).permit(:name)
    end
end
