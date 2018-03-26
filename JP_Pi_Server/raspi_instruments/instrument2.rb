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
      @timing_connection.listen
      sleep 0.001
    end
  end

  def timed_event
    play ["test", "data"]
  end

  def play args
    puts "bong(2): #{args[0]} : #{args[1]} : #{@count}"
    @count += 1
    #raise 'over-ride this method in child class'
  end

end

Instrument2.new
