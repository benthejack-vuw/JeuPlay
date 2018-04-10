INSTRUMENT = 5

require_relative "instrument"

controls = lambda do |args|
  [
    (args[0] == "UP"),
    (args[0] == "DOWN"),
    (args[1] == "UP"),
    (args[1] == "DOWN"),
    (args[2] == "UP"),
    (args[2] == "DOWN"),
    (args[3] == "UP"),
    (args[3] == "DOWN")
  ]
end

loops = ["11111111", "11111111", "11111111", "11111111", "11111111", "11111111", "11111111", "11111111"];

Instrument.new (INSTRUMENT-1), loops, controls
