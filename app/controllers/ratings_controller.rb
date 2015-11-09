class RatingsController < ApplicationController
  before_action :authenticate_user!
  def index
    @ratings = Rating.all
    render json: @ratings
  end

  def new
    Event.create(event_type: "Rating Page View", user_id: current_user.id)
    @rating = Rating.new
  end

  def create
    @rating = Rating.new(rating_params)
    @rating.rater = current_user.id
    @rating.rated = 1000 #Placeholder ID for Bob

    if @rating.save
      Event.create(event_type: "Submitted Rating", user_id: current_user.id) unless @rating.rating > 3
      render json: @rating
    else
      render json: @rating.errors.full_messages
    end
  end

  private

    def rating_params
      params.require(:rating).permit(:rating, :rationale)
    end
end
