class Brewery < ActiveRecord::Base
  include RatingAverage
  extend Top

  attr_accessible :name, :year, :active
  
  has_many :beers
  has_many :ratings, :through => :beers

  scope :active, where(:active => true)
  scope :retired, where(:active => [nil, false])

  validates :name, :presence => true
  validates_numericality_of :year, { :greater_than_or_equal_to => 1042, 
                                      :less_than_or_equal_to => lambda {|_| Time.now.year}, 
                                      :only_integer => true }

  def to_s
    name
  end


end
