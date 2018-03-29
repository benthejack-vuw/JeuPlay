require_relative "aplay"
require_relative "raspiInstrument"

class TestInstrument < RaspiInstrument

  def initialize num
    super num
    @count = 0
    @beat = 0;
    connect_to_timing_server
    create_pipe
    run

  end

  def run
    while true
      @channel_sub.listen
      sleep 0.01
    end
  end

  def timed_event
    play(["test", "data"]) if @data.rhythm[@beat] == '1'
		@beat = (@beat+1) % @data.rhythm.length
  end

  def play args
    @pipe.write "./sounds/#{@data.sound}"
  end

end

if __FILE__ == $0

  fork do
      a = Aplay.new
      a.run
  end

	instrument = TestInstrument.new ARGV[0].to_i

end
