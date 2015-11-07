class AddReferralLink < ActiveRecord::Migration
  def change
    add_column :ratings, :referral_link, :string
  end
end
