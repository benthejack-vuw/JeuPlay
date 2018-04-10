Builder Linux Documentation

1. Copy bldr-linux AND the linux folder to the desktop

    Please input sudo password when prompted

2. Installs system tools and libraries for builder to work
    run ~/Desktop/bldr-linux/init.bash
    This will restart after running

3. Install linuxbrew: 
    Open terminal
    run ruby ~/Desktop/bldr-linux/bldr.rb to generate bldr.bash
    run ./bldr.bash
    quit terminal

4. Install Out of the Box and software
    Reopen terminal 
    run ruby ~/Desktop/bldr-linux/bldr.rb to generate new bldr.bash
    run ./bldr.bash
    
    install required maya from ~/Desktop/linux
    tar -xvf maya.tar
    sudo ~/maya/setup
    ruby bldr.rb maya<version> 

    install arnold from ~/Desktop/linux
    sudo sh ~/Desktop/mtoa<version>.run



