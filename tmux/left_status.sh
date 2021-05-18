#!/bin/bash


function ip_address() {
    # Loop through the interfaces and check for the interface that is up.
  for file in /sys/class/net/*; do

    iface=$(basename $file);

    read status < $file/operstate;

    [ "$status" == "up" ] && ip addr show $iface | awk '/inet /{printf $2" "}'

  done

}

function cpu_temperature() {
  # Display the temperature of CPU core 0 and core 1.
  sensors -f | awk '/Core 0/{printf $3" "}/Core 1/{printf $3" "}'
}

function memory_usage() {

  if [ "$(which bc)" ]; then
    # Display used, total, and percentage of memory using the free command.
    read used total <<< $(free -m | awk '/Mem/{printf $2" "$3}')
    # Calculate the percentage of memory used with bc.
    # percent=$(bc -l <<< "100 * $total / $used")
    # Feed the variables into awk and print the values with formating.
    # awk -v u=$used -v t=$total -v p=$percent 'BEGIN {printf "%sMi/%sMi %.1f% ", t, u, p}'
    awk -v u=$used -v t=$total -v p=$percent 'BEGIN {printf "%sM/%sM ", t, u}'
  fi
}

function vpn_connection() {
  # Check for tun0 interface.
  [ -d /sys/class/net/tun0 ] && printf "%s " 'VPN*'
}

function internet_status(){
  if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
    echo "[online]"
  else
    echo "[offline]"
  fi
}
function main() {
  # Comment out any function you do not need.
  # ip_address
  internet_status
  # cpu_temperature
  # memory_usage
  # vpn_connection
}

 # Calling the main function which will call the other functions.
 main
