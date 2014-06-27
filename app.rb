require 'bundler'
Bundler.require
require './lib/messaging'
require './lib/scraping'
require 'pry'

get '/' do
  @htmlscrape = Scrape.new('http://www.weather.com/weather/today/11101:4:US')
  erb :index
end 