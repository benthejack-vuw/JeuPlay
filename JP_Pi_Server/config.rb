require 'yaml'

class Config

  MetronomeData = Struct.new(:ip, :port, :rhythm)
  @@metronomes = nil

  def self.setup
    path = File.join(__dir__, "config.yaml")

    if File.exists? path
      @@metronomes = read(path)
    else
      @@metronomes = defaults
      save path, @@metronomes
    end
  end

  def self.metronomes
    self.setup unless @@metronomes
    @@metronomes
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
      MetronomeData.new("10.0.1.50", 2000, "1010101010101010"),
      MetronomeData.new("10.0.1.50", 2001, "1111111111111111"),
      MetronomeData.new("10.0.1.50", 2002, "1110111011101110"),
      MetronomeData.new("10.0.1.50", 2003, "1100110011001100")
    ]
  end

end

if __FILE__ == $0
  ConfigData.setup
end
