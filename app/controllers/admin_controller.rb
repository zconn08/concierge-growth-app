class AdminController < ApplicationController

  def index
    #Queries
    events_total = Event.group(:event_type).count
    events_by_rating = Event.joins(:rating).group([:event_type, :rating]).count
    unique_events = Event.group(:event_type).distinct.count(:user_id)
    ratings_count = Rating.group(:rating).distinct.count(:rater)
    referral_counts = User.where("referrer_id > ?", 0).group(:referrer_id).count
    user_count = User.count


    #Key Metrics
    total_ratings = hash_sum_values(ratings_count)

    @submitted_rating_percent = to_percent(unique_events["Submitted Rating"], unique_events["Rating Page View"])
    @percent_four_or_five_ratings = to_percent(ratings_count[4].to_i + ratings_count[5].to_i, total_ratings)
    @page_views_per_invite_link_displayed = to_multiplier(events_total["Invite Page View"], Referral.count)
    @signups_per_invite_page_view = to_percent(events_total["User Signed Up"], events_total["Invite Page View"])

    #Conversion on Sign Up Page
    sign_up_button_clicked_percent_4 = to_percent(events_by_rating[["Sign Up Button Clicked", 4]], events_by_rating[["Invite Page View", 4]])
    successful_sign_up_percent_4 = to_percent(events_by_rating[["User Signed Up", 4]], events_by_rating[["Invite Page View", 4]])

    sign_up_button_clicked_percent_5 = to_percent(events_by_rating[["Sign Up Button Clicked", 5]], events_by_rating[["Invite Page View", 5]])
    successful_sign_up_percent_5 = to_percent(events_by_rating[["User Signed Up", 5]], events_by_rating[["Invite Page View", 5]])

    @funnel = [
     {name: "5 Star Rating", data: {
       "Invite Page Viewed" => 100,
       "Sign Up Button Clicked" => sign_up_button_clicked_percent_5,
       "Successful Sign Up" => successful_sign_up_percent_5
      }
     },
     {name: "4 Star Rating", data: {
       "Invite Page Viewed" => 100,
       "Sign Up Button Clicked" => sign_up_button_clicked_percent_4,
       "Successful Sign Up" => successful_sign_up_percent_4
      }
     },
    ]


    #Top Users Driving Sign Up
    total_referrals = hash_sum_values(referral_counts)
    sorted_referrers = referral_counts.sort_by{ |user, count| -count }

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


    #Ratings Percent Breakdown
    @ratings_percent_breakdown = ratings_count.map do |rating, num_ratings|
       [rating, to_percent(num_ratings, total_ratings)]
     end

  end

  def to_percent(numerator, denominator)
    return 0 unless numerator.is_a?(Fixnum) && denominator.is_a?(Fixnum) && denominator > 0
    (numerator.to_f / denominator.to_f * 100).round
  end

  def to_multiplier(numerator, denominator)
    return 0 unless numerator.is_a?(Fixnum) && denominator.is_a?(Fixnum) && denominator > 0
    (numerator.to_f / denominator.to_f).round(2)
  end

  def hash_sum_values(input_hash)
    input_hash.inject(0) {|sum, hash| sum + hash[1]}
  end
end
