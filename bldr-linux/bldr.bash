#!/bin/bash

#==============================  'out_of_the_box'  ==============================

pushd /home/design/Desktop/bldr-linux/data/out_of_the_box 

  #______________________________  '1_system_setup'  ______________________________

  pushd /home/design/Desktop/bldr-linux/data/out_of_the_box/1_system_setup 

      sudo /home/linuxbrew/.linuxbrew/bin/ruby 1_sudo_system_setup.rb
    #_____________________________  '2_sudo_file_copy'  _____________________________

    pushd /home/design/Desktop/bldr-linux/src/shared 

      sudo /home/linuxbrew/.linuxbrew/bin/ruby file_copy.rb /home/design/Desktop/bldr-linux/data/out_of_the_box/1_system_setup/2_sudo_file_copy

    popd


  popd

  #________________________________  '2_@blender'  ________________________________

  pushd /home/design/Desktop/bldr-linux/modules/blender 

      sudo /home/linuxbrew/.linuxbrew/bin/ruby 1_sudo_setup.rb

  popd

  #__________________________________  '3_gems'  __________________________________

  pushd /home/design/Desktop/bldr-linux/data/out_of_the_box/3_gems 

      /home/linuxbrew/.linuxbrew/bin/bundler update

  popd

  #________________________________  '4_system_d'  ________________________________

  pushd /home/design/Desktop/bldr-linux/data/out_of_the_box/4_system_d 

    #_____________________________  '1_sudo_file_copy'  _____________________________

    pushd /home/design/Desktop/bldr-linux/src/shared 

      sudo /home/linuxbrew/.linuxbrew/bin/ruby file_copy.rb /home/design/Desktop/bldr-linux/data/out_of_the_box/4_system_d/1_sudo_file_copy

    popd

      sudo /home/linuxbrew/.linuxbrew/bin/ruby 2_sudo_sysctl.rb

  popd


popd

