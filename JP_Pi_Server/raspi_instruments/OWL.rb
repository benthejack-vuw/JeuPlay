class OWL
  ARDUINO_CONNECTION_DELAY = 4
  DISCARD_PORTS = ["/dev/tty.Bluetooth-Incoming-Port",
							     "/dev/cu.Bluetooth-Incoming-Port" ]

  def initialize delegate, baud_rate = 9600
    @baud_rate = baud_rate
    @delegate = delegate
    @data_bits = 8
    @stop_bits = 1
    @parity = SerialPort::NONE
    @serial = nil
    connect
  end

  def connect
    block_loop do
      #LINUX
      ports = Dir.glob("/dev/ttyUSB*") - DISCARD_PORTS

      #MAC
      #ports = Dir.glob("/dev/{tty,cu}.*") - DISCARD_PORTS

      ports.each{ | p | attempt_connection p; break if @serial }
      raise "no USB devices found" if ports.empty?
      ( @serial != nil )
   	 end
     sleep 1

	@serial.flush_input

	end

  def write command, message, port=@serial
    port.write "#{command}~#{message}|"
  end

  def read_and_respond

    begin
      command = @serial.readline.chomp "|\r\n"
      args = command.split("~")
      message = args.shift()
    rescue EOFError
      return
    end

    ( @delegate.respond_to?( message ) ) ? @delegate.send( message, args ) : puts( "'#{message}' is not implemented in #{@delegate.class.name}" )

  end

  def purge_handshake


    begin
      unless @serial.eof?
        command = @serial.readline.chomp "|\r\n"
        args = command.split("~")
        message = args.shift()
      end
    rescue EOFError
      "EOF in PURGE"
      return
    end until message && !message.include?("arduino")

  end


  def run
    block_loop do
      read_and_respond
      block_given? ? yield : false
    end
  end

  private

  def block_loop
    begin
      conditional = yield if block_given?
    end until conditional
  end

  def attempt_connection p
		puts "trying to connect to:#{p}"
		conn = SerialPort.new(p, @baud_rate, @data_bits, @stop_bits, @parity)
    conn.read_timeout = 100
		sleep ARDUINO_CONNECTION_DELAY
    block_loop do
      attempt_handshake conn
    end
  end

  def attempt_handshake conn
    puts
    begin
    	handshake = conn.readline
      puts "handshake: #{handshake}"
    		if handshake.include? "arduino"
          puts "bleep?"
    			@serial = conn
    			@serial.write "arduinoServer"
    			sleep 2
    			@serial.flush_input
          purge_handshake
    			puts "CONNECTED TO ARDUINO"
    		end
    rescue EOFError
      puts "restarting arduino"
  		write "reset", "now", conn
  		sleep 10
    end

    (@serial != nil) #block_loop run until serial is connected
  end

end
