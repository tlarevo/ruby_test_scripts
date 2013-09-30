#!/usr/bin/env ruby -wKU
require 'socket'

import java.util.concurrent.Executors
import java.util.concurrent.atomic.AtomicInteger

executor = Executors.new_cached_thread_pool


server = TCPServer.new('0.0.0.0', 9191);

puts "server is listening"

def handle_connection(executor, connection)
    begin
        executor.execute do
            begin
                puts "##======received connection from #{connection.remote_address}======##"
                while data = connection.read_nonblock(4096)
                    connection.puts "0"
                    puts data
                end
            rescue Errno::EAGAIN
                IO.select([connection])
                retry
            rescue EOFError
                puts "##======Connection closed from #{connection.remote_address}======##"
                connection.close
            end
        end
    rescue  IOException => error
        puts "error: #{error}"
        executor.shutdown
    end
end

loop do
    handle_connection(executor,server.accept)
end

