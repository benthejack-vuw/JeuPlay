require 'socket'
require_relative "timedInstrument"

class TimingServer

  BPM = 120.0

  IPS = ["10.0.1.50", "10.0.1.50", "10.0.1.50", "10.0.1.50"]

  BEAT_BOARD = [
    [1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0],
    [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
    [1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0],
    [1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0]
  ]

  def initialize
    create_instruments
  end

  def create_instruments
    @instruments = BEAT_BOARD.each_with_index.map do |timing_data, i|
        TimedInstrument.new timing_data, IPS[i], 2000+i
    end

    @instruments.each do |instrument|
      instrument.connect
    end
  end

  def run_loop
    while true
      @instruments.each{ |instrument| instrument.play_note }
      sleep 60.0/BPM
    end
  end

end

server = TimingServer.new
server.run_loop
