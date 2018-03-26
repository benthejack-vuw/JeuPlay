require 'socket'
require 'serialport'
require_relative 'OWL'
require_relative 'serverConfig'
require_relative 'timingConnection'

class RaspiInstrument

	def initialize instrument_index
		port =  ServerConfig::PORTS[instrument_index]
		server_ip = ServerConfig::IP_ADDRESS

		@timing_connection = TimingConnection.new self, server_ip, port
		@timing_connection.connect
		@owl = OWL.new self, 9600
		@owl.run {@timing_connection.listen} #this runs as a loop, if the block returns false (it does) this will run forever
	end

	def println args
		puts args
	end

	def log args
		print args
	end

	def timed_event
		#this asks the arduino for it's data,
		#the arduino will then return the data with a command that runs the jp_data method
		#with the data as an array of args
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

jp_serial_server = RaspiInstrument.new 2
