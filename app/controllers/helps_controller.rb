class HelpsController < ApplicationController
  before_action :set_help, only: [:show, :edit, :update, :destroy]

  def index
    @available_helps = Help.available
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
    @help.helper = current_user

    if(need_id = params[:help][:need_id])
      need = Need.find(need_id)
      @help.need = need
    end

    if @help.save
      redirect_to :back, notice: 'Thanks for your help, Hero!'
    else
      render action: 'new'
    end
  end

  def update
    if @help.update(help_params)
      redirect_to @help, notice: 'Help was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @help.destroy

    redirect_to helps_url
  end

  def accept
    help = Help.find(params[:help_id])
    help.accept!

    redirect_to nonprofit_path(help.need.nonprofit), notice: 'Great, the Hero will be notified to make the help effective'
  end

  def reject
    help = Help.find(params[:help_id])
    nonprofit = help.need.nonprofit
    help.reject!

    redirect_to nonprofit_path(nonprofit), notice: ':('
  end

  private
    def set_help
      @help = Help.find(params[:id])
    end

    def help_params
      params.require(:help).permit(:description)
    end
end
