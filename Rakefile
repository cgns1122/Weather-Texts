require 'nokogiri'
require 'open-uri'
require 'twilio-ruby'
require './lib/scraping.rb'
require './lib/messaging.rb'

task :method do
	scraped = Scrape.new("ENV[WEATHER-LINK]")
	message = scraped.message
	text = Text.new
	text.assign_body= ("#{message}")
	text.text_chiara
end