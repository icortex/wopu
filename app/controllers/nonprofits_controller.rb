class NonprofitsController < ApplicationController
  before_action :set_nonprofit, only: [:show, :edit, :update, :destroy]

  def index
    @my_nonprofits = current_user.try(:nonprofits) || []
    if @my_nonprofits.any? and params[:my_q]
      @my_nonprofits = @my_nonprofits.search(params[:my_q])
    end

    @others_nonprofits = Nonprofit.others(current_user) || []
    if @others_nonprofits.any? and params[:others_q]
      @others_nonprofits = @others_nonprofits.search(params[:others_q])
    end

  end

  def show
  end

  def new
    @nonprofit = Nonprofit.new
    @nonprofit.build_contact_info
    @nonprofit.build_user
  end

  def edit
  end

  def create
    @nonprofit = Nonprofit.new(nonprofit_params)
    @nonprofit.user = current_user if current_user

    if @nonprofit.save
      redirect_to @nonprofit, notice: 'Nonprofit was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @nonprofit.update(nonprofit_params)
      redirect_to @nonprofit, notice: 'Nonprofit was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @nonprofit.destroy

    redirect_to nonprofits_url
  end

  private
    def set_nonprofit
      @nonprofit = Nonprofit.find(params[:id])
    end

    def nonprofit_params
      #params.require(:nonprofit).permit(:name, :logo, :mission, :population,
       #:start_date, :category_id, :available_tag_ids, contact_info_attributes: [:email, :phone, :address,
       #:representative], user_attributes: [:email, :password ])
      params.require(:nonprofit).permit!
    end
end
