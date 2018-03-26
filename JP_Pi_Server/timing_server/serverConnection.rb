class ServerConnection

  def initialize port
    @port = port
    connection_loop
  end

  def connection_loop
    puts "connecting to client"
    @server = TCPServer.new @port
    @client = @server.accept
    puts "connected to client"
  end

  def send_message message
    @client.puts message
  end

end
