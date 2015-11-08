class Event < ActiveRecord::Base
  validates :event_type, presence: true
  belongs_to :referral
  belongs_to :user
end
