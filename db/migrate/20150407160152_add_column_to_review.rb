class AddColumnToReview < ActiveRecord::Migration
  def change
    add_column :reviews, :yid, :string
  end
end
