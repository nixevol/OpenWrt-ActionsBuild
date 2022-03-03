#!/bin/bash
rm -f target/linux/ramips/dts/mt7628an_xiaomi_mir4a-100m.dts
cat >> target/linux/ramips/dts/mt7628an_xiaomi_mir4a-100m.dts << EOF
//SPDX-License-Identifier: GPL-2.0-or-later OR MIT
/dts-v1/;
#include "mt7628an.dtsi"
#include <dt-bindings/gpio/gpio.h>
#include <dt-bindings/input/input.h>
/ {
	compatible = "xiaomi,mir4a-100m", "mediatek,mt7628an-soc";
	model = "Xiaomi Mi Router 4A (100M Edition)";
	chosen {
		bootargs = "console=ttyS0,115200";
	};
	aliases {
		led-boot = &power_yellow;
		led-failsafe = &power_yellow;
		led-running = &power_blue;
		led-upgrade = &power_yellow;
	};
	leds {
		compatible = "gpio-leds";
		power_blue: power_blue {
			label = "mir4a-100m:blue:power";
			gpios = <&gpio0 11 GPIO_ACTIVE_LOW>;
		};
		power_yellow: power_yellow {
			label = "mir4a-100m:yellow:power";
			gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
		};
	};
	keys {
		compatible = "gpio-keys";
		reset {
			label = "reset";
			gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
			linux,code = <KEY_RESTART>;
		};
	};
};
&spi0 {
	status = "okay";
	flash@0 {
		compatible = "jedec,spi-nor";
		reg = <0>;
		spi-max-frequency = <10000000>;
		partitions {
			compatible = "fixed-partitions";
			#address-cells = <1>;
			#size-cells = <1>;
			partition@0 {
				label = "u-boot";
				reg = <0x0 0x30000>;
				read-only;
			};
			partition@30000 {
				label = "u-boot-env";
				reg = <0x30000 0x10000>;
				read-only;
			};
			factory: partition@40000 {
				label = "factory";
				reg = <0x40000 0x10000>;
				read-only;
			};
			partition@50000 {
				label = "firmware";
				reg = <0x50000 0xfb0000>;
				compatible = "denx,uimage";
			};
		};
	};
};
&pcie {
	status = "okay";
};
&pcie0 {
	wifi@0,0 {
		compatible = "mediatek,mt76";
		reg = <0x0000 0 0 0 0>;
		mediatek,mtd-eeprom = <&factory 0x8000>;
		ieee80211-freq-limit = <5000000 6000000>;
	};
};
&state_default {
	gpio {
		ralink,group = "gpio", "wdt", "wled_an";
		ralink,function = "gpio";
	};
};
&ethernet {
	mtd-mac-address = <&factory 0x4>;
	mtd-mac-address-increment = <(-1)>;
};
&esw {
	mediatek,portmap = <0x2f>;
	mediatek,portdisable = <0x2a>;
};
&wmac {
	status = "okay";
};

EOF

sed -i '/define Device\/xiaomi_mi-router-4a-100m/{:a;n;s/IMAGE_SIZE := 14976k/IMAGE_SIZE := 16064k/g;/TARGET_DEVICES += xiaomi_mi-router-4a-100m/!ba}' target/linux/ramips/image/mt76x8.mk
