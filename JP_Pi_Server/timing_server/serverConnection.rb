class ServerConnection

  def initialize port
    @port = port
  end

  def connect
    Thread.new do
      puts "waiting for connection from client on port: #{@port}"
      @server = TCPServer.new @port
      @client = @server.accept
      puts "connected to client on port: #{@port}"
    end
  end

  def connected
    return @client
  end

  def send_message message
    begin
      @client.puts message
    rescue Errno::EPIPE
      @server.close
      @client = nil
      connect
    end
  end

end
