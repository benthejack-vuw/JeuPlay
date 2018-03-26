class ServerConnection

  def initialize ip, port
    @ip = ip
    @port = port
  end

  def connect_TCP
    Thread.new do
      puts "waiting for connection from client on port: #{@port}"
      @server = TCPServer.new @port
      @client = @server.accept
      puts "connected to client on port: #{@port}"
    end
  end

  def connect_UDP
      @server = UDPSocket.new
      @server.connect(@ip, @port)
  end

  def connected
    #return @client
    true
  end

  def send_message message
    begin
      #@client.puts message
      @server.send "message", 0
    rescue Errno::EPIPE
      #@server.close
      #@client = nil
      #connect
    end
  end

end
