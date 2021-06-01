#!/bin/bash

#Use this script to create one individual tunnel and add to list for persistence

MY_IP=`cat /usr/share/tunnelbuilder/localip`

add_gre_tunnel(){
        echo "Creating tunnel to $1 with remote ip $2"
        ip link add "$1" type ip6gretap remote $2 local "$MY_IP" encaplimit none ttl 255
        ip link set "$1" mtu "$MTU_SIZE"
        ip link set "$1" master br1
        bridge link set dev "$1" isolated on
        sleep 5
        ip link set "$1" up
}

echo $1 >> /usr/share/tunnelmaster/tunnellist
add_gre_tunnel l2gre$((1 + $RANDOM % 10)) $1 $MY_IP