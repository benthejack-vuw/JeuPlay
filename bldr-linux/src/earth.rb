require 'logger'

def maybe_sudo? name
  !!( name =~ /sudo/i) ? "sudo" : nil
end

def path_for binary
  mac_path    = File.join( "/usr/local/bin",binary )
  linux_path  = File.join( "/home/linuxbrew/.linuxbrew/bin/",binary )
  File.exists?( mac_path ) ? mac_path : File.exists?( linux_path ) ? linux_path : nil
end

ROOT            = File.dirname( __dir__ )
INDEX           = "index"
DATUM           = "data"
MODULES         = "modules"
SOURCE          = "src"
BLDR            = "bldr.bash"
BANG            = "#!/bin/bash"
NEWLINE         = "\n"

$logger         = Logger.new("#{Time.now.strftime("%Y_%m_%d")}.log")
$ruby           = path_for( "ruby" ) ? path_for( "ruby" ) : "/usr/bin/ruby"
$bundler        = path_for "bundler"
$brew           = path_for( "brew" ) ? path_for( "brew" ) : "/home/linuxbrew/.linuxbrew/bin/"

$resource_list  = [/\.rb/,/Brewfile/,/^Gemfile$/]
$module_list    = [/file_copy/i,/\@/]
$module_paths   = {"file_copy"=>File.join(ROOT,SOURCE,'shared'),"@"=>File.join(ROOT,MODULES)}
$ml             = Regexp.union( $module_list )

