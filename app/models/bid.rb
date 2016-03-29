class Bid < ActiveRecord::Base
  belongs_to :auction
  belongs_to :user
  before_create :check_price_is_greater_than_current_bid
  validates :amount, numericality: {greater_than_or_equal_to: 1}

  def check_price_is_greater_than_current_bid
    unless  auction.bids.present? && amount > auction.bids.last.amount
      errors.add(:amount, "Bid must be greater than current bid")
      # errors.add(:expiration_date, "can't be in the past")

    end
  end

  def user_full_name
    user.full_name if user
  end


end
