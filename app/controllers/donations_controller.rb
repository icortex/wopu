class DonationsController < ApplicationController
  before_action :set_donation, only: [:show, :edit, :update, :destroy]

  def index
    @available_donations = Donation.available
  end

  def show
  end

  def new
    @donation = Donation.new
  end

  def edit
  end

  def create
    @donation = Donation.new(donation_params)
    @donation.helper = current_user

    if(need_id = params[:donation][:need_id])
      need = Need.find(need_id)
      @donation.need = need
    end

    if @donation.save
      redirect_to :back, notice: 'Thanks for your donation, Hero!'
    else
      render action: 'new'
    end
  end

  def update
    if @donation.update(donation_params)
      redirect_to @donation, notice: 'donation was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @donation.destroy

    redirect_to donations_url
  end

  def accept
    donation = Donation.find(params[:donation_id])
    donation.accept!

    redirect_to nonprofit_path(donation.need.nonprofit), notice: 'Great, the Hero will be notified to make the donation effective'
  end

  def reject
    donation = Donation.find(params[:donation_id])
    nonprofit = donation.need.nonprofit
    donation.reject!

    redirect_to nonprofit_path(nonprofit), notice: ':('
  end

  private
    def set_donation
      @donation = Donation.find(params[:id])
    end

    def donation_params
      params.require(:donation).permit(:description)
    end
end
