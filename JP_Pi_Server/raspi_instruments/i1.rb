require_relative "instrument"

def controls args
  [
    (args[0] == "LEFT" && args[1] == "RIGHT"),
    (args[0] == "RIGHT" && args[1] == "LEFT"),
    (args[0] == "LEFT" && (args[1] == "MIDDLE" || args[1] == "LEFT")),
    (args[1] == "RIGHT" && (args[0] == "MIDDLE" || args[0] == "RIGHT"))
  ]
end

loops = ["1000000000000000", "1000000000000000", "1000000000000000", "1000000000000000"]

Instrument.new 0, loops, controls
