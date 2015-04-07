class CreateBusinesses < ActiveRecord::Migration
  def change
    create_table :businesses do |t|
      t.string :yid
      t.string :name
      t.string :neighborhoods
      t.string :full_address
      t.string :city
      t.string :state
      t.float :stars
      t.integer :review_count
      t.string :categories
      t.boolean :open
      t.string :hours
      t.string :yattributes

      t.timestamps null: false
    end
  end
end
