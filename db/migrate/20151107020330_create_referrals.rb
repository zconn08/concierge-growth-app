class CreateReferrals < ActiveRecord::Migration
  def change
    create_table :referrals do |t|
      t.integer :rating_id, null: false, index: true
      t.string :referral_link, null: false
      t.timestamps null: false
    end
    remove_column :ratings, :referral_link
  end
end
