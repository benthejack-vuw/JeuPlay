class ChannelSubscriber

  DELEGATE_ERROR = "ChannelSubscriber's delegate must implement a timed_event method"
  LOOP_DELAY = 1.0/100.0 #50th of a second

  def initialize delegate, port
    @delegate = delegate
    @port = port
    raise @@delegate_error unless @delegate.respond_to? "timed_event"
  end

  def connect
		begin
      @socket = UDPSocket.new
      @socket.bind("0.0.0.0", @port)
		rescue
		end
		puts "listening on port #{@port}"
  end

  def listen

      begin
        text = @socket.recvfrom(10)
        @delegate.timed_event if text[0] == '!'
    		sleep LOOP_DELAY
      rescue
      end

      false #return false runs forever if used in block_loop - OWL.rb
  end

end
