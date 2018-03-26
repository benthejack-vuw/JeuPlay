require 'socket'
require_relative "../config"
require_relative "metronome"

class TimingServer

  BPM = 120.0

  def initialize
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
      @metronomes.each{ |metronome| metronome.tick }
      sleep 60.0/BPM
    end
  end

end

if __FILE__ == $0
  server = TimingServer.new
  server.run_loop
end
