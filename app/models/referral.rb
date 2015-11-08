class Referral < ActiveRecord::Base
  validates :rating_id, :referral_link, presence: true
  belongs_to :rating
  has_one :referring_user, through: :rating, source: :rating_user
end
