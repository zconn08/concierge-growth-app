class EventsController < ApplicationController
  def index
    @events = Event.all
    render json: @events
  end

  def admin
    #Queries
    events_total = Event.group(:event_type).count
    events_by_rating = Event.joins(:rating).group([:event_type, :rating]).count
    unique_events = Event.group(:event_type).distinct.count(:user_id)
    unique_events_by_rating = Event.joins(:rating).group([:event_type, :rating]).distinct.count(:user_id)
    referral_counts = User.where("referrer_id > ?", 0).group(:referrer_id).count
    user_count = User.count

    # Funnel One Data
    @rating_page_view_percent = to_percent(unique_events["Rating Page View"], events_total["Login Page View"])
    @submitted_rating_percent = to_percent(unique_events["Submitted Rating"], events_total["Login Page View"])

    # Funnel Two Data (Breakdown by number of stars)
    @invite_page_view_percent_4 = to_percent(events_by_rating[["Invite Page View", 4]], unique_events_by_rating[["Submitted Rating", 4]])
    @sign_up_button_clicked_percent_4 = to_percent(events_by_rating[["Sign Up Button Clicked", 4]], unique_events_by_rating[["Submitted Rating", 4]])
    @successful_sign_up_percent_4 = to_percent(events_by_rating[["User Signed Up", 4]], unique_events_by_rating[["Submitted Rating", 4]])

    @invite_page_view_percent_5 = to_percent(events_by_rating[["Invite Page View", 5]], unique_events_by_rating[["Submitted Rating", 5]])
    @sign_up_button_clicked_percent_5 = to_percent(events_by_rating[["Sign Up Button Clicked", 5]], unique_events_by_rating[["Submitted Rating", 5]])
    @successful_sign_up_percent_5 = to_percent(events_by_rating[["User Signed Up", 5]], unique_events_by_rating[["Submitted Rating", 5]])

    # Refer Info
    sorted_referrers = referral_counts.sort_by{ |user, count| -count }
    total_referrals = referral_counts.inject(0) {|sum, hash| sum + hash[1]}

    #Top referrers driving invites
    ten_percent_of_users = (user_count * 0.1).round
    twenty_percent_of_users = (user_count * 0.2).round


    referrals_from_ten_percent = sorted_referrers
                                    .first(ten_percent_of_users)
                                    .inject(0){ |sum, arr| sum + arr[1]}

    referrals_from_twenty_percent = sorted_referrers
                                    .first(twenty_percent_of_users)
                                    .inject(0){ |sum, arr| sum + arr[1]}

    @top_ten_percent_of_referrals = to_percent(referrals_from_ten_percent, total_referrals)
    @top_twenty_percent_of_referrals = to_percent(referrals_from_twenty_percent, total_referrals)

    #Leading referrer

    top_referrer = sorted_referrers[0]

    top_referrals = top_referrer[1]

    @name = User.find(top_referrer[0]).first_name
    @top_referrer_as_percent = to_percent(top_referrals, total_referrals)
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

  def to_percent(numerator, denominator)
    (numerator.to_f / denominator.to_f * 100).round
  end

  private

    def event_params
      params.require(:events).permit(:event_type, :referral_id)
    end
end
