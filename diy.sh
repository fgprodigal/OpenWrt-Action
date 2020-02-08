#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================

rm -rf package/lean/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon

sed -i '/$IPT -A SS_SPEC_WAN_FW -d 240.0.0.0\/4 -j RETURN/a \
        $IPT -A SS_SPEC_WAN_FW -m ipp2p --edk --dc --kazaa --gnu --bit --apple --winmx --soul --ares -j RETURN
' package/lean/luci-app-ssr-plus/root/usr/bin/ssr-rules

sed -i '/$ipt -A SS_SPEC_TPROXY -p udp -d $SERVER -j RETURN/a \
        $ipt -A SS_SPEC_TPROXY -p udp -m ipp2p --edk --bit --kazaa --gnu -j RETURN
' package/lean/luci-app-ssr-plus/root/usr/bin/ssr-rules

#./scripts/feeds update -a
#./scripts/feeds install -a

sed -i 's/ +luci-theme-bootstrap//g' feeds/luci/collections/luci/Makefile
