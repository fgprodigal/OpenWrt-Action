#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================

sed -i '/$IPT -A SS_SPEC_WAN_FW -d 240.0.0.0\/4 -j RETURN/a \
        $IPT -A SS_SPEC_WAN_FW -m ipp2p --edk --dc --kazaa --gnu --bit --apple --winmx --soul --ares -j RETURN
' package/lean/luci-app-ssr-plus/root/usr/bin/ssr-rules

sed -i '/$ipt -A SS_SPEC_TPROXY -p udp -d $SERVER -j RETURN/a \
        $ipt -A SS_SPEC_TPROXY -p udp -m ipp2p --edk --bit --kazaa --gnu -j RETURN
' package/lean/luci-app-ssr-plus/root/usr/bin/ssr-rules

sed -i '/$iptables_nat -N PSW_ACL/i \
	$iptables_nat -A PSW -m ipp2p --edk --dc --kazaa --gnu --bit --apple --winmx --soul --ares -j RETURN
' feeds/lienol/lienol/luci-app-passwall/root/usr/share/passwall/iptables.sh

sed -i '/$iptables_mangle -N PSW_ACL/i \
	$iptables_mangle -A PSW -p udp -m ipp2p --edk --bit --kazaa --gnu -j RETURN
' feeds/lienol/lienol/luci-app-passwall/root/usr/share/passwall/iptables.sh

sed -i 's/ +luci-theme-bootstrap//g' feeds/luci/collections/luci/Makefile

sed -i "s/echo \"DISTRIB_DESCRIPTION='OpenWrt '\"/echo \"DISTRIB_DESCRIPTION='OpenWrt Compiled by Ray '\"/g" package/lean/default-settings/files/zzz-default-settings

sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate
sed -i 's/192.168.2.1/10.0.0.1/g' package/base-files/files/bin/config_generate

chmod +x files/etc/init.d/redsocks
