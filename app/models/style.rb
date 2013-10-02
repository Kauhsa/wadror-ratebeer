class Style < ActiveRecord::Base
  include RatingAverage
  extend Top

  attr_accessible :description, :name
  has_many :beers
  has_many :ratings, :through => :beers

  def to_s
    name
  end
end
