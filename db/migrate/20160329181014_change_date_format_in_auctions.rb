class ChangeDateFormatInAuctions < ActiveRecord::Migration
  def change
     change_column :auctions, :ends_on, :string
  end
end
