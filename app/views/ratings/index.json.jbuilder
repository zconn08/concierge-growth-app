json.array!(@ratings) do |rating|
  json.extract! rating, :id, :rater, :rated, :rating
  json.url rating_url(rating, format: :json)
end
