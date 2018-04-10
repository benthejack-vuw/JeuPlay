class Harvest
  
  def initialize found:items 
    @items = found
    @file  = File.open( BLDR,"w" )
    bang
    @level = 0
  end
  
  def reap
    @items.each do |i|
      puts "building... '#{i.name}'"
      emit i
      @level += 1
    end
    @file.close
    File.chmod(0755,BLDR)
  end
  
  private
  
  def emit node
    if node.has_children?
      banner node.name
      case  node.children.first.name
        when /^@/ then bash_module node.children.last
        when /^file_copy/ then bash_file node.children.last
        else bash_normal node
      end
      popd node
    else
      bash_line node
    end
  end
  
  def bang
    @file.puts "#{BANG}", NEWLINE 
  end
  
  def pushd tag
    @file.puts "#{tabs}pushd #{tag} ", NEWLINE
  end
  
  def popd node
    @file.puts NEWLINE, "#{tabs}popd", NEWLINE
  end
  
  def bash_normal node
    pushd node.path
    indent { node.children.each{|n| emit n} }
  end
  
  def bash_line node
    indent do
      case node.name
        when /.rb/ then bash_ruby node
        when /^Gemfile$/ then bash_gem node
        when /Brewfile/ then bash_brew node
      end
    end
  end
  
  def bash_module node
    pushd node.path
    indent { node.children.each{|n| emit n} }
  end
  
  def bash_file node 
    pushd node.content
    indent { @file.puts "#{tabs}#{maybe_sudo?( node.name )} #{$ruby} file_copy.rb #{node.parent.path}" }
  end

  def bash_ruby node
    @file.puts "#{tabs}#{maybe_sudo?( node.name )} #{$ruby} #{node.name}"
    @file if block_given?
  end
  
  def bash_gem node
    @file.puts "#{tabs}#{$bundler} update"
  end
  
  def bash_brew node
    @file.puts "#{tabs}#{$brew} bundle --file=#{node.name}"
  end
  
  def tabs
    "  " * @level
  end
  
  def banner label
    pad = ( @level == 0 ) ? "=" : "_"
    line = "  '#{label}'  ".center(80,pad)
    @file.puts "#{tabs}##{line}", NEWLINE
  end
    
  def indent
    @level +=1
      yield if block_given?
    @level -= 1
  end
  
end
