require_relative "instrument"

controls = lambda do |args|
  [
    (args[0] == "LEFT" && args[1] == "RIGHT"),
    (args[0] == "RIGHT" && args[1] == "LEFT"),
    (args[0] == "LEFT" && (args[1] == "MIDDLE" || args[1] == "LEFT")),
    (args[1] == "RIGHT" && (args[0] == "MIDDLE" || args[0] == "RIGHT"))
  ]
end

loops = ["1111111111111111", "1111111111111111", "1111111111111111", "1111111111111111"]

Instrument.new 0, loops, controls
