class Beer < ActiveRecord::Base
  include RatingAverage
  extend Top

  attr_accessible :brewery_id, :name, :style_id, :style
  belongs_to :brewery
  has_many :ratings, :dependent => :destroy
  has_many :raters, :through => :ratings, :source => :user
  belongs_to :style

  validates :name, :presence => true
  validates :style, :presence => true

  def to_s
    "#{name} (#{brewery.name})"
  end
end
