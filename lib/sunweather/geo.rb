require 'geocoder'

module Sunweather
	class Geo
		attr_reader :data

		def initialize (request = ENV["FREEFORM_ADDRESS_QUERY"])
			@data = Geocoder.search(request)
		end

		def lat
			@data[0].data["geometry"]["location"]["lat"]
		end

		def lng
			@data[0].data["geometry"]["location"]["lng"]
		end
	end
end