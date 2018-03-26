class TimedInstrument

  def initialize timing_data, port
    @note = 0;
    @timing_data = timing_data
    @connection = new ServerConnection port
  end

  def play_note
    @connection.send_message "bang" if @timing_data[@note]
    @note = (@note+1)%@timing_data.length
  end

end
