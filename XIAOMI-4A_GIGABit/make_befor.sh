#!/bin/bash


sed -i 's/192.168.1.1/192.168.32.1/g' package/base-files/files/bin/config_generate

cd ./package/
git clone https://github.com/jerrykuku/luci-theme-argon.git
cd ../
sed -i 's/luci-theme-bootstrap/luci-theme-argon/' feeds/luci/collections/luci/Makefile
./scripts/feeds update -a && ./scripts/feeds install -a
