cat >> ./target/linux/ramips/dts/mt7628an_xiaomi_mi-router-4a-100mEditon.dtsi << EOF
// SPDX-License-Identifier: GPL-2.0-or-later OR MIT

#include "mt7628an.dtsi"

#include <dt-bindings/gpio/gpio.h>
#include <dt-bindings/input/input.h>

/ {
	aliases {
		led-boot = &led_power_yellow;
		led-failsafe = &led_power_yellow;
		led-running = &led_power_blue;
		led-upgrade = &led_power_yellow;
	};

	chosen {
		bootargs = "console=ttyS0,115200";
	};

	leds {
		compatible = "gpio-leds";

		led_power_blue: power_blue {
			label = "blue:power";
			gpios = <&gpio 11 GPIO_ACTIVE_LOW>;
		};

		led_power_yellow: power_yellow {
			label = "yellow:power";
			gpios = <&gpio 44 GPIO_ACTIVE_LOW>;
		};
	};

	keys {
		compatible = "gpio-keys";

		reset {
			label = "reset";
			gpios = <&gpio 38 GPIO_ACTIVE_LOW>;
			linux,code = <KEY_RESTART>;
		};
	};
};

&spi0 {
	status = "okay";

	flash0: flash@0 {
		compatible = "jedec,spi-nor";
		reg = <0>;
		spi-max-frequency = <10000000>;

		partitions: partitions {
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
				read-only;
			};

			/* additional partitions in DTS */
		};
	};
};

&state_default {
	gpio {
		groups = "gpio", "wdt", "wled_an";
		function = "gpio";
	};
};

&wmac {
	status = "okay";
};

EOF

rm -f ./target/linux/ramips/dts/mt7628an_xiaomi_mi-router-4a-100m.dts

cat >> ./target/linux/ramips/dts/mt7628an_xiaomi_mi-router-4a-100m.dts << EOF
// SPDX-License-Identifier: GPL-2.0-or-later OR MIT

#include "mt7628an_xiaomi_mi-router-4a-100mEditon.dtsi"

/ {
	compatible = "xiaomi,mi-router-4a-100m", "mediatek,mt7628an-soc";
	model = "Xiaomi Mi Router 4A (100M Edition)";
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

&ethernet {
	mtd-mac-address = <&factory 0x4>;
	mtd-mac-address-increment = <(-1)>;
};

&esw {
	mediatek,portmap = <0x3e>;
	mediatek,portdisable = <0x2a>;
};
EOF

sed -i '/define Device\/xiaomi_mi-router-4a-100m/{:a;n;s/IMAGE_SIZE := 14976k/IMAGE_SIZE := 16064k/g;/TARGET_DEVICES += xiaomi_mi-router-4a-100m/!ba}' ./target/linux/ramips/image/mt76x8.mk
