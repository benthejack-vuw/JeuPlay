%x{mkdir /usr/blender}
%x{tar -xvf /home/design/Desktop/linux/blender-2.79-linux-glibc219-x86_64.tar.bz2 -C /usr/blender --strip-components=1}
%x{chown -R root:root /usr/blender}
%x{chmod -R 755 /usr/blender}
%x{ln -s /usr/blender/blender /usr/local/bin/blender}
%x{ln -s /usr/blender/blender.desktop /usr/share/applications/blender.desktop}
