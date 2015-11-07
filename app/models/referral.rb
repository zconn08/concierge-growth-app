class Referral < ActiveRecord::Base
  validates :rating_id, :referral_link, presence: true
  belongs_to :rating
end
