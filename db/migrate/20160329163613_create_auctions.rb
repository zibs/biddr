class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.string :title
      t.string :details
      t.date :ends_on
      t.decimal :reserve_price, :precision => 8, :scale => 2
      t.string :aasm_state

      t.timestamps null: false
    end
    add_index :auctions, :aasm_state
  end
end
