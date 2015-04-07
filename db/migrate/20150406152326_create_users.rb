class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :yid
      t.string :name
      t.integer :review_count
      t.float :average_stars
      t.integer :votes
      t.string :friends
      t.string :compliments
      t.integer :fans

      t.timestamps null: false
    end
  end
end
