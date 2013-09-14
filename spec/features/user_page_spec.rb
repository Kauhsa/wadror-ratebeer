require 'spec_helper'

describe "User page" do  
  include OwnTestHelper

  let!(:user) { FactoryGirl.create :user }
  let!(:brewery) { FactoryGirl.create :brewery, :name => "Koff" }
  let!(:beer) { FactoryGirl.create :beer, :name => "iso 3", :brewery => brewery }
  let!(:rating) { FactoryGirl.create :rating, :score => "50", :user => user, :beer => beer }

  before :each do
    sign_in 'Pekka', 'foobar1'
    visit user_path(user)
  end

  it "shows favorite beer style" do
      expect(page).to have_content("favorite style: #{user.favorite_style}")
  end

  it "shows favorite brewery" do
      expect(page).to have_content("favorite brewery: #{user.favorite_brewery}")
  end
end