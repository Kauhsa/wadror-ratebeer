class BeermappingAPI
  def self.places_in(city)
    city = city.downcase

    if should_update_cache? city
      update_cache city
    end
    
    Rails.cache.read(city)[:places]
  end

  def self.place(city, id)
    places = places_in(city)
    places.find {|x| x.id == id}
  end

  def self.scores_in(id)
    fetch_scores_in(id)
  end

  private

  def self.should_update_cache?(city)
    (not Rails.cache.exist? city) or (Rails.cache.read(city)[:time] < 1.minute.ago)
  end

  def self.update_cache(city)
    Rails.cache.write(city, {:places => fetch_places_in(city), :time => Time.now})
  end

  def self.fetch_places_in(city)
    url = "http://beermapping.com/webservice/loccity/#{key}/"

    response = HTTParty.get "#{url}#{city.gsub(' ', '%20')}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.inject([]) do | set, place |
      set << Place.new(place)
    end
  end

  def self.fetch_scores_in(id)
    url = "http://beermapping.com/webservice/locscore/#{key}/"
    response = HTTParty.get "#{url}#{id}"
    location = response.parsed_response["bmp_locations"]["location"]
    return nil if response.empty?
    location
  end

  def self.key
    Settings.beermapping_apikey
  end
end