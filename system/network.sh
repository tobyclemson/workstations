#! /usr/bin/env bash

set -e
set -o pipefail

###############################################################################
# Network
###############################################################################

#connected_interface=$(route -n get 0.0.0.0 2>/dev/null | awk '/interface: / {print $2}')
#connected_service=$(networksetup -listallhardwareports |
#  grep -B1 "Device: ${connected_interface}" | awk -F': ' '{print $2; exit}')
#all_services=$(networksetup -listallnetworkservices | sed '1d;s/^\*//g')

# Deactivate unused services
#echo "$all_services" | grep -v "$connected_service" | \
#  xargs -I {} sudo networksetup -setnetworkserviceenabled {} off

# Show Time Connected in VPN menubar item
#defaults write com.apple.networkConnect VPNShowTime -bool false

# Show Status When Connecting in VPN menubar item
#defaults write com.apple.networkConnect VPNShowStatus -bool false

# Use Google public DNS (IP Addresses, space delimited)
#sudo networksetup -setdnsservers "$connected_service" 8.8.8.8 8.8.4.4
