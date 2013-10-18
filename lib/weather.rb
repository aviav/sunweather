require 'xmlsimple'
require 'open-uri'

module Sunweather
	class Weather
		attr_reader :data_current, :data_forecast

		def initialize lat, lng
			file = open("http://api.wunderground.com/api/#{ENV["SUNWEATHER_DEV_WUNDERGROUND_API"]}/conditions/q/#{lat},#{lng}.xml")
			@data_current = XmlSimple.xml_in(file)
			file = open("http://api.worldweatheronline.com/free/v1/weather.ashx?q=#{lat},#{lng}&format=xml&extra=localObsTime&num_of_days=5&includelocation=yes&key=#{ENV['SUNWEATHER_DEV_WWO_API']}")
			@data_forecast = XmlSimple.xml_in(file)
		end

		def temperature
			Float(self.data_current["current_observation"][0]["temp_c"][0])
		end

		def feels_like
			Float(self.data_current["current_observation"][0]["feelslike_c"][0])
		end

		def observation_time
			Time.at(Integer(self.data_current["current_observation"][0]["observation_epoch"][0]))
		end

		def conditions
			self.data_current["current_observation"][0]["weather"][0]
		end

		def wind_speed
			self.data_current["current_observation"][0]["wind_string"][0]
		end

		def wind_direction
			self.data_current["current_observation"][0]["wind_dir"][0]
		end
	end
end