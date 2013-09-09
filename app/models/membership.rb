class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :beer_club
  attr_accessible :title, :body, :beer_club_id
  validates :user_id, uniqueness: { scope: :beer_club_id, message: "can join a club only once"}
end
