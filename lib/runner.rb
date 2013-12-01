require_relative 'geo'
require_relative 'data'

module Sunweather
	class Runner

		def initialize
		end

		def run
			@geo = (ARGV[0] ? Geo.new(ARGV[0]) : Geo.new)
			@data = Data.new(@geo.lat, @geo.lng)
			puts "Dawn from #{hours_minutes(@data.start_of_dawn)} to #{hours_minutes(@data.sunrise)}."
			puts "Dusk from #{hours_minutes(@data.sunset)} to #{hours_minutes(@data.end_of_dusk)}."
			puts "Temperature: #{@data.temperature}°C, feels like #{@data.feels_like}°C."
			puts "Weather: #{@data.conditions}, Winds #{@data.wind_speed.downcase}, direction #{@data.wind_direction}."
		end

		def hours_minutes time
			%-#{time.hour}:#{"%02i" % (time.min+time.sec/30)}-
		end
	end
end