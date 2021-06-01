#!/bin/bash

echo "Welcome to the tunnelmaster setup"
echo "Enter the local IPv6 address for tunnels:"
read LOCAL_IP
echo "Enter Interface for tunnels:"
read INTERFACE

echo "Creating directory"
mkdir /usr/share/tunnelmaster
echo "Copying files"
cp buildtunnels.sh /usr/share/tunnelmaster/buildtunnels.sh
chmod +x buildtunnels.sh
cp new_tunnel.sh /usr/share/tunnelmaster/new_tunnel.sh
chmod +x new_tunnel.sh
cp tunnelmaster.sh /usr/share/tunnelmaster/tunnelmaster.sh
chmod +x tunnelmaster.sh
echo $LOCAL_IP >> /usr/share/tunnelmaster/localip
echo $INTERFACE >> /usr/share/tunnelmaster/interfaces
touch /usr/share/tunnelmaster/tunnellist
echo "alias tunnelmaster='./usr/share/tunnelmaster/tunnelmaster.sh'" >> ~/.bashrc
source ~/.bashrc

(crontab -l 2>/dev/null; echo "@reboot /usr/share/tunnelmaster/buildtunnels.sh") | crontab -

