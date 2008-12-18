require 'open3'

module OsInfo
  class Macintosh < OsInfo::Unix
  attr_reader :version, :build
    def initialize
      super

      @version = `sw_vers -productVersion`.chop
      @build   = `sw_vers -buildVersion`.chop

      # /usr/bin/scselect
      # tells us all about Network Locations
      @network_locations = Array.new
      networklocs = Open3.popen3('scselect')[2].readlines()
      networklocs[1..-1].each {|networkloc|
	nlo = NetworkLocation.new
	nlo.name = networkloc.last.split('')[1..-2]
	nlo.id = networkloc[-2]
	@network_locations << nlo
	if networkloc.split.first == "*"
	  @current_network_location = nlo
	end
      }
    end
  end

  class NetworkLocation
    attr_accessor :name, :id
  end
end
