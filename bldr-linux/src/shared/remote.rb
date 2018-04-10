class Remote
  
  def initialize
  end
  
  attr_accessor :server,:share,:mount_directory,:mount_point,:protocol,:user,:password
  
  def config
    yield self
  end
  
  def mount_point
    "#{@mount_directory}/#{@share}"
  end
  
  def mount( user = @user, password = @password )
    create_mount_point
    system("#{@mountprefix}#{user}:#{password}@#{@server}/#{@share}/ #{mount_point}") unless mounted?
  end
  
  def protocol=(p)
    @mountprefix = ( p =~ /afp/i ) ?  "mount_afp -o nobrowse afp://" : "mount_smbfs //"
    @protocol = p
  end
  
  def mounted?
    mnt = %x{ mount -d | grep '#{mount_point}' }.chomp
    ( mnt =~ /#{mount_point}/i ) ? true : false
  end
  
  def unmount
    system("umount -f #{mount_point}")
  end
  
  private
  
  def create_mount_point
    system("mkdir -p #{mount_point}") unless File.directory?(mount_point)
  end
  
end