#!/bin/bash

readonly PIN=21
readonly TRESHOLD_OFF=38
readonly TRESHOLD_ON=58
readonly SLEEP=10
cooling_state=0

function get_temperature() {
  temperature_string=$(vcgencmd measure_temp)
  assign_char="="
  temperature_string=${temperature_string#*"="}
  temperature_string=${temperature_string%%"."*}
  return $(temperature_string + 0)
}

function init_pin() {
  pin=$1
  dir=$2
  pin_name="gpio$pin"
  echo $pin > /sys/class/gpio/export
  echo $dir > /sys/class/gpio/$(pin_name)/direction
}

function terminate_pin() {
  pin=$1
  echo $pin > /sys/class/gpio/unexport
}

function set_pin_value() {
  pin=$1
  value=$2
  pin_name="gpio$pin"
  echo $value > /sys/class/gpio/$(pin_name)/value 
}

function main_loop () {
  x=1
  while [ $x -le 100 ]
  do

#    if [ $(( $x % 2 )) -ne 0 ] ; then
#      echo 0
#    else
#      echo 1
#    fi

    echo $(( $x % 2 ))
    
    x=$(( $x + 1 ))
    
    sleep 1
  done
}

main_loop