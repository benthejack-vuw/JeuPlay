class Channel

  def initialize ip, port
    @ip = ip
    @port = port
  end

  def start
    @server = UDPSocket.new
  end

  def send_message message
    begin
      @server.send message, 0, @ip, @port
    rescue Errno::ECONNREFUSED
      #catches if client isn't connected
    end
  end

end
