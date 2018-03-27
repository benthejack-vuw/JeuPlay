require 'yaml'

class Config
  SERVER = {ip:"10.0.1.50", port: "4000"}
  BANG = "!"
  MetronomeData = Struct.new(:rhythm, :sound)
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
      MetronomeData.new([1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0], "one.WAV"),
      MetronomeData.new([1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1], "two.WAV"),
      MetronomeData.new([1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0], "three.WAV"),
      MetronomeData.new([1,1,0,0,1,1,0,0,1,1,0,0,1,1,0,0], "four.WAV")
    ]
  end

end

if __FILE__ == $0
  Config.setup
end
