require_relative "pipe"
class AplayTest

  def initialize
    @running = true
    @op = create_pipe
  end

  attr_reader :op

  def create_pipe
    # %x{ rm "#{self.class.name}_IN.99" } if File.exists?( "#{self.class.name}_IN.99")
    Pipe.new("Aplay_IN.99").tap{|p| p.open_for_output }
  end

end

if __FILE__ == $0
  ap = AplayTest.new
  5.times do
    ap.op.write "hey there"
  end
  # ap.op.write "stop"
  5.times do
    ap.op.write "stopped now"
  end
end
