require_relative "instrument"

INSTRUMENT = 4

controls = lambda do |args|
  [
    (args[0] == "UP"),
    (args[0] == "DOWN")
  ]
end

loops = ["11111111111111111111111111111111", "11111111111111111111111111111111"]

Instrument.new 3, loops, controls
