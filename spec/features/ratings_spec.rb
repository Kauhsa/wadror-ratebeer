require 'spec_helper'

describe "Rating" do
  include OwnTestHelper

  let!(:brewery) { FactoryGirl.create :brewery, :name => "Koff" }
  let!(:beer1) { FactoryGirl.create :beer, :name => "iso 3", :brewery => brewery }
  let!(:beer2) { FactoryGirl.create :beer, :name => "Karhu", :brewery => brewery }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in 'Pekka', 'foobar1'
  end

  it "when given, is registered to the beer and user who is signed in" do
    visit new_rating_path
    select(beer1.to_s, :from => 'rating[beer_id]')
    fill_in('rating[score]', :with => '15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.by(1)

    expect(user.ratings.count).to eq(1)
    expect(beer1.ratings.count).to eq(1)
    expect(beer1.average_rating).to eq(15.0)
  end

  describe "when rating exists in database" do    
    before :each do
      # jostain syystä vastaava let tai let! ei suostu toimimaan :(
      @rating = FactoryGirl.create :rating, :beer => beer1, :user => user
    end

    it "is shown on beer page" do
      visit beer_path(beer1)
      expect(page).to have_content("has been rated 1 times")
    end

    it "is shown on user's page" do
      visit user_path(user)
      expect(page).to have_content("#{beer1.name} #{@rating.score}")
    end

    it "gets deleted from database when user deletes it" do
      visit user_path(user)
      expect {
        click_link "delete"
      }.to change{Rating.count}.by(-1)
    end
  end
end