require_relative "instrument"

controls = lambda do |args|
  [
    (args[0] == "LEFT" && args[1] == "RIGHT"),
    (args[0] == "RIGHT" && args[1] == "LEFT")
  ]
end

loops = ["1000000000000000", "1000000000000000"]

Instrument.new 1, loops, controls
