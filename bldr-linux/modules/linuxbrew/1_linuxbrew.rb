require "fileutils"
require 'net/http'

# install Homebrew
brew_binary = %x{which brew}.chomp

if brew_binary == ""
  homebrew_uri = URI('https://raw.githubusercontent.com/Linuxbrew/install/master/install')
  homebrew_script = Net::HTTP.get(homebrew_uri)
  eval(homebrew_script)
end