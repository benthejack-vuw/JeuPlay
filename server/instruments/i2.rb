require_relative "instrument"

INSTRUMENT = 2

controls = lambda do |args|
  [
    (args[0] == "DOWN"),
    (args[0] == "LEFT" || args[0] == "DOWN_LEFT")
  ]
end

loops = ["11111111111111111111111111111111", "11111111111111111111111111111111"]

Instrument.new (INSTRUMENT-1), loops, controls
