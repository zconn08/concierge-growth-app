class AddRationale < ActiveRecord::Migration
  def change
    add_column :ratings, :rationale, :text
  end
end
