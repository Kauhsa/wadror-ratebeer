CHARS = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

class User < ActiveRecord::Base
  include RatingAverage

  attr_accessible :username, :password, :password_confirmation
  has_many :ratings, :dependent => :destroy
  has_many :memberships
  has_many :beers, :through => :ratings
  has_many :beer_clubs, :through => :memberships
  has_secure_password

  validates_uniqueness_of :username
  validates_length_of :password, :minimum => 4, :if => lambda { password or new_record? }
  validates_length_of :username, :minimum => 3, :maximum => 15
  validate :good_password

  def to_s
    username
  end

  def favorite_beer
    return nil if ratings.empty?
    ratings.sort_by{ |r| r.score }.last.beer
  end

  def favorite_style
    return favorite_beer_feature(:style)
  end

  def favorite_brewery
    return favorite_beer_feature(:brewery)
  end

  private

  def favorite_beer_feature(feature)
    return nil if ratings.empty?
    grouped = ratings.group_by{|x| x.beer.send(feature)}
    grouped.each_pair{|k, v| grouped[k] = v.sum(&:score) / v.size.to_f}
    grouped.sort_by{|k, v| v}.last[0]
  end

  def good_password
    if password and password.chars.all? { |char| CHARS.include? char}
      errors.add(:password, "password can't have only characters")
    end
  end
end
