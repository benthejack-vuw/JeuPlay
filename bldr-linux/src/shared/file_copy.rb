# install system files ( Launchagent for unigrid/asset database) )
# theses files are laid out in the data directory as they would from root on the Main machine
require "fileutils"

class Copier
  
  def initialize path:arg
    @path = File.expand_path( path )
    @current_user = %x{whoami}.chomp
  end
    
  def run
    pushd
    Dir.glob("**/*").each do |item|
      src = File.expand_path(item)
      item.sub!('$current_user',@current_user)
      dest = File.join("/",item)
      if File.directory?(src)
        FileUtils.mkdir_p(dest)
      else
        FileUtils.cp(src,dest) unless File.exists?(dest)
      end
    end
    popd
  end
  
  def pushd
    @last_dir = Dir.pwd
    Dir.chdir @path
  end
  
  def popd
    Dir.chdir @last_dir
  end
  
end

if ARGV[0]
  c = Copier.new path:ARGV[0]
  c.run
end
