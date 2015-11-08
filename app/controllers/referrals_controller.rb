class ReferralsController < ApplicationController
  def create
    @referral = Referral.new(referral_params)
    @referral.referral_link = random_code
    if @referral.save
      Event.create(event_type: "Submitted Rating", user_id: current_user.id, referral_id: @referral.id) if @referral.rating.rating > 3
      render json: @referral
    else
      render json: @referral.errors.full_messages
    end
  end

  def show
    sign_out
    @referral = Referral.includes(rating: [:rating_user]).where(referral_link: params[:id])[0]
    @referrer = @referral.referring_user.first_name
    @rating = @referral.rating.rating
    Event.create(event_type: "Invite Page View", referral_id: @referral.id)
  end

  def random_code
    random_code = SecureRandom::urlsafe_base64[0..8]

    while Referral.exists?(referral_link: random_code)
      random_code = SecureRandom::urlsafe_base64[0..8]
    end

    random_code
  end

  private
    def referral_params
      params.require(:referral).permit(:rating_id)
    end
end
