require 'nokogiri'
require 'open-uri'
require 'twilio-ruby'
require './scraping.rb'
require './texting.rb'

<<<<<<< HEAD
task :method
	scraped = Scrape.new
	
	text = Text.new
	text.assignbody=("#{scraped.message}")
	text.text_chiara
end

method
=======
task :method do
	scraped = Scrape.new("http://www.weather.com/weather/today/11101:4:US")
	message = scraped.message
	text = Text.new
	text.assign_body= ("#{message}")
	text.text_chiara
end

>>>>>>> scraping
