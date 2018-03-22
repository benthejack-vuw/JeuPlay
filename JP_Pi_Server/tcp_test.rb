require 'socket'

# beatboard = [
#   [1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0],
#   [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
#   [1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0],
#   [1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0]
# ]


server = TCPServer.new 2000
client = server.accept

while true
  client.puts "bang"
  sleep 1.5
end
