#!/usr/bin/env bash

battery_info="$(acpi -b | head -n 1)"
[ -n "$battery_info" ] || exit 0

status="${battery_info#*: }"
status="${status%%,*}"
level="${battery_info#*, }"
level="${level%%\%*}"
level="${level//[^0-9]/}"

if [[ ("$status" == "Discharging") || ("$status" == "Full") ]]; then
  if [[ "$level" -eq "0" ]]; then
    printf " "
  elif [[ ("$level" -ge "0") && ("$level" -le "25") ]]; then
    printf " "
  elif [[ ("$level" -ge "25") && ("$level" -le "50") ]]; then
    printf " "
  elif [[ ("$level" -ge "50") && ("$level" -le "75") ]]; then
    printf " "
  elif [[ ("$level" -ge "75") && ("$level" -le "100") ]]; then
    printf " "
  fi
elif [[ "$status" == "Charging" ]]; then
  printf " "
fi
