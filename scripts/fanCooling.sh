#!/bin/bash

readonly PIN=21
readonly TRESHOLD_OFF=35
readonly TRESHOLD_ON=60
readonly SLEEP_TIME=10

function get_temperature() {
  temperature_string=$(vcgencmd measure_temp)
  temperature_string=${temperature_string#*"="}
  temperature_string=${temperature_string%%"."*}
  return $(( $temperature_string + 0 ))
}

function init_pin() {
  pin=$1
  dir=$2
  pin_name="gpio$pin"
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
    date
    get_temperature
    current_temperature=$?
    case $current_state in
      "not cooling")
        if [ $current_temperature -ge $TRESHOLD_ON ] ; then
          set_pin_value $PIN 1
          current_state="cooling"
          echo start cooling
        fi
        ;;
      "cooling")
        if [ $current_temperature -le $TRESHOLD_OFF ] ; then
          set_pin_value $PIN 0
          current_state="not cooling"
          echo stop cooling
        fi
        ;;
        echo $current_state, temperature: $current_temperature
    esac

    sleep $SLEEP_TIME
  done
}

main_loop