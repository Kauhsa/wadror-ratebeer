class BeerClub < ActiveRecord::Base
  attr_accessible :city, :founded, :name
  has_many :memberships
  has_many :users, :through => :memberships

  def members
    memberships.confirmed.collect{|x| x.user}
  end

  def is_member?(user)
    members.include? user
  end

  def to_s
    name
  end
end
