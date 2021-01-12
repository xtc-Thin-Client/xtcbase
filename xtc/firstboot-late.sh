#!/bin/sh

SOURCE=/opt/thinclient/install
sed '/\/ /s/defaults/ro,defaults/g' -i /etc/fstab
sed '/\/boot/s/defaults/ro,defaults/g' -i /etc/fstab
cat /etc/fstab $SOURCE/fstab_ro > /tmp/fstab
mv /tmp/fstab /etc/fstab

