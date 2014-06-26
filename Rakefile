require 'nokogiri'
require 'open-uri'
require 'twilio-ruby'
require './lib/scraping.rb'
require './lib/messaging.rb'

task :method do
	scraped = Scrape.new("http://www.weather.com/weather/today/11101:4:US")
	message = scraped.message
	text = Text.new
	text.assign_body= ("#{message}")
	text.text_chiara
end