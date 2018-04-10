class Player

  def initialize sample_loops, samples
    @loops   = sample_loops
    @samples = samples
    @beats = Array.new(@loops.length, 0)
  end

  def run play_list
    @loops.each_with_index do |l, i|
      if(play_list[i] && l[@beats[i]] == '1')
        sample = @samples[i][@beats[i] % @samples[i].length]
        Thread.new {%x{aplay #{sample}}}
      end
      @beats[i] = (@beats[i]+1) % @loops[i].length
    end


  end

end
