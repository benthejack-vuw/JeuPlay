class TimingConnection

  @@delegate_error = "TimingConnection's delegate must implement a timed_event method"
  LISTEN_DELAY = 1.0/100.0 #50th of a second

  def initialize delegate, port
    @delegate = delegate
    @port = port
    raise @@delegate_error unless @delegate.respond_to? "timed_event"
  end

  def connect
    puts "connecting to timing  server"
		begin
      @socket = UDPSocket.new
      @socket.bind("0.0.0.0", @port)
		rescue
		end
		puts "connected to timing server"
    return true
  end

  def listen
      begin
        text = @socket.recvfrom(16)
        @delegate.timed_event if text[0].include? "bang"
    		sleep LISTEN_DELAY
      rescue
        @socket.close
        @socket = nil
        connect
      end

      false #return false runs forever if used in block_loop - OWL.rb
  end

end
