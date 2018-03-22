require 'socket'

server = TCPServer.new 2000
client = server.accept

while true
  client.puts "bang"
  sleep 1.5
end
