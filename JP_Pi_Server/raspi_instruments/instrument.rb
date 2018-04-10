require_relative "raspiInstrument"
require_relative "player"

class Instrument < RaspiInstrument

  def initialize index, loops, controls
    super index
    @loops  = loops;
    @controls = controls
    connect_to_arduino
    connect_to_timing_server
    @player = Player.new @loops, @samples
    run
  end

  def play args
    play_list = @controls.call(args)
    @player.run play_list
  end

end
