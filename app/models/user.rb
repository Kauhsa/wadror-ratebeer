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
  validates_length_of :password, :minimum => 4
  validates_length_of :username, :minimum => 3, :maximum => 15
  validate :good_password

  def to_s
    username
  end

  private

  def good_password
    if password.chars.all? { |char| CHARS.include? char}
      errors.add(:password, "password can't have only characters")
    end
  end
end
