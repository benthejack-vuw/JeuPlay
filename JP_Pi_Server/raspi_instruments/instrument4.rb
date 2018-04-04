require_relative "raspiInstrument"
require_relative "instrument"
require_relative "aplay"


class Instrument1 < RaspiInstrument

  def initialize
    super 0

    @loops  = ["10001000", "10001000"];
    @samples= ["./sounds/2_Weird/Weird_1.wav", "./sounds/2_Weird/Weird_2.wav"];
    @player = new Instrument @loops, @samples

    create_pipe
    connect_to_arduino
    connect_to_timing_server
    run
  end

  def play args

    play_list = [
      (args[0] == "UP"),
      (args[0] == "DOWN")
    ]

    @player.run play_list
  end

end

fork do
    a = Aplay.new
    a.run
end

Instrument1.new
