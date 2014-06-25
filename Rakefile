require 'nokogiri'
require 'open-uri'
require 'twilio-ruby'
require './scraping.rb'
require './texting.rb'

task :method
	scraped = Scrape.new
	
	text = Text.new
	text.assignbody=("#{scraped.message}")
	text.text_chiara
end

method