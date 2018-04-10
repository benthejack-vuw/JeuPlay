require_relative 'src/forest'
require_relative 'src/harvest'
require 'optparse'

def default
  $bundler ? "out_of_the_box" : "linuxbrew"
end

options = { pluck: :p }

optparse = OptionParser.new do| opts |
 opts.banner = "Usage: bldr.rb [ options ] section "
 opts.on( '-p', '--pluck', 'pluck a subsection' ) do
   options[ :pluck ] = :pluck
 end
 
 opts.on( '-h', '--help', 'Display this screen' ) do
   puts opts
   exit
 end
end
 
optparse.parse!
arg = ARGV[ 0 ] ? ARGV[ 0 ] : default

f = Forest.new
puts "locating... '#{ arg }'"
got = f.locate( arg, options[ :pluck ] )
if got.any?
  puts "found   ... '#{ got.last.name }'" 
  h = Harvest.new found: got
  h.reap
else
  puts "unable to find '#{ arg }'"
end
