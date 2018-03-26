class ServerConnection

  def initialize port
    @port = port
    connection_loop
  end

  def connection_loop
    @server = TCPServer.new @port
    @client = server.accept
  end

  def send_message message
    @client.puts message
  end

end
