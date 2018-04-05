require_relative "instrument"

controls = lambda do |args|
  [
    (args[0] == "LEFT" && args[1] == "RIGHT"),
    (args[0] == "RIGHT" && args[1] == "LEFT")
  ]
end

loops = ["11111111111111111111111111111111", "11111111111111111111111111111111"]

Instrument.new 1, loops, controls
