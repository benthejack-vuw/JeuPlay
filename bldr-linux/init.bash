#!/usr/bin/bash
# RED HAT ONLY subscription-manager register --username your_username --password your_password

sudo yum -y upgrade

sudo yum -y install ruby 

sudo cp ./mddn.sh /etc/profile.d/mddn.sh

# Add user render then change password via usermod - password must be encrypted - we can use openssl to encrypt
#   openssl passwd -1 my_new_password
# and potentially pipe it in as:
#   usermod --password $(echo my_new_password | openssl passwd -1 -stdin) USERNAME
# but to avoid a plaintext password:
sudo useradd -m render
sudo usermod --password '$1$l//34KY2$W7Lyu.nxfPK8hoJO7LsSH/' render

sudo shutdown -r now
