module RatingAverage
  def average_rating
    ratings.average(:score)
    # ratings.inject(0) { |avg, n| avg + n.score } / ratings.count.to_f
  end
end