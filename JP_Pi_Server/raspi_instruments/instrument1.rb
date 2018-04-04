require_relative "raspiInstrument"
require_relative "instrument"
require_relative "aplay"


class Instrument1 < RaspiInstrument

  def initialize
    super 0
    @loops  = ["1000000000000000", "1000000000000000", "1000000000000000", "1000000000000000"];
    create_pipe
    connect_to_arduino
    connect_to_timing_server
    @player = Instrument.new @loops, @samples, @pipe

    run
  end

  def play args

    p args

    play_list = [
      (args[0] == "LEFT" && args[1] == "RIGHT"),
      (args[0] == "RIGHT" && args[1] == "LEFT"),
      (args[0] == "LEFT" && (args[1] == "MIDDLE" || args[1] == "LEFT")),
      (args[1] == "RIGHT" && (args[0] == "MIDDLE" || args[0] == "RIGHT"))
    ]

    @player.run play_list
  end

end

fork do
    a = Aplay.new
    begin
      a.run
    rescue SignalException
      a.shutdown
    end
end

Instrument1.new
