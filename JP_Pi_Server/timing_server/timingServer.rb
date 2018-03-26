require 'socket'

class TimingServer

  @@BPM = 60.0
  @@beatboard = [
    [1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0],
    [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
    [1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0],
    [1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0]
  ]

  def initialize
    create_instruments
  end

  def create_instruments
    @instruments = @@beatboard.each_with_index.map do |timing_data, i|
      new BeatTimer timing_data, 2000+i
    end
  end

  def run_loop
    while true
      @instruments.each{ |instrument| instrument.play_note }
      sleep @@BPM/60.0
    end
  end


end
