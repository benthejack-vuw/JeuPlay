class TimingConnection

  @@delegate_error = "TimingConnection's delegate must implement a timed_event method"
  LISTEN_DELAY = 1.0/100.0 #50th of a second

  def initialize delegate, ip, port
    @delegate = delegate
    @ip = ip
    @port = port
    raise @@delegate_error unless @delegate.respond_to? "timed_event"
  end

  def connect
    puts "waiting for timing  server"
		begin
			@socket = TCPSocket.new @ip, @port
		rescue
			@socket = false
      sleep 1.0/10.0
		end until @socket
		puts "connected to timing server"
    return true
  end

  def listen
      begin
        text = @socket.gets
        puts text
        @delegate.timed_event if text.include? "bang"
    		sleep LISTEN_DELAY
      rescue
        @socket.close
        @socket = nil
        connect
      end
      
      false #return false runs forever if used in block_loop - OWL.rb
  end

end
