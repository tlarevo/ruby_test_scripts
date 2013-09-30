#!/usr/bin/env ruby

require 'rubygems'
require 'socket'
require "benchmark"

@requests = 10000

@socket = TCPSocket.new("127.0.0.1", 9191)

start_time = Time.now

time_elapsed = Benchmark.realtime do
  (0..(@requests - 1)).each do |i|
    @socket.puts("0777304704,#{i},balx")
    # @socket.write("test text")
    @socket.readpartial(4096)
  end
	@socket.close
end

puts "Total time for #{@requests} Requests: #{time_elapsed} seconds"
puts "#{(@requests)/time_elapsed} requests per second"


