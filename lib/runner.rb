require_relative 'geo'
require_relative 'sun'
require_relative 'weather'

module Sunweather
	class Runner

		def initialize
		end

		def run
			@geo = (ARGV[0] ? Geo.new(ARGV[0]) : Geo.new)
			@sun = Sun.new(@geo.lat, @geo.lng)
			@weather = Weather.new(@geo.lat, @geo.lng)
			puts "Dawn from #{hours_minutes(@sun.start_of_dawn)} to #{hours_minutes(@sun.sunrise)}."
			puts "Dusk from #{hours_minutes(@sun.sunset)} to #{hours_minutes(@sun.end_of_dusk)}."
			puts "Temperature: #{@weather.temperature}°C, feels like #{@weather.feels_like}°C."
			puts "Weather: #{@weather.conditions}, Winds #{@weather.wind_speed.downcase}, direction #{@weather.wind_direction}."
		end

		def hours_minutes time
			%-#{time.hour}:#{"%02i" % (time.min+time.sec/30)}-
		end
	end
end