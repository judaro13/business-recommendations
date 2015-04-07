class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.text :description
      t.string :business_id
      t.string :user_id
      t.string :date
      t.integer :likes

      t.timestamps null: false
    end
  end
end
