class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :beer_club
  attr_accessible :beer_club, :beer_club_id, :user, :user_id, :confirmed
  validates :user_id, uniqueness: { scope: :beer_club_id, message: "can join a club only once"}

  scope :confirmed, where(confirmed: true)
  scope :not_confirmed, where("confirmed or confirmed is null")
end
