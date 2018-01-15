# iptables-vpn-kill

# What it does:
  Locks all outbound & inbound traffic to be through a specific IP address (IE, from your VPN) so in the case of a disconnection from it, all traffic will stop and not fail-over to your ISP's IP address. 


DISCLAIMER:
You can not hold me accountable for any DMCA notice you might get while using this script. 

These are scripts I use on my own behalf that I find work very well, your mileage may vary.

Always make a backup of any existing firewall rules prior to running these scripts, they will DELETE all existing rules.


# how to setup
1) git clone https://github.com/zerqz/iptables-vpn-kill

2) cd iptables-vpn-kill

3) chmod +x up.sh && chmod +x down.sh

# how to use
1) connect to your vpn provider as usual

2) run ./up.sh

# how to disconnect
1) run ./down.sh
