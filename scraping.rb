# require 'pry'
require 'nokogiri'
require 'open-uri'
require './texting.rb'

# html = open('http://www.weather.com/weather/today/Long+Island+City+NY+11101:4:US')
# weather = Nokogiri::HTML(html)

class Scrape
    # html = open('http://www.weather.com/weather/today/Long+Island+City+NY+11101:4:US')
    # weather = Nokogiri::HTML(html)
	def initialize(url)
        @html = open(url)
        weather = Nokogiri::HTML(@html)

        good_morning

        if @temp_array[0].to_i >= 80 and @humidity[0].to_i < 80
            dress_lightly
        elsif @temp_array[0].to_i <= 50 and @temp_array[0].to_i > 37
            jacket
        elsif @temp_array[0].to_i <= 37
            coat
        end

        if @rain_array[0].to_i >= 50
            umbrella
        elsif @rain_array[1].to_i >= 50
            umbrella
        elsif @today_cond.downcase['rain'] == true
            umbrella
        elsif @today_cond.downcase['showers'] == true
            umbrella
        end
        
        if @today_cond.downcase['t-storms'] == true
            rainboots
        elsif @today_cond.downcase['snow'] == true
            rainboots
        elsif @today_cond.downcase['flurries'] == true
            rainboots
        elsif @today_cond.downcase['sleet'] == true
            rainboots
        elsif @today_cond.downcase['slush'] == true
            rainboots
        elsif @today_cond.downcase['wintry mix'] == true
            rainboots
        end

        if @today_cond.downcase['hail'] == true
            watch_head
        elsif @today_cond.downcase['apocalypse'] == true
            watch_head
        end

        if @temp_array[0].to_i >= 90 and @humidity[0].to_i >= 80
            icky
        end

        weather

    end

    def good_morning
        "Good morning!"
    end

    def dress_lightly
        "Dress lightly today."
    end

    def jacket
        "Wear a jacket today."
    end

    def coat
        "Wear a coat today."
    end

    def umbrella
        "Bring an umbrella."
    end

    def watch_head
        "Watch your head!"
    end

    def icky
        "Today's gonna be icky!  Wear short sleeves and stay cool."
    end

    def weather
        "Today's high: #{@temp_array[0]}.  Tonight's low: #{@temp_array[1]}."
        "Today: #{@today_cond}.  Tonight: #{t@onight_cond}."
        "Chance of #{@chance_of_what_day} today: #{@rain_array[0]}.  #{@chance_of_what_night.capitalize} tonight: #{@rain_array[1]}."
        "Humidity today: #{@humidity[0]}.  Tonight: #{@humidity[1]}."
    end

    def rainboots
        "Wear your rainboots today."
    end

    def message
        # html = open('http://www.weather.com/weather/today/Long+Island+City+NY+11101:4:US')
        # weather = Nokogiri::HTML(html)
        weather = Nokogiri::HTML(@html)

        @temp_array = weather.css("div.wx-temperature").children[2, 4].text.gsub("°", "° ").strip.split
        @today_cond = weather.css("div.wx-data-part div.wx-phrase").children[1].text
        @tonight_cond = weather.css("div.wx-data-part div.wx-phrase").children[2].text
        @chance_of_what_day = weather.css("div.wx-data-part h6.wx-label span.wx-firstletter").children[0].text
        @chance_of_what_night = weather.css("div.wx-data-part h6.wx-label span.wx-firstletter").children[1].text
        @rain_array = weather.css("div.wx-data-part div.wx-data").children[1..4].text.gsub("%", "% ").strip.split
        @humidity = weather.css("div.wx-data-part div.wx-data").children[21..22].text.gsub("%", "% ").strip.split

	end
end

scraped = Scrape.new("http://www.weather.com/weather/today/AYXX0001:1:AY")
message = scraped.
text = Text.new
# binding.pry
text.assign_body= ("#{message}")
text.text_chiara
	#3 columns: weather.css("div#wx-forecast-container div.wx-today.wx-module.wx-grid3of6")
	#titles: weather.css("div.wx-timepart-title").children[2, 3].text.gsub(/\s+/, " ").strip
	#temperatures: weather.css("div.wx-temperature").children[2, 4].text.gsub("°", "° ").strip.split
	#conditions: weather.css("div.wx-data-part div.wx-phrase").children[1, 2].text
	#chance of rain: pry(main)> weather.css("div.wx-data-part div.wx-data").children[1..4].text.gsub("%", "% ").strip
	#humidity: weather.css("div.wx-data-part div.wx-data").children[23..24].text.gsub("%", "% ").strip
	#UV index: weather.css("div.wx-data-part div.wx-data").children[26].text
	#chance of rain vs. snow: weather.css("div.wx-data-part h6.wx-label span.wx-firstletter").text.gsub("n", "n ").strip.split



