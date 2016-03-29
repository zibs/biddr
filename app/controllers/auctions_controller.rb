class AuctionsController < ApplicationController
before_action :find_auction, only: [:show, :edit, :update, :destroy]
before_action :authenticate_user, except: [:index]

  def index
    @auctions = Auction.order("created_at DESC")
  end

  def new
    @auction = Auction.new
  end

  def create
    @auction = Auction.new(auction_params)
    @auction.user = current_user
    if @auction.save
      redirect_to @auction, flash: {success: "Auction Created"}
    else
      flash[:info] = "Auction not created"
      render :new
    end
  end

  def edit
  end

  def update
    if @auction.update(auction_params)
      redirect_to(auction_path(@auction), { notice: "Auction updated" })
    else
      render :edit
    end
  end

  def show
    @bid = Bid.new
    @bids = @auction.bids
  end

  def destroy
  end

  private

  def auction_params
      params.require(:auction).permit(:title, :details, :reserve_price, :ends_on)
    end

    def find_auction
      @auction = Auction.find(params[:id]).decorate
    end

end
