require_relative "raspiInstrument"

class Instrument1 < RaspiInstrument

  def initialize
    super 0
    connect_to_arduino
    connect_to_timing_server
    run
  end

  def play args
    puts "bing(1): #{args[0]} #{args[1]}"
    #raise 'over-ride this method in child class'
  end

end

Instrument1.new
