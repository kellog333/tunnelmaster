#!/bin/bash

#egress interface
LIST_FILE="/usr/share/tunnelmaster/tunnellist"
REMOTE_DEVICES=$(cat $LIST_FILE)
INTERFACE=`cat /usr/share/tunnelmaster/interfaces`
MTU_SIZE=1986
#Incoming IP
MY_IP=`cat /usr/share/tunnelmaster/localip`

add_gre_tunnel(){
        echo "Creating tunnel to $1 with remote ip $2"
        ip link add "$1" type ip6gretap remote $2 local "$MY_IP" encaplimit none ttl 255
        ip link set "$1" mtu "$MTU_SIZE"
        ip link set "$1" master br1
        bridge link set dev "$1" isolated on
        sleep 5
        ip link set "$1" up
}

IDX=1


echo "Setting Local MTU"
ip link set "$INTERFACE" mtu 1986
ip link set ens19 mtu 1986
echo "Creating Bridge"
ip link add name br1 type bridge
echo "Adding VLAN to Bridge"
ip link set "$INTERFACE" master br1
echo "Enabling Bridge"
ip link set br1 up

# Create tunnels

for i in $REMOTE_DEVICES
do
        echo $i
        add_gre_tunnel l2gre$IDX $i $MY_IP
        IDX=$(($IDX + 1))
done
