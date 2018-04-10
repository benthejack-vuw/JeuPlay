require 'uri'

DOCK_PREFS = "com.apple.dock"

class Dock
  
  def initialize
    # defaults write com.apple.dock persistent-apps -array-add "<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Automator.app/</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>";
    
  end
  
  def docked? app
    # test = %x{defaults find #{DOCK_PREFS} | grep "file:///"}.split(/\n/).map{|i| URI(i.strip.split(/ = /)[1].gsub(/[\"|\;]/,"") )}.map{|i| File.basename(URI.unescape(i.path))}
    test = %x{defaults read #{DOCK_PREFS} persistent-apps -array -dict}
    puts test.inspect
    exit
  end
  
  def add item
    unless docked? item
      puts item
    else
      puts "item '#{item}' already in dock"
    end
  end
  
  def remove item
  end
  
  def remove_all!
    %x{defaults write com.apple.dock persistent-apps -array -dict-file-data}
  end
  
  def restart
    %x{killall -HUP Dock}
  end
  
  
end

if __FILE__ == $0
  d = Dock.new
  puts d.inspect
  d.add("textmate")
end