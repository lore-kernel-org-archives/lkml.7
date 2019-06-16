Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0051EC31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 20:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A342073F
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 20:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfFPUwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 16:52:38 -0400
Received: from outgoing2.flk.host-h.net ([188.40.0.84]:55185 "EHLO
        outgoing2.flk.host-h.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfFPUwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 16:52:37 -0400
Received: from www31.flk1.host-h.net ([188.40.1.173])
        by antispam3-flk1.host-h.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.89)
        (envelope-from <justin.swartz@risingedge.co.za>)
        id 1hcc8f-0002Cg-6k; Sun, 16 Jun 2019 22:52:34 +0200
Received: from [130.255.73.16] (helo=v01.28459.vpscontrol.net)
        by www31.flk1.host-h.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <justin.swartz@risingedge.co.za>)
        id 1hcc8Z-0001Ky-QF; Sun, 16 Jun 2019 22:52:27 +0200
From:   Justin Swartz <justin.swartz@risingedge.co.za>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Justin Swartz <justin.swartz@risingedge.co.za>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH] ARM: dts: add device tree for Mecer Xtreme Mini S6
Date:   Sun, 16 Jun 2019 20:47:45 +0000
Message-Id: <20190616204746.21001-1-justin.swartz@risingedge.co.za>
X-Mailer: git-send-email 2.11.0
X-Authenticated-Sender: justin.swartz@risingedge.co.za
X-Virus-Scanned: Clear (ClamAV 0.100.3/25482/Sun Jun 16 09:58:03 2019)
X-Originating-IP: 188.40.1.173
X-SpamExperts-Domain: risingedge.co.za
X-SpamExperts-Username: 
Authentication-Results: host-h.net; auth=pass (login) smtp.auth=@risingedge.co.za
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00288349527902)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0aEcKiGOen0TgGQo14QTNxSpSDasLI4SayDByyq9LIhVHere0oDd3L9u
 imP3LL7ogkTNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3Kf0cVcrGOWHuvhhsNFanSQ+63
 p/UbUTcmIpuXtxg/CxkoU3DKFYUc83wlJ68apqUflsInmcmrhWKh5CGxWvoqRSom1N6/V6eFJqiY
 8AHI8ZE2UOjrQY19nYX/K9cXl+nRiJs637DFkSoL4pcNpzwOwYXt6ymoFHaG7BQtEYvFCSqHkTDj
 dyZcrshowL7tH1pWEOpHXO3AWQB4otYhXjSOOlnZeZkTpSWjdKDr98cJY3GhoSe4G2e3oZQMPPCL
 TET2QWyC1bDOw2oEv3DmjqX5Rdlnibl3vcBqVmvQB4A18acTZXv+E0Ab+jT9e8RETzDnmH6eQvWp
 DWTULXV1jJ5bfceEJeNruLKdflVX7oFNsdHVhnpudkCyIg6Nob+f0OfCg2lBMt3xu9nbye2CdJLN
 jSo1M+TSg3TNDI3/M5s9/ot3ko3rrae7IifWc6pL546YUVQwaYLh3di89W/ji5iahyCgJgyv93tC
 61cbiLYl3RCqADG/Ryndzp4OfbK7c6EqHwlqvaI+zok/BsKQK4gft4+8sY8CNaDDoRMm0CGce/fp
 WUXurEbGCiZ0ePvZjCuJdbYb9IXfYGRpVS/0hA4Mwkg/wxsjmSXwdCAtc5U5IMGqr3wBwEeX6Ai5
 5FPRpzhbYqsuNEW45+y/2kiUpWy9c957+6R4kroQiAThpzOdFqFvbdRuq0FZjQOwDKXnhaC6dkwF
 9ybSMhHO+IPM0C985aNe1vwE2plJLdOGZ2rsAWflnmUXwJv1R9bnj+xoJG4VhUotTJ0/e5GmrorL
 FK/ZMLGo5vAZZCvXfX7a9yMLanTRjdK3JtbOY4V5u4SqNrbdxyGLEIoLEuuC4P/fyEEgA3CnflZn
 bjDB2+RGRgaXth2/9YEbMsGSn6owqJN0kS7MUpAEhFoAxikOdx3ALFboD0vMokt+4lO8Qp33tUy6
 u+wammt1kz0RzA9JhvR8ZmWiOKLc7g6Iuozoj6Fx1fwaiDwJWw42swm4bO6gacpMpzJ5RNWFoIkg
 vLC7uMZSLKkLPlzqsPnNmrTFfBI+gCHkFgyh9jAE9PwtDurXCCybWAnihjA708Lg3Y2gXyaf+rIt
 vvthbyiMZOAfvJjwL84MO4Vozqbzv/NmqBexmg1oMlu3UCyNNO7qENlLqkRemjF1A1q3g0ZrubFa
 n/xi+AGXOIO97ttnHrPmGyC6rR21+9c=
X-Report-Abuse-To: spam@antispammaster.host-h.net
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Mecer Xtreme Mini S6 features a Rockchip RK3229 SoC,
1GB DDR3 RAM, 8GB eMMC, MicroSD port, 10/100Mbps Ethernet,
Realtek 8723BS WLAN module, 2 x USB 2.0 ports, HDMI output,
and S/PDIF output.

Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
---
 arch/arm/boot/dts/Makefile        |   1 +
 arch/arm/boot/dts/rk3229-xms6.dts | 286 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 287 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3229-xms6.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index dab2914fa293..6fbd7c304f62 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -902,6 +902,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += \
 	rk3188-radxarock.dtb \
 	rk3228-evb.dtb \
 	rk3229-evb.dtb \
+	rk3229-xms6.dtb \
 	rk3288-evb-act8846.dtb \
 	rk3288-evb-rk808.dtb \
 	rk3288-fennec.dtb \
diff --git a/arch/arm/boot/dts/rk3229-xms6.dts b/arch/arm/boot/dts/rk3229-xms6.dts
new file mode 100644
index 000000000000..9b666fa66292
--- /dev/null
+++ b/arch/arm/boot/dts/rk3229-xms6.dts
@@ -0,0 +1,286 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include "rk3229.dtsi"
+
+/ {
+	model = "Rockchip RK3229 (Mecer Xtreme Mini S6)";
+	compatible = "rockchip,rk3229-xms6", "rockchip,rk3229";
+
+	memory@60000000 {
+		device_type = "memory";
+		reg = <0x60000000 0x40000000>;
+	};
+
+	dc_12v: dc-12v-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "dc_12v";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
+
+	ext_gmac: ext_gmac {
+		compatible = "fixed-clock";
+		clock-frequency = <125000000>;
+		clock-output-names = "ext_gmac";
+		#clock-cells = <0>;
+	};
+
+	vcc_host: vcc-host-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio3 RK_PC4 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&host_vbus_drv>;
+		regulator-name = "vcc_host";
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vcc_sys>;
+	};
+
+	vcc_phy: vcc-phy-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		regulator-name = "vcc_phy";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vccio_1v8>;
+	};
+
+	vcc_sys: vcc-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&dc_12v>;
+	};
+
+	vccio_1v8: vccio-1v8-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vccio_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		vin-supply = <&vcc_sys>;
+	};
+
+	vccio_3v3: vccio-3v3-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vccio_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		vin-supply = <&vcc_sys>;
+	};
+
+	vdd_arm: vdd-arm-regulator {
+		compatible = "pwm-regulator";
+		pwms = <&pwm1 0 25000 1>;
+		pwm-supply = <&vcc_sys>;
+		regulator-name = "vdd_arm";
+		regulator-min-microvolt = <950000>;
+		regulator-max-microvolt = <1400000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vdd_log: vdd-log-regulator {
+		compatible = "pwm-regulator";
+		pwms = <&pwm2 0 25000 1>;
+		pwm-supply = <&vcc_sys>;
+		regulator-name = "vdd_log";
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <1300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	power-led {
+		compatible = "gpio-leds";
+
+		blue {
+			gpios = <&gpio3 21 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+	};
+};
+
+&cpu0 {
+	clock-frequency = <1464000000>;
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu1 {
+	clock-frequency = <1464000000>;
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu2 {
+	clock-frequency = <1464000000>;
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu3 {
+	clock-frequency = <1464000000>;
+	cpu-supply = <&vdd_arm>;
+};
+
+&vop {
+	status = "okay";
+};
+
+&vop_mmu {
+	status = "okay";
+};
+
+&iep_mmu {
+	status = "okay";
+};
+
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_phy {
+	status = "okay";
+};
+
+&emmc {
+	cap-mmc-highspeed;
+	disable-wp;
+	non-removable;
+	status = "okay";
+};
+
+&sdmmc {
+	cap-mmc-highspeed;
+	disable-wp;
+	status = "okay";
+};
+
+&gmac {
+	assigned-clocks = <&cru SCLK_MAC_SRC>;
+	assigned-clock-rates = <50000000>;
+	clock_in_out = "output";
+	phy-supply = <&vcc_phy>;
+	phy-mode = "rmii";
+	phy-handle = <&phy>;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		phy: phy@0 {
+			compatible = "ethernet-phy-id1234.d400", "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+			clocks = <&cru SCLK_MAC_PHY>;
+			resets = <&cru SRST_MACPHY>;
+			phy-is-integrated;
+		};
+	};
+};
+
+&gpu {
+	mali-supply = <&vdd_log>;
+	status = "okay";
+};
+
+&io_domains {
+	status = "okay";
+
+	vccio1-supply = <&vccio_3v3>;
+	vccio2-supply = <&vccio_1v8>;
+	vccio4-supply = <&vccio_3v3>;
+};
+
+&pinctrl {
+	usb {
+		host_vbus_drv: host-vbus-drv {
+			rockchip,pins = <3 RK_PC4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&pwm1 {
+	status = "okay";
+};
+
+&pwm2 {
+	status = "okay";
+};
+
+&tsadc {
+	rockchip,hw-tshut-mode = <0>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-0 = <&uart21_xfer>;
+	status = "okay";
+};
+
+&u2phy0 {
+	status = "okay";
+
+	u2phy0_otg: otg-port {
+		phy-supply = <&vcc_host>;
+		status = "okay";
+	};
+
+	u2phy0_host: host-port {
+		phy-supply = <&vcc_host>;
+		status = "okay";
+	};
+};
+
+&u2phy1 {
+	status = "okay";
+
+	u2phy1_otg: otg-port {
+		phy-supply = <&vcc_host>;
+		status = "okay";
+	};
+
+	u2phy1_host: host-port {
+		phy-supply = <&vcc_host>;
+		status = "okay";
+	};
+};
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
+
+&usb_host1_ehci {
+	status = "okay";
+};
+
+&usb_host1_ohci {
+	status = "okay";
+};
+
+&usb_host2_ehci {
+	status = "okay";
+};
+
+&usb_host2_ohci {
+	status = "okay";
+};
+
+&usb_otg {
+	status = "okay";
+};
-- 
2.11.0

