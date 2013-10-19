class HelpsController < ApplicationController
  before_action :set_help, only: [:show, :edit, :update, :destroy]

  def index
    @helps = Help.all
  end

  def show
  end

  def new
    @help = Help.new
  end

  def edit
  end

  def create
    @help = Help.new(help_params)

    respond_to do |format|
      if @help.save
        format.html { redirect_to @help, notice: 'Help was successfully created.' }
        format.json { render action: 'show', status: :created, location: @help }
      else
        format.html { render action: 'new' }
        format.json { render json: @help.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @help.update(help_params)
        format.html { redirect_to @help, notice: 'Help was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @help.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @help.destroy
    respond_to do |format|
      format.html { redirect_to helps_url }
      format.json { head :no_content }
    end
  end

  private
    def set_help
      @help = Help.find(params[:id])
    end

    def help_params
      params.require(:help).permit(:description)
    end
end
