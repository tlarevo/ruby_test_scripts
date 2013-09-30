#!/usr/bin/env ruby
require 'socket'

# s = TCPSocket.new 'localhost', 4481

# while line = s.read # Read lines from socket
#   print line         # and print them
# end

# s.close   

socket = Socket.new(:INET, :STREAM)

remote_addr = Socket.pack_sockaddr_in(4481, 'localhost')

socket.connect(remote_addr)

while line = socket.read
	print line
end

socket.close