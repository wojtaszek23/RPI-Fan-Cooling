#!/bin/bash

PIN=21
TRESHOLD_OFF=38
TRESHOLD_ON=58
SLEEP=10
cooling_state=0

function get_temperature() {
  temperature_string=$(vcgencmd measure_temp)
  assign_char="="
  temperature_string=${temperature_string#*"="}
  temperature_string=${temperature_string%%"."*}
  #echo current temperature: $temperature_string
  echo $(( $temperature_string + 0 ))
}

function init_pin() {
  pin=$1
  dir=$2
  pin_name="gpio$pin"
  #echo $pin_name
  echo "$pin" > /sys/class/gpio/export
  sleep 1
  echo $dir > /sys/class/gpio/$pin_name/direction
}

function terminate_pin() {
  pin=$1
  echo $pin > /sys/class/gpio/unexport
}

function set_pin_value() {
  pin=$1
  value=$2
  pin_name="gpio$pin"
  echo $value > /sys/class/gpio/$pin_name/value 
}

function main_loop () {
  current_state="not cooling"
  init_pin $PIN out
  
  while [ 1 ]
  do
    case $current_state in
      "not cooling")
        current_temperature=$(get_temperature)
        if [ $current_temperature -ge $TRESHOLD_ON ] ; then
          set_pin_value $PIN 1
          current_state="cooling"
          echo start cooling
        fi
        echo not cooling
        ;;
      "cooling")
        current_temperature=$(get_temperature)
        if [ $current_temperature -le $TRESHOLD_OFF ] ; then
          set_pin_value $PIN 0
          current_state="not cooling"
          echo stop cooling
        fi
        echo cooling
        ;;
    esac

    sleep 10
  done
}

main_loop