class AddColumnToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :longitude, :string
    add_column :businesses, :latitude, :string
  end
end
