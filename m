Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E780C2D0CA
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 19:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC400206D8
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 19:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=openedev.com header.i=@openedev.com header.b="FJkY50FN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbfLOTAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 14:00:25 -0500
Received: from se15p.web-hosting.com ([198.54.122.235]:55939 "EHLO
        se15p.web-hosting.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726146AbfLOTAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 14:00:24 -0500
Received: from [68.65.123.203] (helo=server153.web-hosting.com)
        by se18.registrar-servers.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <akash@openedev.com>)
        id 1igXp3-0000FJ-OY; Sun, 15 Dec 2019 09:36:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=openedev.com; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5zj0shl15ES5qDsvvytCNaNtROHrqNPVUl5RHKFbRRg=; b=FJkY50FN2m1mnbbyqDgdU7qu7U
        vwNo3adf3NbikqyrqXeWGjTWToQCAYwTgQB3WnfCBkQkSROYtwoW9MISAGNaqPWDUw8k+UizS/vG5
        Yc0Sr03b94CN1cLCNNxe5T40NZUguXDP7pDqJ83hdUJuBcOUIBhEj6ArdUy9exCdgqzoTNsQNrpAX
        7IoNi1mNYQIcxRXHaKTSrqPa4/vCDWR+0D/fKKOs3DM5E8DAS2K6RKydg+EybxxhHC2WWt5MPDN5Q
        XP/v6f7ow0io94jj8cAh+4Qh5YvOO50e6HyBfTDm+4Ca8kuNO4GNPXu3Y+89PLgWPaElYd9eSHPic
        RdkQ0k3w==;
Received: from [49.36.128.5] (port=59799 helo=localhost.localdomain)
        by server153.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <akash@openedev.com>)
        id 1igXoo-000nzF-Gg; Sun, 15 Dec 2019 12:36:39 -0500
From:   Akash Gajjar <akash@openedev.com>
To:     heiko@sntech.de
Cc:     jagan@openedev.com, Akash Gajjar <akash@openedev.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Douglas Anderson <dianders@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Andy Yan <andy.yan@rock-chips.com>, Nick Xie <nick@khadas.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kever Yang <kever.yang@rock-chips.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Vivek Unune <npcomplete13@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: add ROCK Pi S DTS support
Date:   Sun, 15 Dec 2019 23:03:08 +0530
Message-Id: <20191215173318.16385-1-akash@openedev.com>
X-Mailer: git-send-email 2.17.1
X-OutGoing-Spam-Status: No, score=-1.0
X-Originating-IP: 68.65.123.203
X-SpamExperts-Domain: nctest.net
X-SpamExperts-Username: whmcalls3
Authentication-Results: registrar-servers.com; auth=pass (login) smtp.auth=whmcalls3@nctest.net
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00423862851838)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0fi3oD8HEy9ysrsB6Ile+oipSDasLI4SayDByyq9LIhV3NwLXiK9LlnX
 qwLx4kMoq0TNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3Kk502M/hntTzIKfCMISdhHXTA
 YTyyIfs1cqM+JexaJLwYntLwFjolRFhTnXQDnB9P2e84PReenR5LSk2iUS2Af05Pal5SZwZh8dy2
 Fa67Fl4+Oc8tufITealG6MtpeGac3DYt+BDEJR1lgqmSCJDhQl6lTwWcvbaZbWieihNdGQNGSJxR
 C4MBuVqVtZLxSEtj+fHnOfi4UZg9u6/YGx9QV+zId7Fm0NXh2KWXCE3f01yEIlp2iAclkrimW38T
 9Tb8Ts1OFZCJnqICuBP35KwNAnl/VMjHUdMAogouFi8FrQ9mYOU/XB1KSiNVg+cbuxYxa2Aop7eI
 c+mBKaMDVOs3iLMZyoJH4ecRQrRYN/OrSDl8Vk0Pa0DwkDQhZRmGDC02imPF2ji/6HmsZPf1qB3+
 nFNiLZt/QXQnOBRD+jq1HsINMHXcElWWPWoWZV7l7hAfHyxxk8Sjs3o9/k8nLBnptAP6ED+kMe0f
 6T8yD2Ye6CPhlfGBForr3LaUZ2DRA29tXCh2+LQfEc98FHvNCYfCutsLx238JXd8QsFUL8BLk+8W
 MvcZwcErvx7aHfkXXj9O58fMnqZUTt7CyKlJUh+zhiybuqDenzVX4+8THDFBpVfu9ObqeYXg8NqL
 4RQdsFskIMVlx3kpAAgFKa6cveEfQ1sONqcYt8QNJCyN/ux+WoxQGKDre32lxgGctzrZwMfaC3G/
 sG7WSBh053rh3Jn0Yu3G8yPqLiUhcrqCspK0ihwuxN5wGVxm8rYIYSqDP1da70jJmTmqIy7XBC0Y
 oVo+sDxIPj1UU4msT2Odp9D6f/N1xSLkVtFDhs2pVCzg/6su8DjltttWRLh6YZHfZDlxqtgKM0ng
 UIO8/7FVNN6Jljh3uEfeTTa3VO3u5HRsz0s8Db1PmgmzCcMa7ulPKQwljdxbXpCgbiKBsA+Ddi6m
 awf7qIPrXD/wjVs/n8fM5ydr4VRbSFCvnbggoY4Wvq8a9PDk3+iNqiYKhZaJO2iXygidb7xKf9ye
 n1ptsyeNpBLGYEQKJVyp/FQfUJeyh3UYNr1P8PrBEjUzBQOhtbGwOd/74O4hBSz/kkmPgL+fgIgu
 BWHJWcnjJ9Yw6nh4SabxNBlhRZKXVntiqJqwMz/WEzMRoKk+qdPdN+VHhkPkWFLLL/MajuTZZYrm
 IMPpJ01xNSLp8yK4HDX6CXKW1cjrmvSDyiGG9+F7gBuhhNiu6O9mcHFleJWRxdnH7qtGkGOZyOYN
 g9LcQCKZJyjZYhbcjZvoDgYD3LnUviLybo/lpLC3HHASJNUmoOHSoqgqxfHmWRkdQL1gXJvwL5op
 HNLdfid/oune33LSDO2jwIIX2HH6/Xaa2YE7nuBo2iwEIN3pGn5OoRY51umiSqH1CKu9nM8fKghZ
 uFuu++HSP4Hpd2sDdKgNSxpke6tG5/V0WQwo339q0aZI3qbhXsaDdLgW9bry4KJcrxSUzWDT2Gb/
 yQXL5tP3WJd7sb8yEkSOtPpidAKWF8gSL91Ajw1AlIFKkYk=
X-Report-Abuse-To: spam@se16.registrar-servers.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ROCK Pi S is RK3308 based SBC from radxa.com. ROCK Pi S has a,
- 256MB/512MB DDR3 RAM
- SD, NAND flash (optional on board 1/2/4/8Gb)
- 100MB ethernet, PoE (optional)
- Onboard 802.11 b/g/n wifi + Bluetooth 4.0 Module
- USB2.0 Type-A HOST x1
- USB3.0 Type-C OTG x1
- 26-pin expansion header
- USB Type-C DC 5V Power Supply

This patch enables
- Console
- NAND Flash
- SD Card

Signed-off-by: Akash Gajjar <akash@openedev.com>
---
 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3308-rock-pi-S.dts    | 221 ++++++++++++++++++
 3 files changed, 227 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3308-rock-pi-S.dts

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index d9847b306b83..48d40c928d45 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -422,6 +422,11 @@ properties:
           - const: radxa,rockpi4
           - const: rockchip,rk3399
 
+      - description: Radxa ROCK Pi S
+        items:
+          - const: radxa,rockpis
+          - const: rockchip,rk3308
+
       - description: Radxa Rock2 Square
         items:
           - const: radxa,rock2-square
diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 48fb631d5451..cc9e8c824980 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -2,6 +2,7 @@
 dtb-$(CONFIG_ARCH_ROCKCHIP) += px30-evb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-evb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-roc-cc.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-rock-pi-S.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-a1.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-evb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-rock64.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-S.dts b/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-S.dts
new file mode 100644
index 000000000000..e5fae451c631
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3308-rock-pi-S.dts
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Akash Gajjar <akash@openedev.com>
+ * Copyright (c) 2019 Jagan Teki <jagan@openedev.com>
+ */
+
+/dts-v1/;
+#include "rk3308.dtsi"
+
+/ {
+	model = "Radxa ROCK Pi S";
+	compatible = "radxa,rockpis", "rockchip,rk3308";
+
+	chosen {
+		stdout-path = "serial0:1500000n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&green_led_gio>, <&heartbeat_led_gpio>;
+
+		green-led {
+			label = "rockpis:green:power";
+			gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "default-on";
+			default-state = "on";
+		};
+
+		blue-led {
+			label = "rockpis:blue:user";
+			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_enable_h>;
+		reset-gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>;
+	};
+
+	vcc5v0_sys: vcc5v0-sys {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
+
+	vdd_core: vdd-core {
+		compatible = "pwm-regulator";
+		pwms = <&pwm0 0 5000 1>;
+		regulator-name = "vdd_core";
+		regulator-min-microvolt = <827000>;
+		regulator-max-microvolt = <1340000>;
+		regulator-init-microvolt = <1015000>;
+		regulator-settling-time-up-us = <250>;
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vdd_log: vdd-log {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_log";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1050000>;
+		regulator-max-microvolt = <1050000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc_ddr: vcc-ddr {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_ddr";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc_1v8: vcc-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_1v8";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_io>;
+	};
+
+	vcc_io: vcc-io {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_io";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc5v0_otg: vcc5v0-otg {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_otg";
+		regulator-always-on;
+		gpio = <&gpio0 RK_PC5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		pinctrl-names = "default";
+		pinctrl-0 = <&otg_vbus_drv>;
+		vin-supply = <&vcc5v0_sys>;
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&vdd_core>;
+};
+
+&emmc {
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	supports-sd;
+	disable-wp;
+	non-removable;
+	num-slots = <1>;
+	vin-supply = <&vcc_io>;
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&sdmmc {
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	max-frequeency = <150000000>;
+	supports-sd;
+	disable-wp;
+	num-slots = <1>;
+	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_det &sdmmc_bus4>;
+	card-detect-delay = <800>;
+	status = "okay";
+};
+
+&spi2 {
+	status = "okay";
+	max-freq = <10000000>;
+};
+
+&pinctrl {
+	pinctrl-names = "default";
+	pinctrl-0 = <&rtc_32k>;
+
+	leds {
+		green_led_gio: green-led-gpio {
+			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		heartbeat_led_gpio: heartbeat-led-gpio {
+			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	usb {
+		otg_vbus_drv: otg-vbus-drv {
+			rockchip,pins = <0 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	sdio-pwrseq {
+		wifi_enable_h: wifi-enable-h {
+			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		wifi_host_wake: wifi-host-wake {
+			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+};
+
+&pwm0 {
+	status = "okay";
+	pinctrl-0 = <&pwm0_pin_pull_down>;
+};
+
+&saradc {
+	vref-supply = <&vcc_1v8>;
+	status = "okay";
+};
+
+&sdio {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	bus-width = <4>;
+	max-frequency = <1000000>;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	supports-sdio;
+	keep-power-in-suspend;
+	mmc-pwrseq = <&sdio_pwrseq>;
+	non-removable;
+	sd-uhs-sdr104;
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart4_xfer &uart4_rts &uart4_cts>;
+	status = "okay";
+};
-- 
2.17.1

