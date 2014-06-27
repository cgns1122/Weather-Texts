require 'bundler'
Bundler.require
require './lib/messaging'
require './lib/scraping'
require 'pry'

get '/' do
  @htmlscrape = Scrape.new('ENV[WEATHER-LINK]')
  erb :index
end 