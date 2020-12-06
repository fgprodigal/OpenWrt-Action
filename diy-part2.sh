#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================

rm -rf package/lean/luci-theme-argon  
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon  

sed -i 's/redirect_https\t1/redirect_https\t0/g' package/network/services/uhttpd/files/uhttpd.config

sed -i '/$IPT -A SS_SPEC_WAN_FW -d 240.0.0.0\/4 -j RETURN/a \
        $IPT -A SS_SPEC_WAN_FW -m ipp2p --edk --dc --kazaa --gnu --bit --apple --winmx --soul --ares -j RETURN
' feeds/ssrplus/luci-app-ssr-plus/root/usr/bin/ssr-rules

sed -i '/$ipt -A SS_SPEC_TPROXY -p udp -d 240.0.0.0\/4 -j RETURN/a \
        $ipt -A SS_SPEC_TPROXY -p udp -m ipp2p --edk --bit --kazaa --gnu -j RETURN
' feeds/ssrplus/luci-app-ssr-plus/root/usr/bin/ssr-rules

sed -i 's/table.sort(key_table)/table.sort(key_table, function(a,b) return server_table[b]>server_table[c] end)/g' feeds/ssrplus/luci-app-ssr-plus/luasrc/model/cbi/shadowsocksr/client.lua


sed -i 's/ +luci-theme-bootstrap//g' feeds/luci/collections/luci/Makefile

sed -i '/uci commit luci/i\uci set luci.main.mediaurlbase="/luci-static/argon"' package/lean/default-settings/files/zzz-default-settings
sed -i "s/echo \"DISTRIB_DESCRIPTION='OpenWrt '\"/echo \"DISTRIB_DESCRIPTION='OpenWrt Compiled by Ray '\"/g" package/lean/default-settings/files/zzz-default-settings

sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate
sed -i 's/192.168.2.1/10.0.0.1/g' package/base-files/files/bin/config_generate
sed -i 's/\%C/\%C build by Ray/g' package/base-files/files/etc/banner
[ -f package/base-files/files/root/setup.sh ] && sed -i '/8.8.8.8/d' package/base-files/files/root/setup.sh
[ -f package/base-files/files/root/setup.sh ] && sed -i 's/192.168.2.1/10.0.0.1/g' package/base-files/files/root/setup.sh

# [ -e mod ] && cp -f mod/redsocks.init feeds/packages/net/redsocks/files/redsocks.init
