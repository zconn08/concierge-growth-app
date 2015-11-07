class RatingsController < ApplicationController
  before_action :authenticate_user!

  def new
    @rating = Rating.new
  end

  def create
    @rating = Rating.new(rating_params)
    @rating.rater = current_user.id
    @rating.rated = 1000
    if @rating.save
      render json: @rating
    else
      render json: @rating.errors.full_messages
    end
  end

  private

    def rating_params
      params.require(:rating).permit(:rater, :rated, :rating, :rationale)
    end
end
