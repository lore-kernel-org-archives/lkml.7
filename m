Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3F9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BEC3214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="VQIwFL7q";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="Kr237Wlh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfCKXrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 19:47:10 -0400
Received: from node.akkea.ca ([192.155.83.177]:39784 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbfCKXrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 19:47:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id D123D4E2056;
        Mon, 11 Mar 2019 23:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1552348027; bh=j3Ro+n2neEzhPXt1kzy3b76gnKZw5ULqOAnKuw2SnuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VQIwFL7qMfKc0YFR9nHEvPKJYtVYexY6YBZv45JkIxV/flS9wPCpm8YQdyV7TJvWP
         r602t99ppYKGMS6xHD2rKU6uhDz5Aq5FJQZ7+ZlMME57oD4m9KM5niv/Y8wH92HjlM
         eteUCaCJCKOZM31Se1AXJKa5Xg9ZYQWvCb9dqTAY=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id t4FN9MqH6nEQ; Mon, 11 Mar 2019 23:47:06 +0000 (UTC)
Received: from midas.localdomain (S0106788a2041785e.gv.shawcable.net [70.66.86.75])
        by node.akkea.ca (Postfix) with ESMTPSA id 491894E204D;
        Mon, 11 Mar 2019 23:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1552348026; bh=j3Ro+n2neEzhPXt1kzy3b76gnKZw5ULqOAnKuw2SnuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Kr237WlhjR+GzkKVUYcuuR+gFLR7v0sBG3NvZUsBFquiHjhKT4azkw5pfhpJSvtgh
         X8GItMdYzmJcLaYnX3mF425Xv9ngo+bq/qTPMRm7WFi2rBLdWJejGJAt0FWsOLY2Z6
         e1IN2rtPZ//rjbcrHI8fBWIUC4csue20o0IcjG6Y=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>, kernel@pengutronix.de,
        Lucas Stach <l.stach@pengutronix.de>, abel.vesa@nxp.com,
        daniel.baluta@nxp.com, agx@sigxcpu.org, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH 1/3] arm64: dts: fsl: librem5: Add a device tree for the Librem5 devkit
Date:   Mon, 11 Mar 2019 16:46:53 -0700
Message-Id: <20190311234655.30357-2-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190311234655.30357-1-angus@akkea.ca>
References: <20190311234655.30357-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the development kit for the Librem 5. The current level of support
yields a working console and is able to boot userspace from the network
or eMMC.

Additional subsystems that are active :

- Both USB ports
- SD card socket
- WWAN modem

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 .../dts/freescale/imx8mq-librem5-devkit.dts   | 804 ++++++++++++++++++
 1 file changed, 804 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
new file mode 100644
index 000000000000..da9221c4200c
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -0,0 +1,804 @@
+/* SPDX-License-Identifier: GPL-2.0+
+ *
+ * Copyright 2018-2019 Purism SPC
+ */
+
+/dts-v1/;
+
+#include "imx8mq.dtsi"
+#include "dt-bindings/usb/pd.h"
+
+/ {
+	model = "Purism Librem 5 devkit 1.0";
+	compatible = "fsl,librem5-devkit", "fsl,imx8mq";
+
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	reg_usdhc2_vmmc: regulator-vsd-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VSD_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	reg_pwr_en: pwr_en {
+		compatible = "regulator-fixed";
+		regulator-name = "PWR_EN";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio1 8 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
+	pmic_osc: pmic_osc {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+		clock-output-names = "pmic_osc";
+	};
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec1>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy0>;
+	fsl,magic-packet;
+	status = "okay";
+	phy-supply = <&reg_pwr_en>;
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+			at803x,led-act-blind-workaround;
+			at803x,eee-disabled;
+			power-supply = <&reg_pwr_en>;
+		};
+	};
+};
+
+&iomuxc {
+	imx8m-som {
+		pinctrl_nc: ncgrp {
+			fsl,pins = <
+			MX8MQ_IOMUXC_SAI1_MCLK_SAI1_MCLK	0x00
+			MX8MQ_IOMUXC_I2C4_SCL_I2C4_SCL		0x4000007f
+			MX8MQ_IOMUXC_I2C4_SDA_I2C4_SDA		0x4000007f
+			>;
+		};
+
+		pinctrl_up: upgrp {
+			fsl,pins = <
+			MX8MQ_IOMUXC_SAI1_TXD2_SAI1_TX_DATA2		0x00
+			>;
+		};
+
+		pinctrl_csi1: csi1grp {
+			fsl,pins = <
+			/* CSI_nRST */
+			MX8MQ_IOMUXC_GPIO1_IO06_GPIO1_IO6		0x11
+			/* CSI_PWDN */
+			MX8MQ_IOMUXC_GPIO1_IO07_GPIO1_IO7		0x19
+			/* CLK01 */
+			MX8MQ_IOMUXC_GPIO1_IO14_CCMSRCGPCMIX_CLKO1	0x19
+			>;
+		};
+
+		pinctrl_pwr_en: pwr_engrp {
+			fsl,pins = <
+			MX8MQ_IOMUXC_GPIO1_IO08_GPIO1_IO8               0x06
+			>;
+		};
+
+		pinctrl_wwan: wwan_grp {
+			fsl,pins = <
+			/* nWWAN_DISABLE */
+			MX8MQ_IOMUXC_NAND_CE3_B_GPIO3_IO4	0x09
+			/* nWoWWAN */
+			MX8MQ_IOMUXC_NAND_DATA02_GPIO3_IO8	0x80
+			/* WWAN_RESET */
+			MX8MQ_IOMUXC_NAND_DATA03_GPIO3_IO9	0x19
+			>;
+		};
+
+		pinctrl_dsi: dsigrp {
+			fsl,pins = <
+			MX8MQ_IOMUXC_NAND_DATA07_GPIO3_IO13	0x16
+			>;
+		};
+
+		pinctrl_fec1: fec1grp {
+			fsl,pins = <
+			MX8MQ_IOMUXC_ENET_MDC_ENET1_MDC		0x3
+			MX8MQ_IOMUXC_ENET_MDIO_ENET1_MDIO	0x3
+			MX8MQ_IOMUXC_ENET_TD3_ENET1_RGMII_TD3	0x1f
+			MX8MQ_IOMUXC_ENET_TD2_ENET1_RGMII_TD2	0x1f
+			MX8MQ_IOMUXC_ENET_TD1_ENET1_RGMII_TD1	0x1f
+			MX8MQ_IOMUXC_ENET_TD0_ENET1_RGMII_TD0	0x1f
+			MX8MQ_IOMUXC_ENET_RD3_ENET1_RGMII_RD3	0x91
+			MX8MQ_IOMUXC_ENET_RD2_ENET1_RGMII_RD2	0x91
+			MX8MQ_IOMUXC_ENET_RD1_ENET1_RGMII_RD1	0x91
+			MX8MQ_IOMUXC_ENET_RD0_ENET1_RGMII_RD0	0x91
+			MX8MQ_IOMUXC_ENET_TXC_ENET1_RGMII_TXC	0x1f
+			MX8MQ_IOMUXC_ENET_RXC_ENET1_RGMII_RXC	0x91
+			MX8MQ_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
+			MX8MQ_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
+			MX8MQ_IOMUXC_GPIO1_IO09_GPIO1_IO9	0x19
+			MX8MQ_IOMUXC_GPIO1_IO15_CCMSRCGPCMIX_CLKO2      0x1f
+			>;
+		};
+
+		pinctrl_hdmi: hdmigrp {
+			fsl,pins = <
+			MX8MQ_IOMUXC_SAI3_MCLK_GPIO5_IO2	0x16
+			>;
+		};
+
+		pinctrl_i2c1: i2c1grp {
+			fsl,pins = <
+			MX8MQ_IOMUXC_I2C1_SCL_I2C1_SCL		0x4000001f
+			MX8MQ_IOMUXC_I2C1_SDA_I2C1_SDA		0x4000001f
+			>;
+		};
+
+		pinctrl_i2c2: i2c2grp {
+			fsl,pins = <
+			MX8MQ_IOMUXC_I2C2_SCL_I2C2_SCL		0x4000001f
+			MX8MQ_IOMUXC_I2C2_SDA_I2C2_SDA		0x4000001f
+			>;
+		};
+
+		pinctrl_i2c3: i2c3grp {
+			fsl,pins = <
+			MX8MQ_IOMUXC_I2C3_SCL_I2C3_SCL		0x4000001f
+			MX8MQ_IOMUXC_I2C3_SDA_I2C3_SDA		0x4000001f
+			>;
+		};
+
+		pinctrl_pcie0: pcie0grp {
+			fsl,pins = <
+			MX8MQ_IOMUXC_NAND_RE_B_GPIO3_IO15	0x16
+			MX8MQ_IOMUXC_NAND_DATA05_GPIO3_IO11	0x16
+			MX8MQ_IOMUXC_NAND_DATA04_GPIO3_IO10	0x16
+			>;
+		};
+
+		pinctrl_pcie1: pcie1grp {
+			fsl,pins = <
+			MX8MQ_IOMUXC_NAND_WP_B_GPIO3_IO18	0x16
+			MX8MQ_IOMUXC_NAND_CLE_GPIO3_IO5	0x16
+			MX8MQ_IOMUXC_NAND_WE_B_GPIO3_IO17	0x16
+			>;
+		};
+
+
+		pinctrl_typec: typecgrp {
+			fsl,pins = <
+			MX8MQ_IOMUXC_NAND_DATA06_GPIO3_IO12	0x16
+			MX8MQ_IOMUXC_NAND_CE0_B_GPIO3_IO1	0x80
+			>;
+		};
+
+		pinctrl_uart1: uart1grp {
+			fsl,pins = <
+			MX8MQ_IOMUXC_UART1_RXD_UART1_DCE_RX		0x49
+			MX8MQ_IOMUXC_UART1_TXD_UART1_DCE_TX		0x49
+			>;
+		};
+
+		pinctrl_uart2: uart2grp {
+			fsl,pins = <
+			MX8MQ_IOMUXC_UART2_TXD_UART2_DCE_TX		0x49
+			MX8MQ_IOMUXC_UART2_RXD_UART2_DCE_RX		0x49
+			MX8MQ_IOMUXC_UART4_RXD_UART2_DCE_CTS_B		0x49
+			MX8MQ_IOMUXC_UART4_TXD_UART2_DCE_RTS_B		0x49
+			>;
+		};
+
+		pinctrl_uart3: uart3grp {
+			fsl,pins = <
+			MX8MQ_IOMUXC_UART3_RXD_UART3_DCE_RX		0x49
+			MX8MQ_IOMUXC_UART3_TXD_UART3_DCE_TX		0x49
+			>;
+		};
+
+		pinctrl_uart4: uart4grp {
+			fsl,pins = <
+			MX8MQ_IOMUXC_ECSPI2_SCLK_UART4_DCE_RX		0x49
+			MX8MQ_IOMUXC_ECSPI2_MOSI_UART4_DCE_TX		0x49
+			MX8MQ_IOMUXC_ECSPI2_MISO_UART4_DCE_CTS_B	0x49
+			MX8MQ_IOMUXC_ECSPI2_SS0_UART4_DCE_RTS_B		0x49
+			MX8MQ_IOMUXC_GPIO1_IO00_ANAMIX_REF_CLK_32K	0x49
+			>;
+		};
+
+		pinctrl_bt: btgrp {
+			fsl,pins = <
+			/* nBT_DISABLE */
+			MX8MQ_IOMUXC_NAND_DATA05_GPIO3_IO11             0x16
+			/* BT_HOST_WAKE */
+			MX8MQ_IOMUXC_NAND_DATA01_GPIO3_IO7              0x10
+			>;
+		};
+
+		pinctrl_modem_reset: modem_reset {
+			fsl,pins = <
+			/* WWAN_RESET */
+			MX8MQ_IOMUXC_NAND_DATA03_GPIO3_IO9		0x19
+			>;
+		};
+
+		pinctrl_usdhc1: usdhc1grp {
+			fsl,pins = <
+			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x83
+			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc3
+			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc3
+			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc3
+			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc3
+			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc3
+			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc3
+			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc3
+			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc3
+			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc3
+			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x83
+			MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
+			>;
+		};
+
+		pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+			fsl,pins = <
+			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x8d
+			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xcd
+			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xcd
+			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xcd
+			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xcd
+			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xcd
+			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xcd
+			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xcd
+			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xcd
+			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xcd
+			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x8d
+			MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
+			>;
+		};
+
+		pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+			fsl,pins = <
+			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x9f
+			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xdf
+			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xdf
+			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xdf
+			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xdf
+			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xdf
+			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xdf
+			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xdf
+			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xdf
+			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xdf
+			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x9f
+			MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
+			>;
+		};
+
+		pinctrl_usdhc2_gpio: usdhc2grpgpio {
+			fsl,pins = <
+			MX8MQ_IOMUXC_SD2_RESET_B_GPIO2_IO19		0x41
+			/* WIFI_WAKE */
+			MX8MQ_IOMUXC_SD2_WP_GPIO2_IO20			0x80
+			>;
+		};
+
+		pinctrl_usdhc2: usdhc2grp {
+			fsl,pins = <
+			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x83
+			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc3
+			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc3
+			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc3
+			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc3
+			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc3
+			>;
+		};
+
+		pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
+			fsl,pins = <
+			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x8d
+			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xcd
+			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xcd
+			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xcd
+			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xcd
+			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xcd
+			>;
+		};
+
+		pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
+			fsl,pins = <
+			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x9f
+			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xcf
+			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xcf
+			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xcf
+			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xcf
+			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xcf
+			>;
+		};
+
+		pinctrl_sai2: sai2grp {
+			fsl,pins = <
+			MX8MQ_IOMUXC_SAI2_TXFS_SAI2_TX_SYNC	0xd6
+			MX8MQ_IOMUXC_SAI2_TXC_SAI2_TX_BCLK	0xd6
+			MX8MQ_IOMUXC_SAI2_TXD0_SAI2_TX_DATA0	0xd6
+			MX8MQ_IOMUXC_SAI2_RXD0_SAI2_RX_DATA0	0xd6
+			MX8MQ_IOMUXC_SAI2_MCLK_SAI2_MCLK	0xd6
+			>;
+		};
+
+		pinctrl_sai5: sai5grp {
+			fsl,pins = <
+			MX8MQ_IOMUXC_SAI5_RXD3_SAI5_TX_DATA0	0xd6
+			MX8MQ_IOMUXC_SAI5_RXD1_SAI5_TX_SYNC	0xd6
+			MX8MQ_IOMUXC_SAI5_RXD2_SAI5_TX_BCLK     0xd6
+			MX8MQ_IOMUXC_SAI5_RXD0_SAI5_RX_DATA0	0xd6
+			>;
+		};
+
+		pinctrl_sai6: sai6grp {
+			fsl,pins = <
+			MX8MQ_IOMUXC_SAI1_RXD5_SAI6_RX_DATA0	0xd6
+			MX8MQ_IOMUXC_SAI1_RXD6_SAI6_RX_SYNC	0xd6
+			MX8MQ_IOMUXC_SAI1_TXD4_SAI6_RX_BCLK     0xd6
+			MX8MQ_IOMUXC_SAI1_TXD5_SAI6_TX_DATA0	0xd6
+			>;
+		};
+
+		pinctrl_spdif1: spdif1grp {
+			fsl,pins = <
+			MX8MQ_IOMUXC_SPDIF_TX_SPDIF1_OUT	0xd6
+			MX8MQ_IOMUXC_SPDIF_RX_SPDIF1_IN		0xd6
+			>;
+		};
+
+		pinctrl_wdog: wdoggrp {
+			fsl,pins = <
+			MX8MQ_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B	0xc6
+			>;
+		};
+
+		pinctrl_pwm1: pwm1 {
+			fsl,pins = <
+			/* DSI_BL_PWM */
+			MX8MQ_IOMUXC_GPIO1_IO01_PWM1_OUT	0x6
+			>;
+		};
+
+		pinctrl_micsel: micselgrp {
+			fsl,pins = <
+			/* mic sel */
+			MX8MQ_IOMUXC_SPDIF_EXT_CLK_GPIO5_IO5	0xc6
+			>;
+		};
+
+		pinctrl_haptic: hapticgrp {
+			fsl,pins = <
+			/* nHAPTIC */
+			MX8MQ_IOMUXC_SPDIF_RX_PWM2_OUT		0xc6
+			>;
+		};
+
+		pinctrl_mute: mute {
+			fsl,pins = <
+			MX8MQ_IOMUXC_SPDIF_TX_GPIO5_IO3		0x86  /* MUTE */
+			>;
+		};
+
+		pinctrl_pwm4: pwm4 {
+			fsl,pins = <
+			MX8MQ_IOMUXC_I2C3_SCL_PWM4_OUT		0xc6
+			>;
+		};
+
+		pinctrl_prox: prox_nint {
+			fsl,pins = <
+			MX8MQ_IOMUXC_GPIO1_IO12_GPIO1_IO12	0x80
+			>;
+		};
+
+		pinctrl_charger: charger_nirq {
+			fsl,pins = <
+			/* CHRG_nINT */
+			MX8MQ_IOMUXC_SAI5_MCLK_GPIO3_IO25	0x80
+			>;
+		};
+
+		pinctrl_rtc: rtcirq {
+			fsl,pins = <
+			MX8MQ_IOMUXC_SAI3_RXC_GPIO4_IO29	0x80
+			>;
+		};
+
+		pinctrl_pmic: pmic_int {
+			fsl,pins = <
+			MX8MQ_IOMUXC_GPIO1_IO03_GPIO1_IO3	0x80
+			>;
+		};
+
+		pinctrl_spi1: spi1 {
+			fsl,pins = <
+			MX8MQ_IOMUXC_ECSPI1_SCLK_ECSPI1_SCLK	0x0f
+			MX8MQ_IOMUXC_ECSPI1_MOSI_ECSPI1_MOSI	0x0f
+			MX8MQ_IOMUXC_ECSPI1_MISO_ECSPI1_MISO	0x0f
+			MX8MQ_IOMUXC_ECSPI1_SS0_GPIO5_IO9	0x09
+			>;
+		};
+
+		pinctrl_imu: imugrp {
+			fsl,pins = <
+			/* IMU_INT */
+			MX8MQ_IOMUXC_SAI5_RXFS_GPIO3_IO19	0x8
+			>;
+		};
+
+		pinctrl_gpio_leds: gpioleds {
+			fsl,pins = <
+			MX8MQ_IOMUXC_GPIO1_IO13_GPIO1_IO13	0x16
+			>;
+		};
+
+		pinctrl_gpio_keys: gpiokeys {
+			fsl,pins = <
+			MX8MQ_IOMUXC_SAI2_RXFS_GPIO4_IO21	0x16
+			MX8MQ_IOMUXC_SAI2_RXC_GPIO4_IO22	0x16
+			/* HP_DET */
+			MX8MQ_IOMUXC_SAI5_RXC_GPIO3_IO20	0x180
+			>;
+		};
+
+		pinctrl_goodix_ts: gt5688 {
+			fsl,pins = <
+			/* TOUCH INT */
+			MX8MQ_IOMUXC_NAND_ALE_GPIO3_IO0         0x16
+			/* TOUCH RST */
+			MX8MQ_IOMUXC_GPIO1_IO05_GPIO1_IO5	0x19
+			>;
+		};
+
+	};
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+
+	pmic: bd71837@4b {
+		reg = <0x4b>;
+		compatible = "rohm,bd71837";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pmic>;
+		clocks = <&pmic_osc>;
+		clock-names = "osc";
+		clock-output-names = "pmic_clk";
+		interrupt-parent = <&gpio1>;
+		interrupts = <3 GPIO_ACTIVE_LOW>;
+		interrupt-names = "irq";
+		rohm,reset-snvs-powered;
+
+		gpo {
+			/* 0b0000_1100 all gpos with cmos output mode */
+			rohm,drv = <0x0C>;
+		};
+
+		regulators {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			buck1_reg: BUCK1 {
+				reg = <0>;
+				regulator-name = "buck1";
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <1250>;
+				rohm,dvs-run-voltage = <900000>;
+				rohm,dvs-idle-voltage = <850000>;
+				rohm,dvs-suspend-voltage = <800000>;
+			};
+
+			buck2_reg: BUCK2 {
+				reg = <1>;
+				regulator-name = "buck2";
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <1250>;
+				rohm,dvs-run-voltage = <1000000>;
+				rohm,dvs-idle-voltage = <900000>;
+			};
+
+			buck3_reg: BUCK3 {
+				reg = <2>;
+				regulator-name = "buck3";
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-boot-on;
+				rohm,dvs-run-voltage = <1000000>;
+			};
+
+			buck4_reg: BUCK4 {
+				reg = <3>;
+				regulator-name = "buck4";
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-boot-on;
+				rohm,dvs-run-voltage = <1000000>;
+			};
+
+			buck5_reg: BUCK5 {
+				reg = <4>;
+				regulator-name = "buck5";
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck6_reg: BUCK6 {
+				reg = <5>;
+				regulator-name = "buck6";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck7_reg: BUCK7 {
+				reg = <6>;
+				regulator-name = "buck7";
+				regulator-min-microvolt = <1605000>;
+				regulator-max-microvolt = <1995000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck8_reg: BUCK8 {
+				reg = <7>;
+				regulator-name = "buck8";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1_reg: LDO1 {
+				reg = <8>;
+				regulator-name = "ldo1";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo2_reg: LDO2 {
+				reg = <9>;
+				regulator-name = "ldo2";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo3_reg: LDO3 {
+				reg = <10>;
+				regulator-name = "ldo3";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4_reg: LDO4 {
+				reg = <11>;
+				regulator-name = "ldo4";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo5_reg: LDO5 {
+				reg = <12>;
+				regulator-name = "ldo5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo6_reg: LDO6 {
+				reg = <13>;
+				regulator-name = "ldo6";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo7_reg: LDO7 {
+				reg = <14>;
+				regulator-name = "ldo7";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
+
+	typec_ptn5100: ptn5110@52 {
+		compatible = "nxp,ptn5110";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_typec>;
+		reg = <0x52>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
+		ss-sel-gpios = <&gpio3 12 GPIO_ACTIVE_HIGH>;
+		usb_con: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			data-role = "dual";
+			power-role = "dual";
+			try-power-role = "sink";
+			source-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)>;
+			sink-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM)
+			     PDO_VAR(5000, 12000, 2000)>;
+			op-sink-microwatt = <10000000>;
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				port@0 {
+					reg = <0>;
+					usb_con_hs: endpoint {
+						remote-endpoint = <&typec_hs>;
+					};
+				};
+				port@1 {
+					reg = <1>;
+					usb_con_ss: endpoint {
+						remote-endpoint = <&typec_ss>;
+					};
+				};
+			};
+		};
+
+	};
+
+	charger: charger@6b { /* bq25896 */
+		compatible = "ti,bq25890";
+		reg = <0x6b>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_charger>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+		ti,battery-regulation-voltage = <4192000>; // 4.192V
+		ti,charge-current = <1600000>; // 1.6 A
+		ti,termination-current = <66000>;  // 66mA
+		ti,precharge-current = <1300000>; // 1.3A
+		ti,minimum-sys-voltage = <2750000>; // 2.75V
+		ti,boost-voltage = <5000000>; // 5V
+		ti,boost-max-current = <50000>; // 50mA
+	};
+
+	rtc@68 {
+		pinctrl-names = "default";
+		compatible = "microcrystal,rv4162";
+		reg = <0x68>;
+		pinctrl-0 = <&pinctrl_rtc>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+&i2c2 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "disabled";
+};
+
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>, <&pinctrl_imu>;
+	status = "okay";
+
+	lsm9d: lsm9d@6a	{
+		compatible = "st,lsm9ds1-gyro";
+		reg = <0x6a>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
+		power-supply = <&reg_pwr_en>;
+	};
+};
+
+&usb3_phy0 {
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	port@0 {
+		reg = <0>;
+		typec_hs: endpoint {
+			remote-endpoint = <&usb_con_hs>;
+		};
+	};
+	port@1 {
+		reg = <1>;
+		typec_ss: endpoint {
+			remote-endpoint = <&usb_con_ss>;
+		};
+	};
+};
+
+&usb_dwc3_0 {
+	status = "okay";
+	extcon = <&typec_ptn5100>;
+	dr_mode = "otg";
+};
+
+&usb3_phy1 {
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+};
+
+&usb_dwc3_1 {
+	status = "okay";
+	dr_mode = "host";
+};
+
+&uart1 { /* console */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	status = "okay";
+};
+
+&uart4 { /* BT */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4>, <&pinctrl_bt>;
+	fsl,uart-has-rtscts;
+	/* resets = <&modem_reset>; */
+	status = "okay";
+};
+
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
-- 
2.17.1

