require 'socket'
require_relative "../config"
require_relative "shouter"

class TimingServer

  BPM     = 480.0
  MINUTE  = 60.0
  DELAY   = 0.05

  def initialize
    Config.setup
    @last_tick = Time.now.to_f
    @delay = MINUTE/BPM
    @shouter = Shouter.new Config.metronomes.first.port
    @shouter.start
  end

  def run_loop
    t = 0.0           # no Garbage collection
    while true
      t = Time.now.to_f
      if ( t - @last_tick ) > @delay
        @shouter.send_message Config::BANG
        @last_tick = t
      end
      sleep( ( t + DELAY ) - Time.now.to_f )
    end
  end

end

if __FILE__ == $0
  server = TimingServer.new
  server.run_loop
end
