Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78833FC6194
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D5A721848
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="KuRC0WlY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731590AbfKHLV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:21:26 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:46050 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727591AbfKHLV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:21:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        To:From:Sender:Reply-To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xWoNsZE3eMam3epWhKXZzF+Fy3k0g8hZwl9dYn6J5Pc=; b=KuRC0WlYSc+O2RKjk5nxgZl5e
        j7MufiW4u/C55OYzLl8maB+J+eoVMpKcVb6qtlwu6JAUet/9J6jAqEOokAmsZ5aiACx4FDNUABt3g
        Z9okVaa2ySNzamJt/kAsbZC+bJ1s5Dz06ZcdlA5gNpbZe684BN0U6+P+37uGW8ExgD4UU=;
Received: from [2a02:790:ff:919:7ee9:d3ff:fe1f:a246] (helo=localhost)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iT2KK-0000ai-As; Fri, 08 Nov 2019 12:21:17 +0100
Received: from andi by localhost with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iT2IP-0004rP-4Q; Fri, 08 Nov 2019 12:19:17 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, andrew.smirnov@gmail.com,
        manivannan.sadhasivam@linaro.org, andreas@kemnade.info,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, j.neuschaefer@gmx.net,
        letux-kernel@openphoenux.org
Subject: [PATCH 2/2] ARM: dts: add devicetree entry for Tolino Shine 3
Date:   Fri,  8 Nov 2019 12:18:34 +0100
Message-Id: <20191108111834.18610-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191108111834.18610-1-andreas@kemnade.info>
References: <20191108111834.18610-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device is almost identical to the Kobo Clara HD. The only
spotted difference is the SoC. It contains an imx6sl
instead of an imx6sll.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/Makefile                 |   1 +
 arch/arm/boot/dts/imx6sl-tolino-shine3.dts | 326 +++++++++++++++++++++++++++++
 2 files changed, 327 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6sl-tolino-shine3.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f969c37729d5..1486615470b2 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -550,6 +550,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6qp-zii-rdu2.dtb
 dtb-$(CONFIG_SOC_IMX6SL) += \
 	imx6sl-evk.dtb \
+	imx6sl-tolino-shine3.dtb \
 	imx6sl-warp.dtb
 dtb-$(CONFIG_SOC_IMX6SLL) += \
 	imx6sll-evk.dtb \
diff --git a/arch/arm/boot/dts/imx6sl-tolino-shine3.dts b/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
new file mode 100644
index 000000000000..0ee49258f22c
--- /dev/null
+++ b/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
@@ -0,0 +1,326 @@
+// SPDX-License-Identifier: (GPL-2.0)
+/*
+ * Device tree for the Tolino Shine 3 ebook reader
+ *
+ * Name on mainboard is: 37NB-E60K00+4A4
+ * Serials start with: E60K02 (a number also seen in
+ * vendor kernel sources)
+ *
+ * This mainboard seems to be equipped with different SoCs.
+ * In the Toline Shine 3 ebook reader it is a i.MX6SL
+ *
+ * Copyright 2019 Andreas Kemnade
+ * based on works
+ * Copyright 2016 Freescale Semiconductor, Inc.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/gpio/gpio.h>
+#include "imx6sl.dtsi"
+#include "e60k02.dtsi"
+
+/ {
+	model = "Tolino Shine 3";
+	compatible = "kobo,tolino-shine3", "fsl,imx6sl";
+};
+
+&gpio_keys {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio_keys>;
+};
+
+&i2c1 {
+	pinctrl-names = "default","sleep";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	pinctrl-1 = <&pinctrl_i2c1_sleep>;
+};
+
+&i2c2 {
+	pinctrl-names = "default","sleep";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	pinctrl-1 = <&pinctrl_i2c2_sleep>;
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_gpio_keys: gpio-keysgrp {
+		fsl,pins = <
+			MX6SL_PAD_SD1_DAT1__GPIO5_IO08	0x17059	/* PWR_SW */
+			MX6SL_PAD_SD1_DAT4__GPIO5_IO12	0x17059	/* HALL_EN */
+		>;
+	};
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			MX6SL_PAD_LCD_DAT0__GPIO2_IO20	0x79
+			MX6SL_PAD_LCD_DAT1__GPIO2_IO21	0x79
+			MX6SL_PAD_LCD_DAT2__GPIO2_IO22	0x79
+			MX6SL_PAD_LCD_DAT3__GPIO2_IO23	0x79
+			MX6SL_PAD_LCD_DAT4__GPIO2_IO24	0x79
+			MX6SL_PAD_LCD_DAT5__GPIO2_IO25	0x79
+			MX6SL_PAD_LCD_DAT6__GPIO2_IO26	0x79
+			MX6SL_PAD_LCD_DAT7__GPIO2_IO27	0x79
+			MX6SL_PAD_LCD_DAT8__GPIO2_IO28	0x79
+			MX6SL_PAD_LCD_DAT9__GPIO2_IO29	0x79
+			MX6SL_PAD_LCD_DAT10__GPIO2_IO30	0x79
+			MX6SL_PAD_LCD_DAT11__GPIO2_IO31	0x79
+			MX6SL_PAD_LCD_DAT12__GPIO3_IO00	0x79
+			MX6SL_PAD_LCD_DAT13__GPIO3_IO01	0x79
+			MX6SL_PAD_LCD_DAT14__GPIO3_IO02	0x79
+			MX6SL_PAD_LCD_DAT15__GPIO3_IO03	0x79
+			MX6SL_PAD_LCD_DAT16__GPIO3_IO04	0x79
+			MX6SL_PAD_LCD_DAT17__GPIO3_IO05	0x79
+			MX6SL_PAD_LCD_DAT18__GPIO3_IO06	0x79
+			MX6SL_PAD_LCD_DAT19__GPIO3_IO07	0x79
+			MX6SL_PAD_LCD_DAT20__GPIO3_IO08	0x79
+			MX6SL_PAD_LCD_DAT21__GPIO3_IO09	0x79
+			MX6SL_PAD_LCD_DAT22__GPIO3_IO10	0x79
+			MX6SL_PAD_LCD_DAT23__GPIO3_IO11	0x79
+			MX6SL_PAD_LCD_CLK__GPIO2_IO15		0x79
+			MX6SL_PAD_LCD_ENABLE__GPIO2_IO16	0x79
+			MX6SL_PAD_LCD_HSYNC__GPIO2_IO17	0x79
+			MX6SL_PAD_LCD_VSYNC__GPIO2_IO18	0x79
+			MX6SL_PAD_LCD_RESET__GPIO2_IO19	0x79
+			MX6SL_PAD_KEY_COL3__GPIO3_IO30		0x79
+			MX6SL_PAD_KEY_ROW7__GPIO4_IO07		0x79
+			MX6SL_PAD_ECSPI2_MOSI__GPIO4_IO13	0x79
+			MX6SL_PAD_KEY_COL5__GPIO4_IO02		0x79
+			MX6SL_PAD_KEY_ROW6__GPIO4_IO05		0x79
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			MX6SL_PAD_I2C1_SCL__I2C1_SCL	 0x4001f8b1
+			MX6SL_PAD_I2C1_SDA__I2C1_SDA	 0x4001f8b1
+		>;
+	};
+
+	pinctrl_i2c1_sleep: i2c1grp-sleep {
+		fsl,pins = <
+			MX6SL_PAD_I2C1_SCL__I2C1_SCL	 0x400108b1
+			MX6SL_PAD_I2C1_SDA__I2C1_SDA	 0x400108b1
+		>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <
+			MX6SL_PAD_I2C2_SCL__I2C2_SCL	 0x4001f8b1
+			MX6SL_PAD_I2C2_SDA__I2C2_SDA	 0x4001f8b1
+		>;
+	};
+
+	pinctrl_i2c2_sleep: i2c2grp-sleep {
+		fsl,pins = <
+			MX6SL_PAD_I2C2_SCL__I2C2_SCL	 0x400108b1
+			MX6SL_PAD_I2C2_SDA__I2C2_SDA	 0x400108b1
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX6SL_PAD_REF_CLK_24M__I2C3_SCL  0x4001f8b1
+			MX6SL_PAD_REF_CLK_32K__I2C3_SDA  0x4001f8b1
+		>;
+	};
+
+	pinctrl_led: ledgrp {
+		fsl,pins = <
+			MX6SL_PAD_SD1_DAT6__GPIO5_IO07 0x17059
+		>;
+	};
+
+	pinctrl_lm3630a_bl_gpio: lm3630a-bl-gpiogrp {
+		fsl,pins = <
+			MX6SL_PAD_EPDC_PWRCTRL3__GPIO2_IO10		0x10059 /* HWEN */
+		>;
+	};
+
+	pinctrl_ricoh_gpio: ricoh_gpiogrp {
+		fsl,pins = <
+			MX6SL_PAD_SD1_CLK__GPIO5_IO15                  0x1b8b1 /* ricoh619 chg */
+			MX6SL_PAD_SD1_DAT0__GPIO5_IO11        0x1b8b1 /* ricoh619 irq */
+			MX6SL_PAD_KEY_COL2__GPIO3_IO28                         0x1b8b1 /* ricoh619 bat_low_int */
+		>;
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX6SL_PAD_UART1_TXD__UART1_TX_DATA 0x1b0b1
+			MX6SL_PAD_UART1_RXD__UART1_TX_DATA 0x1b0b1
+		>;
+	};
+
+	pinctrl_usbotg1: usbotg1grp {
+		fsl,pins = <
+			MX6SL_PAD_EPDC_PWRCOM__USB_OTG1_ID 0x17059
+		>;
+	};
+
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX6SL_PAD_SD2_CMD__SD2_CMD		0x17059
+			MX6SL_PAD_SD2_CLK__SD2_CLK		0x13059
+			MX6SL_PAD_SD2_DAT0__SD2_DATA0		0x17059
+			MX6SL_PAD_SD2_DAT1__SD2_DATA1		0x17059
+			MX6SL_PAD_SD2_DAT2__SD2_DATA2		0x17059
+			MX6SL_PAD_SD2_DAT3__SD2_DATA3		0x17059
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2grp-100mhz {
+		fsl,pins = <
+			MX6SL_PAD_SD2_CMD__SD2_CMD		0x170b9
+			MX6SL_PAD_SD2_CLK__SD2_CLK		0x130b9
+			MX6SL_PAD_SD2_DAT0__SD2_DATA0		0x170b9
+			MX6SL_PAD_SD2_DAT1__SD2_DATA1		0x170b9
+			MX6SL_PAD_SD2_DAT2__SD2_DATA2		0x170b9
+			MX6SL_PAD_SD2_DAT3__SD2_DATA3		0x170b9
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2grp-200mhz {
+		fsl,pins = <
+			MX6SL_PAD_SD2_CMD__SD2_CMD		0x170f9
+			MX6SL_PAD_SD2_CLK__SD2_CLK		0x130f9
+			MX6SL_PAD_SD2_DAT0__SD2_DATA0		0x170f9
+			MX6SL_PAD_SD2_DAT1__SD2_DATA1		0x170f9
+			MX6SL_PAD_SD2_DAT2__SD2_DATA2		0x170f9
+			MX6SL_PAD_SD2_DAT3__SD2_DATA3		0x170f9
+		>;
+	};
+
+	pinctrl_usdhc2_sleep: usdhc2grp-sleep {
+		fsl,pins = <
+			MX6SL_PAD_SD2_CMD__GPIO5_IO04		0x100f9
+			MX6SL_PAD_SD2_CLK__GPIO5_IO05		0x100f9
+			MX6SL_PAD_SD2_DAT0__GPIO5_IO01		0x100f9
+			MX6SL_PAD_SD2_DAT1__GPIO4_IO30		0x100f9
+			MX6SL_PAD_SD2_DAT2__GPIO5_IO03		0x100f9
+			MX6SL_PAD_SD2_DAT3__GPIO4_IO28		0x100f9
+		>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX6SL_PAD_SD3_CMD__SD3_CMD	0x11059
+			MX6SL_PAD_SD3_CLK__SD3_CLK	0x11059
+			MX6SL_PAD_SD3_DAT0__SD3_DATA0	0x11059
+			MX6SL_PAD_SD3_DAT1__SD3_DATA1	0x11059
+			MX6SL_PAD_SD3_DAT2__SD3_DATA2	0x11059
+			MX6SL_PAD_SD3_DAT3__SD3_DATA3	0x11059
+		>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3grp-100mhz {
+		fsl,pins = <
+			MX6SL_PAD_SD3_CMD__SD3_CMD	0x170b9
+			MX6SL_PAD_SD3_CLK__SD3_CLK	0x170b9
+			MX6SL_PAD_SD3_DAT0__SD3_DATA0	0x170b9
+			MX6SL_PAD_SD3_DAT1__SD3_DATA1	0x170b9
+			MX6SL_PAD_SD3_DAT2__SD3_DATA2	0x170b9
+			MX6SL_PAD_SD3_DAT3__SD3_DATA3	0x170b9
+		>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3grp-200mhz {
+		fsl,pins = <
+			MX6SL_PAD_SD3_CMD__SD3_CMD	0x170f9
+			MX6SL_PAD_SD3_CLK__SD3_CLK	0x170f9
+			MX6SL_PAD_SD3_DAT0__SD3_DATA0	0x170f9
+			MX6SL_PAD_SD3_DAT1__SD3_DATA1	0x170f9
+			MX6SL_PAD_SD3_DAT2__SD3_DATA2	0x170f9
+			MX6SL_PAD_SD3_DAT3__SD3_DATA3	0x170f9
+		>;
+	};
+
+	pinctrl_usdhc3_sleep: usdhc3grp-sleep {
+		fsl,pins = <
+			MX6SL_PAD_SD3_CMD__GPIO5_IO21	0x100c1
+			MX6SL_PAD_SD3_CLK__GPIO5_IO18	0x100c1
+			MX6SL_PAD_SD3_DAT0__GPIO5_IO19	0x100c1
+			MX6SL_PAD_SD3_DAT1__GPIO5_IO20	0x100c1
+			MX6SL_PAD_SD3_DAT2__GPIO5_IO16	0x100c1
+			MX6SL_PAD_SD3_DAT3__GPIO5_IO17	0x100c1
+		>;
+	};
+
+	pinctrl_wifi_power: wifi-powergrp {
+		fsl,pins = <
+			MX6SL_PAD_SD2_DAT6__GPIO4_IO29	0x10059	/* WIFI_3V3_ON */
+		>;
+	};
+
+	pinctrl_wifi_reset: wifi-resetgrp {
+		fsl,pins = <
+			MX6SL_PAD_SD2_DAT7__GPIO5_IO00	0x10059	/* WIFI_RST */
+		>;
+	};
+};
+
+&leds {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_led>;
+};
+
+&lm3630a {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lm3630a_bl_gpio>;
+};
+
+&reg_wifi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wifi_power>;
+};
+
+&reg_vdd1p1 {
+	vin-supply = <&dcdc2_reg>;
+};
+
+&reg_vdd2p5 {
+	vin-supply = <&dcdc2_reg>;
+};
+
+&reg_vdd3p0 {
+	vin-supply = <&dcdc2_reg>;
+};
+
+&ricoh619 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ricoh_gpio>;
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+};
+
+&usdhc2 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc2>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
+	pinctrl-3 = <&pinctrl_usdhc2_sleep>;
+};
+
+&usdhc3 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	pinctrl-3 = <&pinctrl_usdhc3_sleep>;
+};
+
+&wifi_pwrseq {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wifi_reset>;
+};
-- 
2.11.0

