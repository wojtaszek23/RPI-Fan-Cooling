#!/bin/bash
temperature_string=$(vcgencmd measure_temp)
assign_char="="
temperature_string=${temperature_string#*"="}
temperature_string=${temperature_string%%"."*}
echo $temperature_string