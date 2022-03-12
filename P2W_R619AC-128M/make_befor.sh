#!/bin/bash

#允许ROOT编译
export FORCE_UNSAFE_CONFIGURE=1

#报错修复

cp /usr/bin/upx /workdir/openwrt/staging_dir/host/bin/
cp /usr/bin/upx-ucl /workdir/openwrt/staging_dir/host/bin/

ls

sed -i 's/OpenWrt/R619ac/g' package/base-files/files/bin/config_generate

#修改后台IP
sed -i 's/192.168.1.1/192.168.123.1/g' package/base-files/files/bin/config_generate
#修改主题
 rm -rf package/lean/luci-theme-argon

git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat.git package/lean/luci-theme-opentomcat
git clone https://github.com/garypang13/luci-theme-edge.git package/lean/luci-theme-edge


sed -i "s/OpenWrt /NIXEVOL build $(TZ=UTC-8 date "+%Y.%m.%d")@ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings

