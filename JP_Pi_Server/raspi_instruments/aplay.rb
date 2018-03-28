require_relative 'pipe'

class Aplay
  
  def initialize
    @running = true
    @ip = create_pipe
  end
  
  def run
    @running = true
    while @running
     x = @ip.read.chomp
     %x{afplay #{x}}
     @running = false if x == "stop"
    end
    shutdown
  end
  
  def shutdown
    @ip.close
  end
  
  def create_pipe
    %x{ rm "#{self.class.name}_IN" } if File.exists?( "#{self.class.name}_IN.99")
    Pipe.new("#{self.class.name}_IN").tap{|p| p.open_for_input }
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