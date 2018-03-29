class Pipe

  def initialize( pipe_file_name = nil )
    @pipe_file_name = pipe_file_name
    @pipe_file = create_pipe_file
    @in = @out = false
  end

  attr_reader :pipe_file,:in,:out

  def in?
    @in
  end

  def out?
    @out
  end

  def read
    @input.gets
  end

  def write(value)
    @output.puts value
    @output.flush
  end

  def open_for_output
    @output = open(@pipe_file, "w+")
    @out = true
  end

  def open_for_input
    @input = open(@pipe_file, "r+")
    @in = true
  end

  def close
    @output.close if @out
    @input.close if @in
    destroy_pipe_file
  end

  private

  def create_pipe_file
    result = @pipe_file_name ? @pipe_file_name : @pipe_file_name.to_s
    if File.exists?(result)
      raise "file '#{result}' is not a pipe" unless File.pipe?(result)
    else
       result = pipe_full_path
       %x{mkfifo #{result} }
    end
    result
  end

  def destroy_pipe_file
    %x{rm #{@pipe_file} }
  end

  def pipe_full_path
    File.join("/tmp/","#{@pipe_file_name}")
  end

end
