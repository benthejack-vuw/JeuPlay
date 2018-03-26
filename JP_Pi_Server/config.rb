require 'yaml'

class Config

  MetronomeData = Struct.new(:ip, :port, :rhythm, :sound)
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
      MetronomeData.new("10.0.1.113", 2000, [1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0], "one.WAV"),
      MetronomeData.new("10.0.1.124", 2001, [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1], "two.WAV"),
      MetronomeData.new("10.0.1.113", 2002, [1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0], "three.WAV"),
      MetronomeData.new("10.0.1.50",  2003, [1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0], "four.WAV")
    ]
  end

end

if __FILE__ == $0
  ConfigData.setup
end
