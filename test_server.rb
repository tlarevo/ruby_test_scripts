#!/usr/bin/env ruby
require 'socket'

# server = TCPServer.new("127.0.0.1", 2000) # Server bound to port 2000

# loop do
#   client = server.accept    # Wait for a client to connect
#   client.write "Hello !\n"
#   client.write "Time is #{Time.now} \n"
#   client.close
# end

# server = ServerSocket.new(:INET, :STREAM)
# addr = ServerSocket.pack_sockaddr_in(4484, '0.0.0.0')
# server.bind(addr, 5)

# loop do
# 	connection, _ = server.accept

# 	puts "#======================Start=======================#"

# 	print "Connection class:"
# 	p connection.class

# 	print "Server fileno:"
# 	p server.fileno

# 	print "Connection.fileno:"
# 	p connection.fileno

# 	print "Connection local address:"
# 	p connection.local_address

# 	print "Connenction remote address"
# 	p connection.remote_address

# 	print "I dont know what this is: "
# 	p _

# 	connection.puts "Ai yai yooooo..."

# 	puts "#======================End=========================#"

# 	connection.close
# end

# server = TCPServer.new(4481)

# Socket.accept_loop(server) do | connection |

# 	request = Thread.start do
# 		puts "#======================Start=======================#"

# 		print "Connection class:"
# 		p connection.class

# 		print "Server fileno:"
# 		p server.fileno

# 		print "Connection.fileno:"
# 		p connection.fileno

# 		print "Connection local address:"
# 		p connection.local_address

# 		print "Connenction remote address"
# 		p connection.remote_address

# 		connection.puts "Ela kiri"
# 		puts connection.read

# 		puts "#======================End=========================#"

# 		connection.close
# 	end

# 	request.join
# end

server = TCPServer.new(4481)


#server = Socket.tcp_server_sockets(4481)
unless server.nil?
	puts "Server is listening..."
end

Socket.accept_loop(server) do | connection |

	request = Thread.start do
		puts "#======================Start=======================#"

		# puts connection.gets
		while data = connection.gets
			puts data
		end


		connection.puts "Ela kiri"
		connection.close

		puts "#======================End=========================#"

	end

	request.join
end

