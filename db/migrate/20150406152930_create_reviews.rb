class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :business_id
      t.string :user_id
      t.float :stars
      t.text :description
      t.string :date
      t.string :votes

      t.timestamps null: false
    end
  end
end
