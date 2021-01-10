#!/bin/bash

SOURCE=/opt/thinclient/install
rm $SOURCE/install.err 2> /dev/null
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


echo "1. install packages"
# delete pulseaudio while problems with also sound
apt-get -y remove pulseaudio

echo "3. add user"
rmdir /home/thinclient/Desktop
rmdir /home/thinclient/Documents
rmdir /home/thinclient/Downloads
rmdir /home/thinclient/Music
rmdir /home/thinclient/Pictures
rmdir /home/thinclient/Public
rmdir /home/thinclient/Templates
rmdir /home/thinclient/Videos


echo "16. create data directory"
#mkdir $DATA 2>> /dev/null

echo "17. mount data directory"
#if [ "$OS" = "R" ]
#then
#  cat /etc/fstab $SOURCE/fstab_data > /tmp/fstab
#  mv /tmp/fstab /etc/fstab
#  mount -a
#fi

echo "18. config data directory"
chmod a=rwx $DATA 2>> /dev/null
mkdir $DATA/thinclient 2>> $SOURCE/install.err
chown thinclient $DATA/thinclient 2>> $SOURCE/install.err
chgrp thinclient $DATA/thinclient 2>> $SOURCE/install.err
mkdir $DATA/vpn 2>> $SOURCE/install.err
chown thinclient $DATA/vpn 2>> $SOURCE/install.err
chgrp thinclient $DATA/vpn 2>> $SOURCE/install.err
mkdir $DATA/usb 2>> $SOURCE/install.err
chown thinclient $DATA/usb 2>> $SOURCE/install.err
chgrp thinclient $DATA/usb 2>> $SOURCE/install.err

echo "19. config read only fs"
if [ "$OS" = "R" ]
then
  sed '/\/ /s/defaults/ro,defaults/g' -i /etc/fstab
  sed '/\/boot/s/defaults/ro,defaults/g' -i /etc/fstab
  cat /etc/fstab $SOURCE/fstab_ro > /tmp/fstab
  mv /tmp/fstab /etc/fstab
fi

#echo "23. install driver for pi desktop case (Raspbery Pi 3 only)"
#if [ "$OS" = "R" ]
#then
#  dpkg -i /opt/thinclient/install/desktop/pidesktop-base.deb
#  echo " " >> /boot/config.txt
#  echo " " >> /boot/config.txt
#  cp $SOURCE/desktop/pidesktop.sh $DESTINATION/desktop
#  cp $SOURCE/desktop/pidesktop-powerkey.service /lib/systemd
#  cp $SOURCE/desktop/pidesktop-reboot.service /lib/systemd
#  cp $SOURCE/desktop/pidesktop-shutdown.service /lib/systemd
#  cp $SOURCE/desktop/pidesktop-powerkey.service /etc/systemd/system
#  cp $SOURCE/desktop/pidesktop-reboot.service //etc/systemd/system
#  cp $SOURCE/desktop/pidesktop-shutdown.service /etc/systemd/system
#  chown root:root $DESTINATION/desktop/pidesktop.sh
#  chown root:root /lib/systemd/pidesktop-powerkey.service 
#  chown root:root /lib/systemd/pidesktop-reboot.service
#  chown root:root /lib/systemd/pidesktop-shutdown.service
#  chown root:root /etc/systemd/system/pidesktop-powerkey.service 
#  chown root:root /etc/systemd/system/pidesktop-reboot.service
#  chown root:root /etc/systemd/system/pidesktop-shutdown.service
#fi

#echo "25. install software for argon1 case (Raspberry Pi 4 only)"
#if [ "$OS" = "R" ]
#then
  #$SOURCE/desktop/argon1.sh
  #systemctl disable argononed
#fi

