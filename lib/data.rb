require 'xmlsimple'
require 'open-uri'
require 'date'

module Sunweather
	class Data
		attr_reader :data_astro_conditions, :data_forecast, :data_twilight

		def initialize lat, lng
			file = open("http://api.wunderground.com/api/#{ENV["SUNWEATHER_DEV_WUNDERGROUND_API"]}/astronomy/conditions/q/#{lat},#{lng}.xml")
			@data_astro_conditions = XmlSimple.xml_in(file)
			file = open("http://api.worldweatheronline.com/free/v1/weather.ashx?q=#{lat},#{lng}&format=xml&extra=localObsTime&num_of_days=5&includelocation=yes&key=#{ENV['SUNWEATHER_DEV_WWO_API']}")
			@data_forecast = XmlSimple.xml_in(file)
			file = open("http://www.earthtools.org/sun/#{lat}/#{lng}/#{Time.now.mday}/#{Time.now.mon}/99/0")
			@data_twilight = XmlSimple.xml_in(file)
		end

		def temperature
			Float(self.data_astro_conditions["current_observation"][0]["temp_c"][0])
		end

		def feels_like
			Float(self.data_astro_conditions["current_observation"][0]["feelslike_c"][0])
		end

		def observation_time
			Time.at(Integer(self.data_astro_conditions["current_observation"][0]["observation_epoch"][0]))
		end

		def conditions
			self.data_astro_conditions["current_observation"][0]["weather"][0]
		end

		def wind_speed
			self.data_astro_conditions["current_observation"][0]["wind_string"][0]
		end

		def wind_direction
			self.data_astro_conditions["current_observation"][0]["wind_dir"][0]
		end

		def sunrise
			Time.new(1970,1,1,self.data_astro_conditions["sun_phase"][0]["sunrise"][0]["hour"][0],self.data_astro_conditions["sun_phase"][0]["sunrise"][0]["minute"][0])
		end

		def sunset
			Time.new(1970,1,1,self.data_astro_conditions["sun_phase"][0]["sunset"][0]["hour"][0],self.data_astro_conditions["sun_phase"][0]["sunset"][0]["minute"][0])
		end

		def sunrise_earthtools
			DateTime.parse(self.data_twilight["morning"][0]["sunrise"][0]).to_time
		end

		def sunset_earthtools
			DateTime.parse(self.data_twilight["evening"][0]["sunset"][0]).to_time
		end

		def start_of_dawn_earthtools
			DateTime.parse(self.data_twilight["morning"][0]["twilight"][0]["civil"][0]).to_time
		end

		def end_of_dusk_earthtools
			DateTime.parse(self.data_twilight["evening"][0]["twilight"][0]["civil"][0]).to_time
		end

		def dawn_length
			Time.at(self.sunrise_earthtools - self.start_of_dawn_earthtools)
		end

		def dusk_length
			Time.at(self.end_of_dusk_earthtools - self.sunset_earthtools)
		end

		def start_of_dawn
			Time.at(self.sunrise - self.dawn_length)
		end

		def end_of_dusk
			Time.at(self.sunset.to_i + self.dawn_length.to_i)
		end

		def hours_minutes time
			"#{time.hour}:#{time.minute+time.second/30}"
		end
	end
end