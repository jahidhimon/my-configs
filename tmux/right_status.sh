#!/bin/bash


function battery_meter() {
  printf "["

  if [ "$(which acpi)" ]; then

    local fgdefault='#[default]'
    if [ "$(cat /sys/class/power_supply/AC/online)" == 1 ] ; then

      local charging='+'

    else

      local charging='-'

    fi

# Check for existence of a battery.
    if [ -x /sys/class/power_supply/BAT0 ] ; then

      local batt0=$(acpi -b 2> /dev/null | awk '/Battery 0/{print $4}' | cut -d, -f1)

        case $batt0 in

          100%|9[0-9]%|8[0-9]%|7[5-9]%) fgcolor='#[fg=brightgrey]'
          ;;

          7[0-4]%|6[0-9]%|5[0-9]%) fgcolor='#[fg=brightgreen]'
          ;;

          4[0-9]%|3[0-9]%|2[5-9]%) fgcolor='#[fg=brightyellow]'
          ;;

          2[0-4]%|1[0-9]%|[0-9]%) fgcolor='#[fg=brightred]'
          ;;
        esac
        # Display the percentage of charge the battery has.
        printf "%s""${fgcolor}${charging}${batt0}%${fgdefault}"
    fi
  fi
  printf "] "
}

function date_time() {

  # printf "%s" "$(date +'[%d %b %a] [%r]')"
  printf "%s" "$(date +'[%r]')"

}


function memory_usage() {
  local fgdefault='#[fg=colour40]'
  if [ "$(which bc)" ]; then
    read total used <<< $(free -m | awk '/Mem/{printf $2" "$3}')
    percent=$(bc -l <<< "100 * $used / $total")
    printf "[${fgdefault}${used}M${fgdefault}/${total}M] "
  fi
}

function main() {
  battery_meter
  memory_usage
  date_time
}

# Calling the main function which will call the other functions.
main
