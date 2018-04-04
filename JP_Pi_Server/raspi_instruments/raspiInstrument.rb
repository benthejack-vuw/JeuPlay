require 'socket'
require 'serialport'
require_relative 'OWL'
require_relative '../config'
require_relative 'channelSubscriber'

class RaspiInstrument

	def initialize instrument_index
		@sound_folder = Dir.glob("./sounds/*").sort[instrument_index]
		@samples = Dir.glob(File.join(@sound_folder, "*.wav"))
	end

	def connect_to_arduino
		@owl = OWL.new self, 9600
	end

	def connect_to_timing_server
		@channel_sub = ChannelSubscriber.new self
		@channel_sub.connect
	end

	def run
		@owl.run do
			@channel_sub.listen
		end #this runs as a loop, if the block returns false (it does) this will run forever
	end

	def create_pipe
    @pipe = Pipe.new("Aplay_IN").tap{|p| p.open_for_output }
  end

	def println args
		puts args
	end

	def log args
		print args
	end

	def timed_event
		#this asks the arduino for its data,
		#the arduino will then return the data with a command that runs the jp_data method
		#with the data as an array of args
		@owl.write("jp_data", "please")
	end

	def jp_data args
		play args
	end

	def play args
		  raise "implement play in subclass of RaspiInstrument"
	end

end
