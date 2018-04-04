require_relative "instrument"

controls = lambda do |args|
  [
    (args[0] == "UP"),
    (args[0] == "DOWN")
  ]
end

loops = ["10001000", "10001000"]

Instrument.new 3, loops, controls
