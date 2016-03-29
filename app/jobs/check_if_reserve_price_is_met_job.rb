class CheckIfReservePriceIsMetJob < ActiveJob::Base
  queue_as :default

  def perform(bid)
    if bid.amount > bid.auction.reserve_price
      bid.auction.meets_reserve!
    else
      false
    end
  end
end
