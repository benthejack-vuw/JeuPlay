require 'socket'
require_relative "../config"
require_relative "shouter"

class TimingServer

  BPM     = 240.0
  MINUTE  = 60.0
  DELAY   = 0.05

  def initialize
    Config.setup
    @last_tick = Time.now.to_f
    @delay = MINUTE/BPM
    @shouter = Shouter.new
  end

  def run_loop
    while true
      @shouter.send_message Config::BANG
      sleep(@delay)
    end
  end

end

if __FILE__ == $0
  server = TimingServer.new
  server.run_loop
end
