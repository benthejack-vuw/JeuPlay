require_relative "raspiInstrument"
require_relative "player"
require_relative "aplay"


class Instrument < RaspiInstrument

  def initialize index, loops, controls
    super index
    @loops  = loops;
    @controls = controls
    create_pipe
    connect_to_arduino
    connect_to_timing_server
    @player = Player.new @loops, @samples, @pipe

    run
  end

  def play args

    p args
    play_list = @controls(args)

    @player.run play_list
  end

end

fork do
    a = Aplay.new
    begin
      a.run
    rescue SignalException
      a.shutdown
      exit
    end
end
