require_relative "serverConnection"

class TimedInstrument

  def initialize timing_data, ip, port
    @note = 0;
    @timing_data = timing_data
    @server_connection = ServerConnection.new ip, port
  end

  def connect
    @server_connection.connect_UDP
  end

  def play_note
    if @server_connection.connected
      @server_connection.send_message "bang" if @timing_data[@note] > 0
      @note = (@note+1) % @timing_data.length
    end
  end

end
