require 'yaml'

class Config

  SERVER = {port: "5200"}
  BANG = "!"
  InstrumentData = Struct.new(:rhythm, :sound)

  @@instruments = nil

  def self.setup
    path = File.join(__dir__, "config.yaml")

    if File.exists? path
      @@instruments = read(path)
    else
      @@instruments = defaults
      save path, @@instruments
    end
  end

  def self.instruments
    self.setup unless @@instruments
    @@instruments
  end

  def self.read path
    YAML.load( File.read(path) )
  end

  def self.save path, data
    File.write( path, data.to_yaml )
  end

  private

  def self.defaults
    [
      InstrumentData.new("1010101010101010", "one.WAV"),
      InstrumentData.new("1111111111111111", "two.WAV"),
      InstrumentData.new("1110111011101110", "three.WAV"),
      InstrumentData.new("1100110011001100", "four.WAV"),
      InstrumentData.new("0011001100110011", "five.WAV")
    ]
  end

end

if __FILE__ == $0
  Config.setup
end
