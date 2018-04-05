#!/bin/bash

ID=`cat /proc/cpuinfo | grep Serial | cut -d ' ' -f 2`

pushd /home/pi/JeuPlay/JP_Pi_Server/raspi_instruments
  /home/linuxbrew/.linuxbrew/bin/ruby $ID.rb
popd
