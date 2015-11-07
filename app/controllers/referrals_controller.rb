class ReferralsController < ApplicationController
  def create
    @referral = Referral.new(referral_params)
    @referral.referral_link = random_code
    if @referral.save
      render json: @referral
    else
      render json: @referral.errors.full_messages
    end
  end

  def show
    @referral = Referral.includes(rating: [:rating_user]).where(referral_link: params[:id])[0]
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
