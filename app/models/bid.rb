class Bid < ActiveRecord::Base
  belongs_to :auction

  validates :amount, numericality: {greater_than_or_equal_to: 1}

end
