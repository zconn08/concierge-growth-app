class Rating < ActiveRecord::Base
  validates :rater, :rated, :rating, presence: true
  has_one :referral
end
