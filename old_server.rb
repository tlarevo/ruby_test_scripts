require 'socket'

class TriggerListener
  
  include TorqueBox::Injectors

  def initialize(options={})
    @done = false
    @opts = options
    @publish_pool = @opts[:publish_pool]
    @rtbs_triggers_queue = fetch('/queues/rtbs_triggers_queue')
    puts "#========= STARTING: Unprocessed messages in the rtbs_triggers_queue: #{@rtbs_triggers_queue.count_messages} ===========#"
  end

  def start
    puts "#==========# STARTING: RTBS Traps Listener on #{@opts[:host]}:#{@opts[:port]} at #{Time.now} #==========#"
    @server = TCPServer.new(@opts[:host], @opts[:port])

    Thread.abort_on_exception = true
    @thread = Thread.new do
      begin
        puts "new thread started"
        handle_connection(@server.accept)
      end until @done
    end
  end

  def stop
    puts "#==========# STOPPING: RTBS Traps Listener - Bye-Bye : #{Time.now} #==========#"
    @done = true
    @server.close if @server
    @thread.join
  end

  def handle_connection(socket)
    _, port, host = socket.peeraddr
    puts "#==========# RTBS Traps Listener: Received connection from #{host}:#{port} at #{Time.now} #==========#"
    loop {
      data = socket.readpartial(4096)
      socket.write "0"
      @publish_pool.async.publish_to_queue(:data => data, :queue => @rtbs_triggers_queue)
    }
  rescue Errno::EAGAIN
    IO.select([socket])
  rescue EOFError
    socket.close
    puts "#==========# RTBS Traps Listener: #{host}:#{port} Disconnected #==========#"
  end
end