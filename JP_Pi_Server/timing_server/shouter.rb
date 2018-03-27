class Shouter

  def initialize
    @ip = Config::SERVER[:ip]
    @port = Config::SERVER[:port]
    start
  end

  def start
    @server = UDPSocket.open
    @server.setsockopt(Socket::SOL_SOCKET, Socket::SO_BROADCAST, true)
  end

  def send_message message
    @server.send message, 0, @ip, @port
  end

end
