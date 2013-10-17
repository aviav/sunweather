require_relative 'geo'
require_relative 'sun'

module Sunweather
	class Runner

		def initialize
		end

		def run
			@geo = (ARGV[0] ? Geo.new(ARGV[0]) : Geo.new)
			@sun = Sun.new(@geo.lat, @geo.lng)
			puts @sun.start_of_dawn
			puts @sun.sunrise
			puts @sun.sunset
			puts @sun.end_of_dusk
		end
	end
end