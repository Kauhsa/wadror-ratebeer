class Beer < ActiveRecord::Base
  attr_accessible :brewery_id, :name, :style

  belongs_to :brewery
  has_many :ratings, :dependent => :destroy

  def average_rating
    ratings.average(:score)
    # ratings.inject(0) { |avg, n| avg + n.score } / ratings.count.to_f
  end

  def to_s
    "#{name} (#{brewery.name})"
  end
end
