INSTRUMENT = 5

require_relative "instrument"

controls = lambda do |args|
  [
    (args[0] == "UP" || args[0] == "UP_RIGHT" || args[0] == "UP_LEFT"),
    (args[0] == "DOWN" || args[0] == "DOWN_RIGHT" || args[0] == "DOWN_LEFT"),
    (args[1] == "UP" || args[1] == "UP_RIGHT" || args[1] == "UP_LEFT"),
    (args[1] == "DOWN" || args[1] == "DOWN_RIGHT" || args[1] == "DOWN_LEFT"),
    (args[2] == "UP" || args[2] == "UP_RIGHT" || args[2] == "UP_LEFT"),
    (args[2] == "DOWN" || args[2] == "DOWN_RIGHT" || args[2] == "DOWN_LEFT"),
    (args[3] == "UP" || args[3] == "UP_RIGHT" || args[3] == "UP_LEFT"),
    (args[3] == "DOWN" || args[3] == "DOWN_RIGHT" || args[3] == "DOWN_LEFT")
  ]
end

loops = ["1001", "10101011", "100011001000110", "0101010001010100", "1110111010101110", "1011010010110100", "1010101010101110", "1000"];

Instrument.new (INSTRUMENT-1), loops, controls
