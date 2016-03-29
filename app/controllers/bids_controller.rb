class BidsController < ApplicationController
  before_action :authenticate_user

  def create
    @auction = Auction.find(params[:auction_id])
    @bid = Bid.new(bid_params)
    @bid.user = current_user
    @bid.auction = @auction
    if @bid.save
      CheckIfReservePriceIsMetJob.perform_now(@bid)
      redirect_to @bid.auction, flash: {success: "Bidded"}
    else
      redirect_to @bid.auction, flash: {warning: "bid must be higher than current bid"}
    end
  end


  private

  def bid_params
    params.require(:bid).permit(:amount, :auction_id)
  end

end
