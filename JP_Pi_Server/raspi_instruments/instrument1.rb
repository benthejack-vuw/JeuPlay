require_relative "raspiInstrument"
require_relative "aplay"


class Instrument1 < RaspiInstrument

  def initialize
    super 0
    @beat = 0
    create_pipe
    connect_to_arduino
    connect_to_timing_server
    run
  end

  def play args
    puts "#{args[0]} #{args[1]} #{@beat}"
    if(@data.rhythm[@beat] == '1')
      @pipe.write "./sounds/one.WAV" if args[0] == "LEFT"
      @pipe.write "./sounds/two.WAV" if args[0] == "RIGHT"
    end

    @beat = (@beat+1) % @data.rhythm.length
    #raise 'over-ride this method in child class'
  end

end

fork do
    a = Aplay.new
    a.run
end

Instrument1.new
