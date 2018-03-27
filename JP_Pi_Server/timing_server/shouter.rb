class Shouter

  def initialize port
    @ip = '<broadcast>'
    @port = port
  end

  def start
    @server = UDPSocket.new
    @server.setsockopt(Socket::SOL_SOCKET, Socket::SO_BROADCAST, true)
  end

  def send_message message
    @server.send message, 0, @ip, @port
  end

end
