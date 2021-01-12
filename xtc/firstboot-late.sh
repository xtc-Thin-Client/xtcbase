#!/bin/sh

SOURCE=/opt/thinclient/install

rm -rf /home/thinclient/Desktop
rm -rf /home/thinclient/Documents
rm -rf /home/thinclient/Downloads
rm -rf /home/thinclient/Music
rm -rf /home/thinclient/Pictures
rm -rf /home/thinclient/Public
rm -rf /home/thinclient/Templates
rm -rf /home/thinclient/Videos

sed '/\/ /s/defaults/ro,defaults/g' -i /etc/fstab
sed '/\/boot/s/defaults/ro,defaults/g' -i /etc/fstab
cat /etc/fstab $SOURCE/fstab_ro > /tmp/fstab
mv /tmp/fstab /etc/fstab

shutdown -r now
