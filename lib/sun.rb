require 'xmlsimple'
require 'open-uri'
require 'awesome_print'
require 'date'

module Sunweather
	class Sun
		attr_reader :data_sunrise_sunset, :data_twilight

		def initialize lat, lng
			file = open("http://api.wunderground.com/api/#{ENV["SUNWEATHER_DEV_WUNDERGROUND_API"]}/astronomy/q/#{lat},#{lng}.xml")
			@data_sunrise_sunset = XmlSimple.xml_in(file)
			file = open("http://www.earthtools.org/sun/#{lat}/#{lng}/#{Time.now.mday}/#{Time.now.mon}/99/0")
			@data_twilight = XmlSimple.xml_in(file)
		end

		def sunrise
			Time.new(1970,1,1,self.data_sunrise_sunset["sun_phase"][0]["sunrise"][0]["hour"][0],self.data_sunrise_sunset["sun_phase"][0]["sunrise"][0]["minute"][0])
		end

		def sunset
			Time.new(1970,1,1,self.data_sunrise_sunset["sun_phase"][0]["sunset"][0]["hour"][0],self.data_sunrise_sunset["sun_phase"][0]["sunset"][0]["minute"][0])
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
	end
end