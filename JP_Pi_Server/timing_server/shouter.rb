class Shouter

  def initialize
    @ip = Config::SERVER[:ip]
    @port = Config::SERVER[:port]
    start
  end

  def start
    @server = UDPSocket.open
    @server.setsockopt(Socket::IPPROTO_IP, Socket::IP_TTL, [1].pack('i'))
  end

  def send_message message
    @server.send message, 0, @ip, @port
  end

end
