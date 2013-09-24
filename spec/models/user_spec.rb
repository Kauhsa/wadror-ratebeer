require 'spec_helper'

describe User do
  it "has the username set correctly" do
    user = User.new :username => "Pekka"

    user.username.should == "Pekka"
  end

  describe "is not saved" do
    it "without a proper password" do
      @user = User.create :username => "Pekka"
    end

    it "with too short password" do
      @user = User.create :username => "Pekka", :password => "io0"
    end

    it "with password consisting only characters" do
      @user = User.create :username => "Pekka", :password => "asdas"
    end

    after :each do
      expect(@user.valid?).to be(false)
      expect(User.count).to eq(0)
    end
  end

  describe "with a proper password" do
    let(:user){ FactoryGirl.create :user }

    it "is saved" do
      expect(user.valid?).to be(true)
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating1)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  describe "favorite beer" do
    let(:user){FactoryGirl.create(:user) }

    it "has method for determining one" do
      user.should respond_to :favorite_beer
    end

    it "without ratings does not have one" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = create_beer_with_rating user, 10

      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_ratings user, [10, 20, 15, 7, 9]
      best = create_beer_with_rating user, 25

      expect(user.favorite_beer).to eq(best)
    end
  end

  describe "favorite style" do
    let(:user){ FactoryGirl.create :user }
    let(:style1) { FactoryGirl.create :style }
    let(:style2) { FactoryGirl.create :style }
    let(:style3) { FactoryGirl.create :style }

    it "is nil if user has not rated any beers" do
      expect(user.favorite_style).to be(nil)
    end

    it "is style of the only rated beer" do
      create_beer_with_rating user, 10, :style => style1
      expect(user.favorite_style).to eq(style1)
    end

    it "is style with highest average rating if several rated" do
      create_beers_with_ratings user, [10, 31, 50], :style => style1
      create_beers_with_ratings user, [10, 10], :style => style2
      create_beers_with_ratings user, [10, 50], :style => style3

      expect(user.favorite_style).to eq(style1)
    end
  end

  describe "favorite breweries" do
    let(:user){ FactoryGirl.create :user }

    it "is nil if user has not rated any beers" do
      expect(user.favorite_brewery).to be(nil)
    end

    it "is brewery of the only rated beer" do
      brewery = FactoryGirl.create(:brewery)
      create_beer_with_rating user, 10, :brewery => brewery
      expect(user.favorite_brewery).to eq(brewery)
    end

    it "is brewery with highest average rating if several rated" do
      create_beers_with_ratings user, [10, 31, 50], :brewery => FactoryGirl.create(:brewery)
      create_beers_with_ratings user, [10], :brewery => FactoryGirl.create(:brewery)
      best = FactoryGirl.create(:brewery)
      create_beers_with_ratings user, [10, 50, 50], :brewery => best

      expect(user.favorite_brewery).to eq(best)
    end
  end

  def create_beers_with_ratings(user, scores, beer_options = {})
    scores.each do |score|
      create_beer_with_rating user, score, beer_options
    end
  end

  def create_beer_with_rating(user, score, beer_options = {})
    beer = FactoryGirl.create(:beer, beer_options)
    FactoryGirl.create(:rating, :score => score, :beer => beer, :user => user)
    beer
  end
end