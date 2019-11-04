#!/bin/bash
for device in /dev/hidraw*; 
do  
    sudo /opt/bin/k480_conf -d $device -f on; 
done
