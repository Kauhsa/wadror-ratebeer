class User < ActiveRecord::Base
  include RatingAverage

  attr_accessible :username
  has_many :ratings  
  has_many :beers, :through => :ratings

  def to_s
    username
  end
end
