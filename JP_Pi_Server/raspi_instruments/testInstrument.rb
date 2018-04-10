require_relative "raspiInstrument"

class TestInstrument < Instrument

  def initialize num
    super num
    connect_to_timing_server
    run
  end

  def run
    while true
      @channel_sub.listen
      sleep 0.01
    end
  end

  def timed_event
    play(["test", "data"])
  end

  def play args
    p args
  end

end


controls = lambda do |args|
  [
    (args[0] == "UP" || args[0] == "UP_RIGHT" || args[0] == "UP_LEFT"),
    (args[0] == "DOWN" || args[0] == "DOWN_RIGHT" || args[0] == "DOWN_LEFT"),
    (args[1] == "UP" || args[1] == "UP_RIGHT" || args[1] == "UP_LEFT"),
    (args[1] == "DOWN" || args[1] == "DOWN_RIGHT" || args[1] == "DOWN_LEFT"),
    (args[2] == "UP" || args[2] == "UP_RIGHT" || args[2] == "UP_LEFT"),
    (args[2] == "DOWN" || args[2] == "DOWN_RIGHT" || args[2] == "DOWN_LEFT"),
    (args[3] == "UP" || args[3] == "UP_RIGHT" || args[3] == "UP_LEFT"),
    (args[3] == "DOWN" || args[3] == "DOWN_RIGHT" || args[3] == "DOWN_LEFT")
  ]
end



if __FILE__ == $0
	instrument = TestInstrument.new ARGV[0].to_i
end
