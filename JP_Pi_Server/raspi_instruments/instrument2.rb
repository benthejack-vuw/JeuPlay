require_relative "raspiInstrument"

class Instrument2 < RaspiInstrument

  def initialize
    super 1
    @count = 0
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
    play ["test", "data"]
  end

  def play args
    `aplay ./sounds/#{@metro.sound}`
  end

end

Instrument2.new
