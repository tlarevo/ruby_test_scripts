#!/usr/bin/env ruby -wKU

require 'socket'

# Socket.tcp('google.com', 80) do |connection|
# 	connection.write "GET / HTTP/1.1\r\n"
# 	connection.close
# end

# require 'socket'

# TCPSocket.open("www.ruby-lang.org", 80) do |connection|
# 	connection.write "GET / HTTP/1.0\r\nHost: www.ruby-lang.org\r\n\r\n"
# 	puts connection.read
# 	connection.close
# end

 (0..1000).each do |num|
 	puts "request: #{num}"
 	TCPSocket.open("0.0.0.0", 9191)  do |connection|
 		#connection.write "GET / HTTP/1.1\r\n"
 		# p connection.addr(:hostname)
 		connection.puts "GET / HTTP/1.1\r\n"
 		puts connection.gets
 		connection.close
 	end
 end

# socket = TCPSocket.new('localhost', 4481)

# while socket.gets do |message|
# 	puts message
# end

# socket.close


#TCPSocket.open("127.0.0.1", 4881)  do |connection|
#	connection.write "GET / HTTP/1.1\r\n"
#	#p connection.addr(:hostname)
#	puts connection.gets
#	connection.puts "harida?"
#	connection.close
#end


# Socket.tcp("www.ruby-lang.org", 80) {|sock|
#   sock.write "GET / HTTP/1.0\r\nHost: www.ruby-lang.org\r\n\r\n"
#   sock.close_write
#   puts sock.read
# }
