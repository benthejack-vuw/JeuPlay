class ChannelSubscriber

  DELEGATE_ERROR = "ChannelSubscriber's delegate must implement a timed_event method"
  LOOP_DELAY = 1.0/500.0 #50th of a second

  def initialize delegate
    @delegate = delegate
    raise @@delegate_error unless @delegate.respond_to? "timed_event"
  end

  def connect
		begin
      @socket = UDPSocket.new
      @socket.bind("0.0.0.0", Config::SERVER.port)
		rescue
		end
		puts "listening to #{Config::SERVER[:ip]} on port #{Config::SERVER[:port]}"
  end

  def listen

      begin
        text = @socket.recvfrom(16)
        puts text
        @delegate.timed_event if text[0].include?(Config::BANG)
    		sleep LOOP_DELAY
      rescue
      end

      false #return false runs forever if used in block_loop - OWL.rb
  end

end
