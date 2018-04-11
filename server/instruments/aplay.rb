require_relative 'pipe'

class Aplay

  def initialize file_name
    @running = true
    @ip = Pipe.new(file_name).tap{|p| p.open_for_input }
  end

  def pipe
    @ip
  end

  def run
    @running = true

    while @running
     x = @ip.read
     Thread.new { %x{aplay #{x}} } if x
     @running = false if x == "stop"
    end
    shutdown
  end

  def shutdown
    @running = false
    @ip.close
  end

end
