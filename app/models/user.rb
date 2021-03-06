class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable,
    :omniauthable, :omniauth_providers => [:google_oauth2]

  has_many(
    :ratings,
    class_name: "Rating",
    foreign_key: :rater,
    primary_key: :id
  )

  # User who referred you
  belongs_to(
    :referring_user,
    class_name: "User",
    foreign_key: :referrer_id,
    primary_key: :id
  )

  # Users you referred
  has_many(
    :users_referred,
    class_name: "User",
    foreign_key: :referrer_id,
    primary_key: :id
  )

  has_many :events

  def self.from_omniauth(auth)
     where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
       user.provider = auth.provider
       user.uid = auth.uid
       user.email = auth.info.email
       user.first_name = auth.info.first_name
       user.last_name = auth.info.last_name
       user.password = Devise.friendly_token[0,20]
     end
  end
end
