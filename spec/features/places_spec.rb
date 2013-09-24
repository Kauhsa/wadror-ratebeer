require 'spec_helper'

describe "Places" do
  def do_search
    visit places_path
    fill_in('city', :with => 'kumpula')
    click_button "Search"
  end

  it "if one is returned by the API, it is shown at the page" do
    BeermappingAPI.stub(:places_in).with("kumpula").and_return([
      Place.new(:name => "Oljenkorsi", :id => "1", :city => "Helsinki")
    ])
    do_search
    expect(page).to have_content "Oljenkorsi"
  end

  it "if many is returned by the api, all are shown at the page" do
    places = [
      Place.new(:name => "Oljenkorsi", :id => "1", :city => "Helsinki"),
      Place.new(:name => "Toinen", :id => "1", :city => "Helsinki")
    ]
    BeermappingAPI.stub(:places_in).with("kumpula").and_return(places)
    do_search
    places.each do |place|  
      expect(page).to have_content(place.name)
    end
  end

  it "if no places are returned, show error message" do
    BeermappingAPI.stub(:places_in).with("kumpula").and_return([])
    do_search
    expect(page).to have_content("No locations in kumpula")
  end
end