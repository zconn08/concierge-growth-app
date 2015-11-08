class EventsController < ApplicationController
  def index
    @events = Event.all
    render json: @events
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id if current_user
    if @event.save
      render json: @event
    else
      render json: @event.errors.full_messages
    end
  end

  private

    def event_params
      params.require(:events).permit(:event_type, :referral_id)
    end
end
