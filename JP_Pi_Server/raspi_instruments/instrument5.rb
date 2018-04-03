require_relative "raspiInstrument"
require_relative "instrument"
require_relative "aplay"


class Instrument1 < RaspiInstrument

  def initialize
    super 0

    @loops  = ["10101010", "11001100", "11101110", "11111111", "10101010", "11001100", "11101110", "11111111"];
    @samples= ["./sounds/5_Drum_Samples/Drum_1.wav", "./sounds/5_Drum_Samples/Drum_2.wav",
    "./sounds/5_Drum_Samples/Drum_3.wav", "./sounds/5_Drum_Samples/Drum_4.wav",
    "./sounds/5_Drum_Samples/Drum_5.wav", "./sounds/5_Drum_Samples/Drum_6.wav",
    "./sounds/5_Drum_Samples/Drum_7.wav", "./sounds/5_Drum_Samples/Drum_8.wav"];

    @player = new Instrument @loops, @samples

    create_pipe
    connect_to_arduino
    connect_to_timing_server
    run
  end

  def play args
    play_list = [
      (args[0] == "UP" || args[0] == "UP_RIGHT" || args[0] == "UP_LEFT"),
      (args[0] == "DOWN" || args[0] == "DOWN_RIGHT" || args[0] == "DOWN_LEFT"),
      (args[1] == "UP" || args[1] == "UP_RIGHT" || args[1] == "UP_LEFT"),
      (args[1] == "DOWN" || args[1] == "DOWN_RIGHT" || args[1] == "DOWN_LEFT"),
      (args[2] == "UP" || args[2] == "UP_RIGHT" || args[2] == "UP_LEFT"),
      (args[2] == "DOWN" || args[2] == "DOWN_RIGHT" || args[2] == "DOWN_LEFT"),
      (args[3] == "UP" || args[3] == "UP_RIGHT" || args[3] == "UP_LEFT"),
      (args[3] == "DOWN" || args[3] == "DOWN_RIGHT" || args[3] == "DOWN_LEFT")
    ]
    @player.run play_list
  end

end



fork do
    a = Aplay.new
    a.run
end

Instrument1.new
