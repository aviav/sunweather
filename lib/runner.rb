require_relative 'geo'
require_relative 'data'

module Sunweather
	class Runner

		def initialize
		end

		def data
			@geo = (ARGV[0] ? Geo.new(ARGV[0]) : Geo.new)
			@data = Data.new(@geo.lat, @geo.lng)
			"Dawn from #{hours_minutes(@data.start_of_dawn)} to #{hours_minutes(@data.sunrise)}.\nDusk from #{hours_minutes(@data.sunset)} to #{hours_minutes(@data.end_of_dusk)}.\nTemperature: #{@data.temperature}°C, feels like #{@data.feels_like}°C.\nWeather: #{@data.conditions}, Winds #{@data.wind_speed.downcase}, direction #{@data.wind_direction}.\n"
		end

		def run
			puts data
		end

		def hours_minutes time
			%-#{time.hour}:#{"%02i" % (time.min+time.sec/30)}-
		end
	end
end