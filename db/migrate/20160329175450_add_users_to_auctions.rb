class AddUsersToAuctions < ActiveRecord::Migration
  def change
    add_reference :auctions, :user, index: true, foreign_key: true
  end
end
