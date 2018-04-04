require 'socket'
require_relative "../config"
require_relative "shouter"

class TimingServer

  BPM     = 120.0
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
      start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      @shouter.send_message Config::BANG
      sleep(@delay-(Process.clock_gettime(Process::CLOCK_MONOTONIC)-start))
    end
  end

end

if __FILE__ == $0
  server = TimingServer.new
  server.run_loop
end
