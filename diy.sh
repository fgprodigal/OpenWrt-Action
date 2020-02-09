#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================

mv -f .config .config.bak

echo 'src-git lienol https://github.com/Lienol/openwrt-package' >> feeds.conf.default
./scripts/feeds clean
./scripts/feeds update -a
rm -rf feeds/lienol/lienol/ipt2socks
rm -rf feeds/lienol/lienol/shadowsocksr-libev
rm -rf feeds/lienol/lienol/pdnsd-alt
rm -rf feeds/lienol/package/verysync
rm -rf feeds/lienol/lienol/luci-app-verysync
rm -rf package/lean/kcptun
rm -rf package/lean/trojan
rm -rf package/lean/v2ray
rm -rf package/lean/luci-app-kodexplorer
rm -rf package/lean/luci-app-pppoe-relay
rm -rf package/lean/luci-app-pptp-server
rm -rf package/lean/luci-app-v2ray-server
./scripts/feeds install -a

ln -sf ../../../feeds/lienol/package/trojan package/feeds/lienol/trojan
ln -sf ../../../feeds/lienol/package/kcptun package/feeds/lienol/kcptun
ln -sf ../../../feeds/lienol/package/v2ray package/feeds/lienol/v2ray

#rm -rf package/lean/luci-theme-argon
#git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/lean/luci-theme-argon

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

mv -f .config.bak .config
