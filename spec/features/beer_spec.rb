require 'spec_helper'

describe "Beer" do  
  include OwnTestHelper

  let!(:user) { FactoryGirl.create :user }
  let!(:brewery) { FactoryGirl.create :brewery, :name => "Koff" }
  
  before :each do
    sign_in 'Pekka', 'foobar1'
  end

  it "is added to database when user adds one" do
    visit new_beer_path
    fill_in 'beer[name]', :with => 'olut'
    select 'IPA', :from => 'beer[style]'
    select brewery.name, :from => 'beer[brewery_id]'

    expect{
      click_button 'Create Beer'
    }.to change{Beer.count}.by(1)
  end
end