require "fileUtils"

Dir.cd("/home/pi")
%x{git clone https://github.com/benthejack-vuw/JeuPlay.git}

%x{echo "dtoverlay=i2s-mmap" >> /boot/config.txt}

FileUtils.chmod(0755, "/home/pi/JeuPlay/JP_Pi_Server/startup_scripts/startup.sh")

cat /proc/cpuinfo | grep Serial | cut -d ' ' -f 2
