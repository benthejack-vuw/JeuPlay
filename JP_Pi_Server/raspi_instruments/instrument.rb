class Instrument

  def initialize sample_loops, samples, pipe
    @loops   = sample_loops
    @samples = samples
    @pipe   = pipe
    @beats = Array.new(@loops.length, 0)
  end

  def run play_list
    @loops.each_with_index do |l, i|
      @pipe.write @samples[i] if(play_list[i] && l[@beat] == '1')
      @beats[i] = (@beats[i]+1) % @loops[i].length
    end


  end

end
