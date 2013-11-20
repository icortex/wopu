class NeedsController < ApplicationController
  before_action :set_need, only: [:show, :edit, :update, :destroy]

  def index
    @nonprofit = Nonprofit.find(params[:nonprofit_id])
  end

  def show
  end

  def new
    nonprofit = Nonprofit.find(params[:nonprofit_id])
    @need = nonprofit.needs.build
  end

  def edit
  end

  def create
    @need = Need.new(need_params)
    @need.nonprofit = Nonprofit.find(params[:nonprofit_id])

    if @need.save
      redirect_to @need.nonprofit, notice: 'Need was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @need.update(need_params)
      redirect_to nonprofit_need_path(@need.nonprofit, @need), notice: 'Need was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    nonprofit = @need.nonprofit
    @need.destroy

    redirect_to nonprofit_needs_path(nonprofit)
  end

  def mark_solved
    need = Need.find(params[:need_id])
    need.solve!

    redirect_to nonprofit_path(need.nonprofit), notice: 'Great, your need was solved!'
  end

  private
    def set_need
      @need = Need.find(params[:id])
    end

    def need_params
      params.require(:need).permit(:title, :purpose, :description, :beneficiary, :deadline)
    end
end
