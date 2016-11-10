#!/bin/bash

VPNSERV= wget http://ipinfo.io/ip -qO -

# Disable incoming
ufw default deny outgoing
ufw default deny incoming
ufw openssh allow

#enable outgoing
ufw allow out on tun0 from any to any
ufw allow in on tun0 from any to any

#allow from vpn server you are currently connected to
ufw allow in from $VPNSERV to any
ufw allow out from any to $VPNSERV

#allow local traffic
ufw allow from 192.168.1.0/24

exit 0