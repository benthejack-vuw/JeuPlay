require 'socket'
require_relative "../config"
require_relative "metronome"

class TimingServer

  BPM = 120.0

  def initialize
    @last_tick = Time.now.to_f
    @delay = 60.0/BPM
    Config.setup
    create_instruments
  end

  def create_instruments
    @metronomes = Config.metronomes.each_with_index.map do |metro_data, i|
        Metronome.new metro_data
    end
  end

  def run_loop
    while true
      t = Time.now.to_f
      if t - @last_tick > @delay
        @metronomes.each{ |metronome| metronome.tick }
        @last_tick = t
      end
      sleep 0.001
    end
  end

end

if __FILE__ == $0
  server = TimingServer.new
  server.run_loop
end
