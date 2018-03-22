require 'socket'
require 'serialport'
require_relative 'OWL'


class JPSerialServer

	def initialize

		puts "waiting for timing  server"
		begin
			@socket = TCPSocket.new '10.0.1.50', 2000
		rescue
			@socket = false
		end until @socket
		puts "connected to timing server"

		@owl = OWL.new self, 9600
		@owl.run do

			text = @socket.gets
			puts text

			if(text.include? "bang")
				poll_arduino
			end

			sleep 1.0/100.0
			false #run forever
		end
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
	end

end

jp_serial_server = JPSerialServer.new
