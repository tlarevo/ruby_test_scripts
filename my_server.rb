#!/usr/bin/env ruby -wKU

require 'gserver'

#
# A server that returns the time in seconds since 1970.
#
class TimeServer < GServer
  def initialize(port=4881, *args)
    super(port, *args)
  end
  def serve(io)
#  	request = Thread.start do |io|
    	puts(Time.now.to_s)
	puts io.gets
#  	end
#  	request.join
#  	sleep(5)
  end
end

# Run the server with logging enabled (it's a separate thread).
server = TimeServer.new
server.audit = true                  # Turn logging on.
server.start

server.join

# *** Now point your browser to http://localhost:10001 to see it working ***

# See if it's still running.
puts GServer.in_service?(10001)           # -> true
server.stopped? 
