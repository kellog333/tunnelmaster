#!/bin/bash
while getopts a:r: flag
do
        case "${flag}" in
                a) action=${OPTARG};;
                r) remote=${OPTARG};;
                s) state=$(OPTARG);;
        esac
done
echo $action
if [ $action == "add" ]
then
        ./new_tunnel.sh $remote
fi
if [ $action == "delete" ]
then
        ip link delete $remote
fi
if [ $sction == "set" ]
        ip link set $remote $state
fi
