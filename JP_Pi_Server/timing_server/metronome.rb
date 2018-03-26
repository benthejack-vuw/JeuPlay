require_relative 'channel'

class Metronome

  def initialize data
    @beat = 0;
    @rhythm = data.rhythm
    @channel = Channel.new data.ip, data.port
    @channel.start
  end

  def tick
      @channel.send_message "bang" if @rhythm[@beat] > 0
      @beat = (@beat+1) % @rhythm.length
  end

end
