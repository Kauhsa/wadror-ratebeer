require 'spec_helper'

#def create_beer_with_rating(score,  user)
#  beer = FactoryGirl.create(:beer)
#  FactoryGirl.create(:rating, :score => score,  :beer => beer, :user => user)
#  beer
#end

describe Beer do

  describe "is not be saved" do
    it "without a name" do
      style = FactoryGirl.create(:style)
      @beer = Beer.create :style => style
    end

    it "without a style" do
      @beer = Beer.create :name => "olut"
    end

    after :each do
      expect(@beer.valid?).to be(false)
      expect(Beer.count).to eq(0)
    end
  end
end