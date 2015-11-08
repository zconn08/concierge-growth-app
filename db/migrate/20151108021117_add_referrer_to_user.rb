class AddReferrerToUser < ActiveRecord::Migration
  def change
    add_column :users, :referrer_id, :integer, index: true
  end
end
