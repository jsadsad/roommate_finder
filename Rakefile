require_relative './config/environment'

def reload
  load_all './lib'
end

task :console do
  Pry.start
end

task :scrape_rooms do
  #instantiate a scraper and then have it find new rooms
  east_bay_scraper = RoomScraper.new('https://sfbay.craigslist.org/search/eby/roo').update_rooms
  # east_bay_scraper.call
  # south_bay_scraper = RoomScraper.new('https://sfbay.craigslist.org/search/sby/roo?').update_rooms
  # south_bay_scraper.call
  #after this method call, I SHOULD be able to say Room.all and have rooms there
end
