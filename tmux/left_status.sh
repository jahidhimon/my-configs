#!/bin/bash


function internet_status(){
  if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
    fgcolor='#[fg=brightgreen]'
    fgcolor='#[fg=colour40]'
    net_status='[●]'
  else
    fgcolor='#[fg=brightred]'
    net_status='[●]'
  fi
  printf "%s" "${fgcolor}${net_status}${fgdefault}"
}

function main() {
  internet_status
}

 # Calling the main function which will call the other functions.
 main
