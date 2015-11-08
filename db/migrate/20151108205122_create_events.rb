class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :type, null: false
      t.integer :referral_id, index: true
      t.integer :user_id, index: true
      t.timestamps null: false
    end
  end
end
