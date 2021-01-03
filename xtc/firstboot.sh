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

