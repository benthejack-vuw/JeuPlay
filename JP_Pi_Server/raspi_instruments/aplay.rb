require_relative 'pipe'

class Aplay

  def initialize
    @running = true
    @ip = Pipe.new(pipe_file).tap{|p| p.open_for_input }
  end

  def pipe_file
    "Aplay_IN"
  end

  def pipe
    @ip
  end

  def run
    @running = true

    while @running
     x = @ip.read
     Thread.new { %x{aplay --device plughw:CARD=Device,DEV=0 #{x}} } if x
     @running = false if x == "stop"
    end
    shutdown
  end

  def shutdown
    @running = false
    @ip.close
  end

end

# if __FILE__ == $0
#   a = Aplay.new
#   begin
#     t = Thread.new{ |t| a.run }
#     t.join
#     puts "quit"
#   rescue SignalException
#     a.shutdown
#   end
# end
