#!/bin/bash

#允许ROOT编译
export FORCE_UNSAFE_CONFIGURE=1

#报错修复

cp /usr/bin/upx /workdir/openwrt/staging_dir/host/bin/
cp /usr/bin/upx-ucl /workdir/openwrt/staging_dir/host/bin/

ls
#修改后台IP
sed -i 's/192.168.1.1/192.168.31.1/g' package/base-files/files/bin/config_generate
#修改默认主题(lede暂不需要)
cd ./package/
git clone https://github.com/jerrykuku/luci-theme-argon.git
cd ../
sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

