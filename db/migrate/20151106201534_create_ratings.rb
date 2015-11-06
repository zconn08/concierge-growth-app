class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :rater
      t.integer :rated
      t.integer :rating

      t.timestamps null: false
    end
  end
end
