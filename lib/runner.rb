require_relative 'geo'

module Sunweather
	class Runner

		def initialize
		end

		def run
			@geo = (ARGV[0] ? Geo.new(ARGV[0]) : Geo.new)
			puts @geo.lat
			puts @geo.lng
		end
	end
end