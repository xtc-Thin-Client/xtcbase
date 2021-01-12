#!/bin/sh

SOURCE=/opt/thinclient/install

rmdir /home/thinclient/Desktop
rmdir /home/thinclient/Documents
rmdir /home/thinclient/Downloads
rmdir /home/thinclient/Music
rmdir /home/thinclient/Pictures
rmdir /home/thinclient/Public
rmdir /home/thinclient/Templates
rmdir /home/thinclient/Videos

sed '/\/ /s/defaults/ro,defaults/g' -i /etc/fstab
sed '/\/boot/s/defaults/ro,defaults/g' -i /etc/fstab
cat /etc/fstab $SOURCE/fstab_ro > /tmp/fstab
mv /tmp/fstab /etc/fstab

shutdown -r now
