class Shouter

  def initialize
    @ip = '<broadcast>'
    @port = Config::SERVER[:port]
    start
  end

  def start
    @server = UDPSocket.new
    @server.setsockopt(Socket::SOL_SOCKET, Socket::SO_BROADCAST, true)
  end

  def send_message message
    puts "#{message} to: #{@ip}, #{@port}"
    @server.send( message, 0, @ip, @port )
  end

end
