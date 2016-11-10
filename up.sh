#!/bin/bash

#root check
if [ "$(id -u)" != "0" ]; then
   echo "FATAL ERROR: Run this script as root (sudo)!"
   exit 1
fi

VPNSERV=$(wget http://ipinfo.io/ip -qO -)

#warning
echo "Backup your existing iptables!!!!"
read -p "Do you care? y/n" -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Nn]$ ]]
then
    exit 1
fi


#flush
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
ip6tables -F
ip6tables -t nat -F
ip6tables -t mangle -F

# Allow all and everything on localhost
iptables -A INPUT  -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# LAN
iptables -A INPUT  -i eth0 -s 192.168.1.0/24 -j ACCEPT
iptables -A OUTPUT -o eth0 -d 192.168.1.0/24 -j ACCEPT

# DNS
iptables -A INPUT  -p udp --sport 53 -j ACCEPT
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT

# Allow VPN traffic
iptables -A INPUT  -p udp --sport 443 -j ACCEPT
iptables -A OUTPUT -p udp --dport 443 -j ACCEPT

# VPN DNS
iptables -A INPUT  -s 8.8.8.8 -j ACCEPT;
iptables -A OUTPUT -s 8.8.4.4 -j ACCEPT;

# VPN server
iptables -A INPUT  -p udp -s $VPNSERV -j ACCEPT;
iptables -A OUTPUT -p udp -d $VPNSERV -j ACCEPT;

# Accept TUN
iptables -A INPUT    -i tun+ -j ACCEPT
iptables -A OUTPUT   -o tun+ -j ACCEPT
iptables -A FORWARD  -i tun+ -j ACCEPT

# Drop the rest
iptables -A INPUT   -j DROP
iptables -A OUTPUT  -j DROP
iptables -A FORWARD -j DROP

# Block All V6
ip6tables -A OUTPUT -j DROP
ip6tables -A INPUT -j DROP
ip6tables -A FORWARD -j DROP

#save
iptables-save

echo "..."
echo "......"
echo "Network locked to vpn @ $VPNSERV"

exit 0