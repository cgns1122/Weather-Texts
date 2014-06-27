require 'nokogiri'
require 'open-uri'

class Scrape
    attr_accessor :time_array, :date_array, :month, :date, :year, :temp_array, :today_cond, :tonight_cond, :chance_of_what_day, :chance_of_what_night, :humidity_array, :rain_array, :today_high, :tonight_low, :today_rain, :tonight_rain, :tonight_hum, :today_hum

    def initialize(url)
        @html = open(url)
        @weather = Nokogiri::HTML(@html)

        find_humidity
        find_rainchance

        @time_array = Time.new.to_s.split
        @date_array = @time_array[0].split("-")
        @month = @date_array[1]
        @date = @date_array[2]
        @year = @date_array[0]

        @temp_array = @weather.css("div.wx-temperature").children[2, 4].text.gsub("°", "° ").strip.split
        @today_cond = @weather.css("div.wx-data-part div.wx-phrase").children[1].text
        @tonight_cond = @weather.css("div.wx-data-part div.wx-phrase").children[2].text
        @chance_of_what_day = @weather.css("div.wx-data-part h6.wx-label span.wx-firstletter").children[0].text
        @chance_of_what_night = @weather.css("div.wx-data-part h6.wx-label span.wx-firstletter").children[1].text
        @today_high = @temp_array[0]
        @tonight_low = @temp_array[1]
        @today_rain = @rain_array[0]
        @tonight_rain = @rain_array[1]
        @today_hum = @humidity_array[1]
        @tonight_hum = @humidity_array[2]
    end

    def message
        find_humidity
        find_rainchance
        "#{good_morning}  #{temp_check}#{rain_check}#{rainboots}#{watch_head}#{icky}#{weather}"

    end

    def good_morning
        "Good morning!"
    end

    def temp_check
        if @temp_array[0].gsub("°", " ").to_i >= 80 && @humidity_array[1].gsub("%", " ").to_i < 80
            "Dress lightly today.  "
        elsif @temp_array[0].gsub("°", " ").to_i <= 50 && @temp_array[0].to_i > 37
            "Wear a jacket today.  "
        elsif @temp_array[0].to_i <= 37
            "Wear a coat today.  "
        end
    end

    def rain_check
        if @rain_array[0].to_i >= 50 || @rain_array[1].to_i >= 50 || @today_cond.downcase.include?('rain') || @today_cond.downcase.include?('showers')
            "Bring an umbrella.  "
        end
    end

    def watch_head
        if @today_cond.downcase.include?('hail') || @today_cond.downcase.include?('apocalypse')
            "Watch your head!  "
        end
    end

    def icky
        if @temp_array[0].to_i >= 90 && @humidity_array[1].to_i >= 80
            "Today's gonna be icky!  Wear short sleeves and stay cool.  "
        end
    end

    def weather
        "Today's high: #{@temp_array[0]}.  Tonight's low: #{@temp_array[1]}.  Today: #{@today_cond}.  Tonight: #{@tonight_cond}.  Chance of #{@chance_of_what_day} today: #{@rain_array[0]}.  Tonight: #{@rain_array[1]}.  Humidity today: #{@humidity_array[1]}.  Tonight: #{@humidity_array[2]}."
    end

    def rainboots
        if @today_cond.downcase.include?('t-storms') || @today_cond.downcase.include?('snow') || @today_cond.downcase.include?('flurries') || @today_cond.downcase.include?('sleet') || @today_cond.downcase.include?('slush') || @today_cond.downcase.include?('wintry mix')
            "Wear your rainboots today.  "
        end
    end

    def find_humidity
        @humidity_array = []
        @weather.css("div.wx-data-part").each do |condition|
            if condition.css(".wx-label").text.include?('Humidity')
                @humidity_array << condition.css(".wx-data").text.gsub("%", "% ").strip
            end
        end
    end

    def find_rainchance
        @rain_array = []
        @weather.css("div.wx-data-part").each do |condition|
            if condition.css(".wx-label").text.include?('Chance of')
                @rain_array << condition.css(".wx-data").text.strip
            end

        end
    end
end

    #3 columns: weather.css("div#wx-forecast-container div.wx-today.wx-module.wx-grid3of6")
    #titles: weather.css("div.wx-timepart-title").children[2, 3].text.gsub(/\s+/, " ").strip
    #temperatures: weather.css("div.wx-temperature").children[2, 4].text.gsub("°", "° ").strip.split
    #conditions: weather.css("div.wx-data-part div.wx-phrase").children[1, 2].text
    #chance of rain: weather.css("div.wx-data-part div.wx-data").children[1..4].text.gsub("%", "% ").strip
    #humidity: weather.css("div.wx-data-part div.wx-data").children[23..24].text.gsub("%", "% ").strip
    #UV index: weather.css("div.wx-data-part div.wx-data").children[26].text
    #chance of rain vs. snow: weather.css("div.wx-data-part h6.wx-label span.wx-firstletter").text.gsub("n", "n ").strip.split