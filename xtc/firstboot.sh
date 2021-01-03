#!/bin/bash

DIR=/home/thinclient
DESTINATION=/opt/thinclient
VAR=/var/thinclient
DATA=/data
echo "* start installation"
MODEL=""
OS="U"
if (cat /etc/issue | grep -i "RASPBIAN")
then
  OS="R"
  # detect pi hardware 
  MODEL=$(cat /proc/cpuinfo |grep "Revision" | cut -d: -f2 | sed 's/^[ \t]*//')
  if [ "$MODEL" = "a22082" ] || [ "$MODEL" = "a220a0" ] || [ "$MODEL" = "a32082" ] || [ "$MODEL" = "a52082" ] || [ "$MODEL" = "a22083" ] || [ "$MODEL" = "a02100" ] || [ "$MODEL" = "a020d3" ] || [ "$MODEL" = "a2082" ] || [ "$MODEL" = "a20a0" ]
  then
    MODEL="PI3"
  else
    MODEL="PI4"
  fi
fi

echo "System:" $OS
echo "Model:" $MODEL

echo "16. create data directory"
mkdir $DATA 2>> /dev/null

echo "17. mount data directory"
if [ "$OS" = "R" ]
then
  cat /etc/fstab $DESTINATION/install/fstab_data > /tmp/fstab
  mv /tmp/fstab /etc/fstab
  mount -a
fi

echo "18. config data directory"
chmod a=rwx $DATA 2>> /dev/null
mkdir $DATA/thinclient
chown thinclient $DATA/thinclient
chgrp thinclient $DATA/thinclient
mkdir $DATA/vpn
chown thinclient $DATA/vpn
chgrp thinclient $DATA/vpn 
mkdir $DATA/usb
chown thinclient $DATA/usb
chgrp thinclient $DATA/usb

echo "19. config read only fs"
if [ "$OS" = "R" ]
then
  sed '/\/ /s/defaults/ro,defaults/g' -i /etc/fstab
  sed '/\/boot/s/defaults/ro,defaults/g' -i /etc/fstab
  cat /etc/fstab $DESTINATION/install/fstab_ro > /tmp/fstab
  mv /tmp/fstab /etc/fstab
fi

echo "25. install software for argon1 case (Raspberry Pi 4 only)"
if [ "$OS" = "R" ]
then
  $DESTINATION/desktop/argon1.sh
  systemctl disable argononed
fi
