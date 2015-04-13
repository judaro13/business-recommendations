class AddUserIDtoReview < ActiveRecord::Migration
  def change
    # add_column :reviews, :user_id, :integer
    # add_column :reviews, :business_id, :integer
    add_index :businesses, :yid
  end
end
