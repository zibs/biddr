class BidsController < ApplicationController
  before_action :authenticate_user

  def index
    @bids = current_user.bids.order("created_at DESC")
  end

  def create
    @auction = Auction.find(params[:auction_id])
    @bid = Bid.new(bid_params)
    @bid.user = current_user
    @bid.auction = @auction
    # respond_to do |format|
      if @bid.save
        CheckIfReservePriceIsMetJob.perform_now(@bid)
        redirect_to @bid.auction, flash: {success: "Bidded"}
        # format.json { @bid }
      else
          redirect_to @bid.auction, flash: {warning: "bid must be higher than current bid"} 
        # format.json {"please bid higher than last bid"}
      # end
    end
  end

  private

  def bid_params
    params.require(:bid).permit(:amount, :auction_id)
  end

end
