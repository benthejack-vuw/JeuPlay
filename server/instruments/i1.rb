require_relative "instrument"

INSTRUMENT = 1

controls = lambda do |args|
  [
    (args[0] == "UP" && args[1] == "RIGHT"),
    (args[0] == "DOWN" && args[1] == "LEFT"),
    (args[0] == "UP" && (args[1] == "MIDDLE" || args[1] == "LEFT")),
    (args[1] == "RIGHT" && (args[0] == "MIDDLE" || args[0] == "DOWN"))
  ]
end

loops = ["1111111111111111", "1111111111111111", "1111111111111111", "1111111111111111"]

Instrument.new (INSTRUMENT-1), loops, controls
