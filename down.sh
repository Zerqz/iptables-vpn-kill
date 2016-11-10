#!/bin/bash

# Remove the iptables policys.
iptables -F
iptables -t nat -F
iptables -t mangle -F

ip6tables -F
ip6tables -t nat -F
ip6tables -t mangle -F

iptables-save

echo "You can now restore your old iptable settings."

exit 0