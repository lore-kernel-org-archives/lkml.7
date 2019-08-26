Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB239C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A401320874
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733153AbfHZPjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 11:39:05 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54986 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733098AbfHZPi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:38:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id p74so15921102wme.4;
        Mon, 26 Aug 2019 08:38:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CCidpFZxLFE4P75q/h/CfR1vG1u9xDP4alk3j8cCjK4=;
        b=gCdIFBQtAvE5/EUXbXLPfPwXhIO/sHbxzTZeE0fRFnEsKbxKhPWJ3r5nUc7QUFnFqb
         fTxeXAkA/bh2TulU9uNh9Lyn+M47xBSntk9VyVWSW1abPtk76zP2SPha9s6q+L3ue+xf
         qaJ76O/s6hByL4dLjQNX86TD3+qu0OxYxbbHW76mkYA50gG5BM9IYrRpsGxVhBavg4lB
         P4R0DmNMLra5+97rB2FqhXn50jUF3f4HSnIp15mkFrN2xpwcwAaQErTgysObnVUedLyP
         eXuq/pX/vrbLtZnaN7FFHwA3Df1lgTzMVeP6ftYjlLKOsOTUKAP3WLcvou6/4tBpe8iI
         8Ffg==
X-Gm-Message-State: APjAAAUMuTxPM4i5FIJm1D3Ln39ehvP9zpe5EnyURMpXVxapwt6TUatc
        of5uf5L/YnyuNOmf05UxwcLoIfqULIw=
X-Google-Smtp-Source: APXvYqzsbhVljiEuydQ/xlkYaZBrTfAVaxQTlAtSYpAoi/lBDHWGvwGJ2EF8W9qxZmRGghumu+azug==
X-Received: by 2002:a1c:a008:: with SMTP id j8mr22556949wme.57.1566833934527;
        Mon, 26 Aug 2019 08:38:54 -0700 (PDT)
Received: from 1aq-andre.garage.tyco.com ([77.107.218.170])
        by smtp.gmail.com with ESMTPSA id z8sm11580798wru.13.2019.08.26.08.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 08:38:54 -0700 (PDT)
From:   =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>,
        Ilya Ledvich <ilya@compulab.co.il>,
        Igor Grinberg <grinberg@compulab.co.il>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 12/12] ARM: dts: imx7d: sbc-iot-imx7: add basic board support
Date:   Mon, 26 Aug 2019 16:38:00 +0100
Message-Id: <20190826153800.35400-12-git@andred.net>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190826153800.35400-1-git@andred.net>
References: <20190826153800.35400-1-git@andred.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a forward-port of Compulab's downstream commit
against linux 4.9.11.

Original commit message:
    The SB-IOT-iMX7 base board together with CL-SOM-iMX7
    SoM forms SBC-IOT-iMX7 single board computer.
    SBC-IOT-iMX7 is a single board computer optimized for
    industrial control and monitoring, extensive wireless
    and wired connectivity, ideal solution for
    cost-sensitive systems. It is based on the Freescale
    i.MX7 system-on-chip. SBC-IOT-iMX7 is implemented with
    the CL-SOM-iMX7 System-on-Module providing most of the
    functions,and SB-IOT-iMX7 carrier board providing
    additional peripheral functions and connectors.

    https://www.compulab.com/products/computer-on-modules/cl-som-imx7-freescale-i-mx-7-system-on-module/
    https://www.compulab.com/products/sbcs/sbc-iot-imx7-nxp-i-mx-7-internet-of-things-single-board-computer/

This commit adds basic board support, including:
* SD-card (note that write-protect is not connected
  on this carrier board)
* SPI (available on expansion header)
* i2c3 & i2c4 (including bus recovery information)
* additional UARTs
* all USB ports

Compared to the downtream commit, this commit doesn't
add / enable the PCIe and LCD interface, as PCIe
support needs an additional patch to the PCI controller
first, and I can't test the LCD.

Signed-off-by: André Draszik <git@andred.net>
Cc: Ilya Ledvich <ilya@compulab.co.il>
Cc: Igor Grinberg <grinberg@compulab.co.il>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/boot/dts/Makefile               |   1 +
 arch/arm/boot/dts/imx7d-sbc-iot-imx7.dts | 198 +++++++++++++++++++++++
 2 files changed, 199 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx7d-sbc-iot-imx7.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 9159fa2cea90..78d51f2f9930 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -591,6 +591,7 @@ dtb-$(CONFIG_SOC_IMX7D) += \
 	imx7d-pico-hobbit.dtb \
 	imx7d-pico-pi.dtb \
 	imx7d-sbc-imx7.dtb \
+	imx7d-sbc-iot-imx7.dtb \
 	imx7d-sdb.dtb \
 	imx7d-sdb-reva.dtb \
 	imx7d-sdb-sht11.dtb \
diff --git a/arch/arm/boot/dts/imx7d-sbc-iot-imx7.dts b/arch/arm/boot/dts/imx7d-sbc-iot-imx7.dts
new file mode 100644
index 000000000000..6f2af5aa439e
--- /dev/null
+++ b/arch/arm/boot/dts/imx7d-sbc-iot-imx7.dts
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+//
+// Copyright 2017 CompuLab Ltd. - http://www.compulab.co.il/
+/*
+ * Support for CompuLab SBC-IOT-iMX7 Single Board Computer
+ */
+
+#include "imx7d-cl-som-imx7.dts"
+
+/ {
+	model = "CompuLab,SBC-IOT-iMX7";
+	compatible = "compulab,sbc-iot-imx7", "compulab,cl-som-imx7", "fsl,imx7d";
+
+	reg_usb_vbus: regulator-usb-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+};
+
+&ecspi3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi3 &pinctrl_ecspi3_cs>;
+	cs-gpios = <&gpio4 11 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	pinctrl-1 = <&pinctrl_i2c3_recovery>;
+	sda-gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
+	scl-gpios = <&gpio1 8 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+};
+
+&i2c4 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default", "gpio";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	pinctrl-1 = <&pinctrl_i2c4_recovery>;
+	sda-gpios = <&gpio1 11 GPIO_ACTIVE_HIGH>;
+	scl-gpios = <&gpio1 10 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+
+	eeprom_iot@54 {
+		compatible = "atmel,24c08";
+		reg = <0x54>;
+		pagesize = <16>;
+	};
+};
+
+&iomuxc {
+	pinctrl-1 = <&pinctrl_xpen>;
+
+	/* SB-IOT-iMX7 Xpension Header P7 */
+	pinctrl_xpen: xpengrp {
+		fsl,pins = <
+			MX7D_PAD_LCD_DATA13__GPIO3_IO18		0x34 /* P7-4 - gpio82 */
+			MX7D_PAD_LCD_DATA12__GPIO3_IO17		0x34 /* P7-5 - gpio81 */
+		>;
+	};
+
+	pinctrl_ecspi3: ecspi3grp {
+		fsl,pins = <
+			MX7D_PAD_I2C1_SDA__ECSPI3_MOSI		0xf /* P7-7 */
+			MX7D_PAD_I2C1_SCL__ECSPI3_MISO		0xf /* P7-8 */
+			MX7D_PAD_I2C2_SCL__ECSPI3_SCLK		0xf /* P7-6 */
+		>;
+	};
+
+	pinctrl_ecspi3_cs: ecspi3_cs_grp {
+		fsl,pins = <
+			MX7D_PAD_I2C2_SDA__GPIO4_IO11		0x34 /* P7-9 */
+		>;
+	};
+
+	pinctrl_i2c3: i2c3grp {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO09__I2C3_SDA		0x4000000f /* P7-3 */
+			MX7D_PAD_GPIO1_IO08__I2C3_SCL		0x4000000f /* P7-2 */
+		>;
+	};
+
+	pinctrl_i2c3_recovery: i2c3recoverygrp {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO09__GPIO1_IO9		0x4000000f /* P7-3 */
+			MX7D_PAD_GPIO1_IO08__GPIO1_IO8		0x4000000f /* P7-2 */
+		>;
+	};
+
+	pinctrl_i2c4: i2c4grp {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO11__I2C4_SDA		0x4000000f
+			MX7D_PAD_GPIO1_IO10__I2C4_SCL		0x4000000f
+		>;
+	};
+
+	pinctrl_i2c4_recovery: i2c4recoverygrp {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO11__GPIO1_IO11		0x4000000f
+			MX7D_PAD_GPIO1_IO10__GPIO1_IO10		0x4000000f
+		>;
+	};
+
+	pinctrl_uart2: uart2grp {
+		fsl,pins = <
+			MX7D_PAD_LCD_ENABLE__UART2_DCE_TX	0x79 /* P7-12 */
+			MX7D_PAD_LCD_CLK__UART2_DCE_RX		0x79 /* P7-13 */
+			MX7D_PAD_LCD_VSYNC__UART2_DCE_CTS	0x79 /* P7-11 */
+			MX7D_PAD_LCD_HSYNC__UART2_DCE_RTS	0x79 /* P7-10 */
+		>;
+	};
+
+	pinctrl_uart5: uart5grp {
+		fsl,pins = <
+			MX7D_PAD_I2C4_SDA__UART5_DCE_TX		0x79 /* RS232-TX */
+			MX7D_PAD_I2C4_SCL__UART5_DCE_RX		0x79 /* RS232-RX */
+			MX7D_PAD_I2C3_SDA__UART5_DCE_RTS	0x79 /* RS232-RTS */
+			MX7D_PAD_I2C3_SCL__UART5_DCE_CTS	0x79 /* RS232-CTS */
+		>;
+	};
+
+	pinctrl_uart7: uart7grp {
+		fsl,pins = <
+			MX7D_PAD_ECSPI2_MOSI__UART7_DCE_TX	0x79 /* R485-TX */
+			MX7D_PAD_ECSPI2_SCLK__UART7_DCE_RX	0x79 /* R485-RX */
+			MX7D_PAD_ECSPI2_SS0__UART7_DCE_CTS	0x79 /* R485-CTS */
+			MX7D_PAD_ECSPI2_MISO__UART7_DCE_RTS	0x79 /* R485-TTS */
+		>;
+	};
+
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX7D_PAD_SD1_CMD__SD1_CMD		0x59
+			MX7D_PAD_SD1_CLK__SD1_CLK		0x19
+			MX7D_PAD_SD1_DATA0__SD1_DATA0		0x59
+			MX7D_PAD_SD1_DATA1__SD1_DATA1		0x59
+			MX7D_PAD_SD1_DATA2__SD1_DATA2		0x59
+			MX7D_PAD_SD1_DATA3__SD1_DATA3		0x59
+			MX7D_PAD_SD1_CD_B__GPIO5_IO0		0x59 /* CD */
+		>;
+	};
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	assigned-clocks = <&clks IMX7D_UART2_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_OSC_24M_CLK>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
+&uart5 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart5>;
+	assigned-clocks = <&clks IMX7D_UART5_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
+&uart7 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart7>;
+	assigned-clocks = <&clks IMX7D_UART7_ROOT_SRC>;
+	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
+&usbotg1 {
+	vbus-supply = <&reg_usb_vbus>;
+	status = "okay";
+};
+
+&usbotg2 {
+	dr_mode = "host";
+	vbus-supply = <&reg_usb_vbus>;
+	status = "okay";
+};
+
+&usbh {
+	vbus-supply = <&reg_usb_vbus>;
+	status = "okay";
+};
+
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	cd-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
+	wakeup-source;
+	status = "okay";
+};
-- 
2.23.0.rc1

