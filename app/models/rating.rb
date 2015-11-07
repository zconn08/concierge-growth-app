class Rating < ActiveRecord::Base
  validates :rater, :rated, :rating, presence: true
  belongs_to(
    :rating_user,
    class_name: "User",
    foreign_key: :rater,
    primary_key: :id
  )
  has_one :referral
end
