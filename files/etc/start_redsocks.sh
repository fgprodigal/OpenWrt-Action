#!/bin/sh

if [ -e "/var/run/redsocks.pid" ]; then
	kill $(cat /var/run/redsocks.pid)
	rm /var/run/redsocks.pid
fi

iptables -t nat -D PREROUTING -p tcp -j REDSOCKS >/dev/null 2>&1
iptables -t nat -F REDSOCKS > /dev/null 2>&1 && iptables -t nat -X REDSOCKS > /dev/null 2>&1

ipset -F internal_list >/dev/null 2>&1 && ipset -X internal_list >/dev/null 2>&1
ipset -! create internal_list nethash && ipset flush internal_list

iptables -t nat -N REDSOCKS
iptables -t nat -I PREROUTING 1 -p tcp -j REDSOCKS
iptables -t nat -A REDSOCKS -d 220.171.4.48 -j RETURN
iptables -t nat -A REDSOCKS -p tcp -m set --match-set internal_list dst -j REDIRECT --to-ports 11111
iptables -t nat -A REDSOCKS -p tcp -d 192.168.0.0/16 -j REDIRECT --to-ports 11111

redsocks -c /etc/redsocks.conf -p /var/run/redsocks.pid
