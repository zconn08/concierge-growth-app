class AdminController < ApplicationController

  def index
    #Queries
    @events_total = Event.group(:event_type).count
    events_by_rating = Event.joins(:rating).group([:event_type, :rating]).count
    @unique_events = Event.group(:event_type).distinct.count(:user_id)
    ratings_count = Rating.group(:rating).distinct.count(:rater)
    referral_counts = User.where("referrer_id > ?", 0).group(:referrer_id).count
    user_count = User.count

    #Key Metrics
    total_ratings = hash_sum_values(ratings_count)

    @submitted_rating_percent = to_percent(
      @unique_events["Submitted Rating"],
      @unique_events["Rating Page View"]
    )
    @percent_four_or_five_ratings = to_percent(
      ratings_count[4].to_i + ratings_count[5].to_i,
      total_ratings
    )
    @page_views_per_invite_link_displayed = to_multiplier(
      @events_total["Invite Page View"],
      events_by_rating[["Submitted Rating",4]].to_i + events_by_rating[["Submitted Rating",5]].to_i
    )
    @signups_per_invite_page_view = to_percent(
      @events_total["User Signed Up"],
      @events_total["Invite Page View"]
    )

    #Conversion on Sign Up Page
    sign_up_button_clicked_percent_4 = to_percent(
      events_by_rating[["Sign Up Button Clicked", 4]],
      events_by_rating[["Invite Page View", 4]]
    )
    successful_sign_up_percent_4 = to_percent(
      events_by_rating[["User Signed Up", 4]],
      events_by_rating[["Invite Page View", 4]]
    )
    sign_up_button_clicked_percent_5 = to_percent(
      events_by_rating[["Sign Up Button Clicked", 5]],
      events_by_rating[["Invite Page View", 5]]
    )
    successful_sign_up_percent_5 = to_percent(
      events_by_rating[["User Signed Up", 5]],
      events_by_rating[["Invite Page View", 5]]
    )

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

    #page views by rating
    @page_views_per_invite_link_displayed_four = to_multiplier(
      events_by_rating[["Invite Page View",4]],
      events_by_rating[["Submitted Rating",4]]
    )
    @page_views_per_invite_link_displayed_five = to_multiplier(
      events_by_rating[["Invite Page View",5]],
      events_by_rating[["Submitted Rating",5]]
    )

    @page_views_by_rating = [
      ["4 Rating", @page_views_per_invite_link_displayed_four],
      ["5 Rating", @page_views_per_invite_link_displayed_five]
    ]

    #Top Users Driving Sign Up

    top_ten_percent_of_referrals = percent_of_referrals(referral_counts, user_count, 0.1)
    top_twenty_percent_of_referrals = percent_of_referrals(referral_counts, user_count, 0.2)

    @percent_of_users_driving_sign_up = [
      ["Percent of Signups From Top 10%", top_ten_percent_of_referrals],
      ["Percent of Signups From Top 20%", top_twenty_percent_of_referrals],
    ]

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

  def percent_of_referrals(referral_counts, user_count, decimal)
    total_referrals = hash_sum_values(referral_counts)
    sorted_referrers = referral_counts.sort_by{ |user, count| -count }

    num_users = (user_count * decimal).round
    num_referrals = sorted_referrers
                      .first(num_users)
                      .inject(0){ |sum, arr| sum + arr[1]}
    to_percent(num_referrals, total_referrals)
  end

  def hash_sum_values(input_hash)
    input_hash.inject(0) {|sum, hash| sum + hash[1]}
  end
end
