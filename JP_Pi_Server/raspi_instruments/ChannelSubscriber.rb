class ChannelSubscriber

  DELEGATE_ERROR = "ChannelSubscriber's delegate must implement a timed_event method"
  LOOP_DELAY = 1.0/500.0 #50th of a second

  def initialize delegate
    @delegate = delegate
    raise @@delegate_error unless @delegate.respond_to? "timed_event"
    @port = Config::SERVER[:port]
  end

  def connect
		begin
      @socket = UDPSocket.new
      @socket.bind('0.0.0.0', @port)
      puts "stuff & #{@socket.addr}"
		end
		puts "listening to #{Config::SERVER[:ip]} on port #{Config::SERVER[:port]}"
  end

  def listen
      begin
          text, sender = @socket.recvfrom(16)
          @delegate.timed_event if text.include?(Config::BANG)
    		  sleep LOOP_DELAY
      end
      false #return false runs forever if used in block_loop - OWL.rb
  end

end
