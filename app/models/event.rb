class Event < ActiveRecord::Base
  validates :event_type, presence: true
  belongs_to :referral
  belongs_to :user
  has_one :rating, through: :referral, source: :rating
end
