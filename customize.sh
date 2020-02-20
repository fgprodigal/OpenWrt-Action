#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================

git clone https://github.com/rufengsuixing/luci-app-adguardhome package/lean/luci-app-adguardhome

sed -i '/$IPT -A SS_SPEC_WAN_FW -d 240.0.0.0\/4 -j RETURN/a \
        $IPT -A SS_SPEC_WAN_FW -m ipp2p --edk --dc --kazaa --gnu --bit --apple --winmx --soul --ares -j RETURN
' package/lean/luci-app-ssr-plus/root/usr/bin/ssr-rules

sed -i '/$ipt -A SS_SPEC_TPROXY -p udp -d $SERVER -j RETURN/a \
        $ipt -A SS_SPEC_TPROXY -p udp -m ipp2p --edk --bit --kazaa --gnu -j RETURN
' package/lean/luci-app-ssr-plus/root/usr/bin/ssr-rules

sed -i '/$ipt_n -N PSW_ACL/i \
	$ipt_n -A PSW -m ipp2p --edk --dc --kazaa --gnu --bit --apple --winmx --soul --ares -j RETURN
' feeds/lienol/lienol/luci-app-passwall/root/usr/share/passwall/iptables.sh

sed -i '/$ipt_m -N PSW_ACL/i \
	$ipt_m -A PSW -p udp -m ipp2p --edk --bit --kazaa --gnu -j RETURN
' feeds/lienol/lienol/luci-app-passwall/root/usr/share/passwall/iptables.sh

sed -i 's/ +luci-theme-bootstrap//g' feeds/luci/collections/luci/Makefile

sed -i "s/echo \"DISTRIB_DESCRIPTION='OpenWrt '\"/echo \"DISTRIB_DESCRIPTION='OpenWrt Compiled by Ray '\"/g" package/lean/default-settings/files/zzz-default-settings

sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate
sed -i 's/192.168.2.1/10.0.0.1/g' package/base-files/files/bin/config_generate

[ -e mod ] && cp -f mod/redsocks.init feeds/packages/net/redsocks/files/redsocks.init