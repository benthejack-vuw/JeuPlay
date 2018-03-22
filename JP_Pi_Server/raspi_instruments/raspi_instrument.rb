require 'socket'
require 'serialport'
require_relative 'OWL'


class RaspiInstrument

	def initialize
		connect
		@owl = OWL.new self, 9600
		@owl.run {run_loop}
	end

	def connect
		puts "waiting for timing  server"
		begin
			@socket = TCPSocket.new 'localhost', 2000
		rescue
			@socket = false
		end until @socket
		puts "connected to timing server"
	end

	def run_loop
		text = @socket.gets

		if(text.include? "bang")
			poll_arduino
		end

		sleep 1.0/100.0

		false #run forever
	end

	def println args
		puts args
	end

	def log args
		print args
	end

	def poll_arduino
		@owl.write("jp_data", "please")
	end

	def jp_data args
		puts args
		play args
	end

	def play args
		#raise 'over-ride this method in child class'
	end

end

jp_serial_server = RaspiInstrument.new
