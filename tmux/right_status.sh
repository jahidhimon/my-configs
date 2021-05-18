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

function load_average() {

  printf "%s " "$(uptime | awk -F: '{printf $NF}' | tr -d ',')"

}

function date_time() {

  printf "%s" "$(date +'[%r]')"

}

function internet_status(){
    # Loop through the interfaces and check for the interface that is up.
  for file in /sys/class/net/*; do

    # iface=$(basename $file);

    read status < $file/operstate;
    local connection=0

    if [ "$status" == "up" ] ; then
      let connection=1
      # ip addr show $iface | awk '/inet /{printf $2"] "}'

    fi

  done

  if [ $connection -eq 1] ; then
    printf " [online]"
  else
    printf " [offline]"
  fi

}

function memory_usage() {

  if [ "$(which bc)" ]; then
    # Display used, total, and percentage of memory using the free command.
    read used total <<< $(free -m | awk '/Mem/{printf $2" "$3}')
    # Calculate the percentage of memory used with bc.
    percent=$(bc -l <<< "100 * $total / $used")
    # Feed the variables into awk and print the values with formating.
    # awk -v u=$used -v t=$total -v p=$percent 'BEGIN {printf "[%sMi/%sMi %.1f%] ", t, u, p}'
    awk -v u=$used -v t=$total -v p=$percent 'BEGIN {printf "[%sM/%sM] ", t, u}'
  fi
}

function main() {

  battery_meter
  # load_average
  memory_usage
  date_time
  # internet_status
}

# Calling the main function which will call the other functions.
main
