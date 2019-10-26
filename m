Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABC0CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 09:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5602206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 09:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfJZJKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 05:10:03 -0400
Received: from mout.perfora.net ([74.208.4.197]:60067 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbfJZJKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 05:10:00 -0400
Received: from marcel-nb-toradex-int.cardiotech.int ([81.221.67.182]) by
 mrelay.perfora.net (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id
 1N7hjq-1huImm22b4-014l0S; Sat, 26 Oct 2019 11:04:27 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Bhaskar Upadhaya <bhaskar.upadhaya@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Gary Bisson <gary.bisson@boundarydevices.com>,
        Li Yang <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pramod Kumar <pramod.kumar_1@nxp.com>,
        Richard Hu <richard.hu@technexion.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v2 4/5] arm64: dts: freescale: add initial support for colibri imx8x
Date:   Sat, 26 Oct 2019 11:04:02 +0200
Message-Id: <20191026090403.3057-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191026090403.3057-1-marcel@ziswiler.com>
References: <20191026090403.3057-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/gqVSMZxVy3i3N4B5L0fuTRFHbfQW+GCxHmWJn99h/d3MVQoicb
 mQanmbj2nB7+oonzOJ1+cugUvi4K157XJdzK00UO3qBpxpAtJQo7YtWQBxtuEgE7AIWe+gS
 whI4kxcq810+tn/eQHsHrJitcYHKlth0xv4TYSKDHh3DpJ/bVck6IwEv6kE/OBiKwW5Q/Qo
 XTTD7nSpNXLmDS5cP+TuQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R2zqdnKaYeo=:QeTlGudk3Z9mp5z3g55zmi
 iIdoRk54JO3fNy18BR1EVBBxPOlT6e7uWSyTGknX0b2ZPvzvYkJlNPUQygf4tVzlLfufnZFcY
 N/yV+xEv73U5pt6cByHCpnfm08o3gkkjlYwZTcuxFOzOxqqg66lTVvn8CLu0yPEqbJDyjJw2B
 H+LYesZTfD+iCv3XdJksI1PN0XA29Gj4kHgTLA7CmopMC6ygwHWqQweIrtU581WKa6fmuJmaE
 smB7BipaCehukqMIINKiFaKwZ5/hOaplXYXNGofUy1FrjM6QBmAsOcre5wPoaq+KQlywaisBZ
 k0JypsS7lXI4/bO1Uoi6KE+/14rjmR3+udPdgXOIBo3s+CoKQh/DAKR4emPQkYjDGQeBf95uM
 JAnAJnBkftGB7qh9rih73xdH/+4N3GfXCY8knuqWGkQJyBkCZOFGa3jbJoOgm8NNQixSlJxEy
 +jXdpqE96Axq4Ezm5mZ+gWNlDzGXvGmr/JDy6mczqtUQEtqiDfowZnija/QEk3+wGBH0QfEgP
 +VZrg+cVW23CaGcryVR8Clv97Xj0c/zmYpHQQ/ZxAUbQ9ZZCLGp2c6rKymEokb7ErwWRyL7rQ
 KouM7jVnHzcDie2MmvsvRfqz33IkPxzKGXnKq9BBPWOI19KwBJ0omw7ZAbnf+STxJU0xrJ0Mj
 ZCxAKNmOBBkN8tjt8igTu4gOFthcKX8tBWjZU+Ov0LbX1xbUuD8tQxEsPhQ/YNRyXJuwolWcb
 Tyg51v9s1iIJp7pnI23M3/BS28jC4cM42LlZwLF3iACc8eCMl+jZ0J9lngA7I6a+OJwFVreo4
 GIb/WcJYXluzF0B3WZSbOCemSeHKIAzCVhzPxFfGT0Rbm0268Evk0NVi1GdfCxgzcva18VBRe
 8qgcom7J1B4FfFGzK/5GyVqzmR+4KZz3uBNrERS0U=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

This patch adds the device tree to support Toradex Colibri iMX8X a
computer on module which can be used on different carrier boards.

The module consists of an NXP i.MX 8X family SoC (either i.MX 8DualX or
8QuadXPlus), a PF8100 PMIC, a FastEthernet PHY, 1 or 2 GB of LPDDR4
RAM, some level shifters, a Micron eMMC, a USB hub, an AD7879 resistive
touch controller, an SGTL5000 audio codec and on-module CSI as well as
DSI-LVDS FFC receptacles plus an optional Bluetooth/Wi-Fi module.

Anything that is not self-contained on the module is disabled by
default.

The device tree for the Colibri Evaluation Board includes the module's
device tree and enables the supported peripherals of the carrier board
(the Colibri Evaluation Board supports almost all of them).

So far there is no display or USB functionality supported at all but
basic console UART, eMMC and Ethernet functionality work fine.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

---

Changes in v2:
- Replace X11 with identical MIT license as suggested by Shawn.
- Use proper generic binding for GPIO wake-up key as suggested by Shawn.
- Sort devicetree label nodes alphabetically as suggested by Shawn.
- Use generic touch controller node names as suggested by Shawn.
- Put iomuxc at end of the file to improve the readability, as suggested
  by Shawn.
- Drop unneeded colibri-imx8qxp iomuxc container node.
- Name pinctrl nodes more consistently and sort them alphabetically as
  suggested by Shawn.
- Enable possibility for GPIO key to act as a wake-up curtsey Philippe.
- Fix pull mode for wake-up GPIO pin curtsey Oleksandr.
- Add pinctrl for optional FlexCAN3 curtsey Oleksandr.

 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../dts/freescale/imx8qxp-colibri-eval-v3.dts |  15 +
 .../freescale/imx8qxp-colibri-eval-v3.dtsi    |  62 ++
 .../boot/dts/freescale/imx8qxp-colibri.dtsi   | 598 ++++++++++++++++++
 4 files changed, 676 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-colibri.dtsi

diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 93fce8f0c66d..bd3764e52cfd 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -31,4 +31,5 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mq-pico-pi.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-zii-ultra-rmb3.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8mq-zii-ultra-zest.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-ai_ml.dtb
+dtb-$(CONFIG_ARCH_MXC) += imx8qxp-colibri-eval-v3.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dts b/arch/arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dts
new file mode 100644
index 000000000000..6b21a295c126
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright 2019 Toradex
+ */
+
+/dts-v1/;
+
+#include "imx8qxp-colibri.dtsi"
+#include "imx8qxp-colibri-eval-v3.dtsi"
+
+/ {
+	model = "Toradex Colibri iMX8QXP/DX on Colibri Evaluation Board V3";
+	compatible = "toradex,colibri-imx8x-eval-v3",
+		     "toradex,colibri-imx8x", "fsl,imx8qxp";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dtsi
new file mode 100644
index 000000000000..c7336f387605
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dtsi
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright 2019 Toradex
+ */
+
+#include "dt-bindings/input/linux-event-codes.h"
+
+/ {
+	aliases {
+		rtc0 = &rtc_i2c;
+		rtc1 = &rtc;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpiokeys>;
+
+		wakeup {
+			label = "Wake-Up";
+			gpios = <&lsio_gpio3 10 GPIO_ACTIVE_HIGH>;
+			linux,code = <KEY_WAKEUP>;
+			debounce-interval = <10>;
+			wakeup-source;
+		};
+	};
+};
+
+&adma_i2c1 {
+	status = "okay";
+
+	/* M41T0M6 real time clock on carrier board */
+	rtc_i2c: rtc@68 {
+		compatible = "st,m41t0";
+		reg = <0x68>;
+	};
+};
+
+/* Colibri UART_B */
+&adma_lpuart0 {
+	status= "okay";
+};
+
+/* Colibri UART_C */
+&adma_lpuart2 {
+	status= "okay";
+};
+
+/* Colibri UART_A */
+&adma_lpuart3 {
+	status= "okay";
+};
+
+/* Colibri FastEthernet */
+&fec1 {
+	status = "okay";
+};
+
+/* Colibri SD/MMC Card */
+&usdhc2 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp-colibri.dtsi
new file mode 100644
index 000000000000..75f17a29f81e
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-colibri.dtsi
@@ -0,0 +1,598 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright 2019 Toradex
+ */
+
+#include "imx8qxp.dtsi"
+
+/ {
+	model = "Toradex Colibri iMX8QXP/DX Module";
+	compatible = "toradex,colibri-imx8x", "fsl,imx8qxp";
+
+	chosen {
+		stdout-path = &adma_lpuart3;
+	};
+
+	reg_module_3v3: regulator-module-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "+V3.3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+};
+
+/* On-module I2C */
+&adma_i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c0>, <&pinctrl_sgtl5000_usb_clk>;
+	status = "okay";
+
+	/* Touch controller */
+	touchscreen@2c {
+		compatible = "adi,ad7879-1";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ad7879_int>;
+		reg = <0x2c>;
+		interrupt-parent = <&lsio_gpio3>;
+		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
+		touchscreen-max-pressure = <4096>;
+		adi,resistance-plate-x = <120>;
+		adi,first-conversion-delay = /bits/ 8 <3>;
+		adi,acquisition-time = /bits/ 8 <1>;
+		adi,median-filter-size = /bits/ 8 <2>;
+		adi,averaging = /bits/ 8 <1>;
+		adi,conversion-interval = /bits/ 8 <255>;
+	};
+};
+
+/* Colibri I2C */
+&adma_i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+};
+
+/* Colibri UART_B */
+&adma_lpuart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpuart0>;
+};
+
+/* Colibri UART_C */
+&adma_lpuart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpuart2>;
+};
+
+/* Colibri UART_A */
+&adma_lpuart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpuart3>, <&pinctrl_lpuart3_ctrl>;
+};
+
+/* Colibri FastEthernet */
+&fec1 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_fec1>;
+	pinctrl-1 = <&pinctrl_fec1_sleep>;
+	phy-mode = "rmii";
+	phy-handle = <&ethphy0>;
+	fsl,magic-packet;
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@2 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			max-speed = <100>;
+			reg = <2>;
+		};
+	};
+};
+
+/* On-module eMMC */
+&usdhc1 {
+	bus-width = <8>;
+	non-removable;
+	no-sd;
+	no-sdio;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	status = "okay";
+};
+
+/* Colibri SD/MMC Card */
+&usdhc2 {
+	bus-width = <4>;
+	cd-gpios = <&lsio_gpio3 9 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&reg_module_3v3>;
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
+	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-3 = <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_gpio_sleep>;
+	disable-wp;
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ext_io0>, <&pinctrl_hog0>, <&pinctrl_hog1>;
+
+	/* On-module touch pen-down interrupt */
+	pinctrl_ad7879_int: ad7879intgrp {
+		fsl,pins = <
+			IMX8QXP_MIPI_CSI0_I2C0_SCL_LSIO_GPIO3_IO05	0x21
+		>;
+	};
+
+	/* Colibri Analogue Inputs */
+	pinctrl_adc0: adc0grp {
+		fsl,pins = <
+			IMX8QXP_ADC_IN0_ADMA_ADC_IN0			0x60		/* SODIMM   8 */
+			IMX8QXP_ADC_IN1_ADMA_ADC_IN1			0x60		/* SODIMM   6 */
+			IMX8QXP_ADC_IN4_ADMA_ADC_IN4			0x60		/* SODIMM   4 */
+			IMX8QXP_ADC_IN5_ADMA_ADC_IN5			0x60		/* SODIMM   2 */
+		>;
+	};
+
+	pinctrl_can_int: canintgrp {
+		fsl,pins = <
+			IMX8QXP_QSPI0A_DQS_LSIO_GPIO3_IO13		0x40		/* SODIMM  73 */
+		>;
+	};
+
+	pinctrl_csi_ctl: csictlgrp {
+		fsl,pins = <
+			IMX8QXP_QSPI0A_SS0_B_LSIO_GPIO3_IO14		0x20		/* SODIMM  77 */
+			IMX8QXP_QSPI0A_SS1_B_LSIO_GPIO3_IO15		0x20		/* SODIMM  89 */
+		>;
+	};
+
+	pinctrl_ext_io0: extio0grp {
+		fsl,pins = <
+			IMX8QXP_ENET0_RGMII_RXD3_LSIO_GPIO5_IO08	0x06000040	/* SODIMM 135 */
+		>;
+	};
+
+	/* Colibri Ethernet: On-module 100Mbps PHY Micrel KSZ8041 */
+	pinctrl_fec1: fec1grp {
+		fsl,pins = <
+			IMX8QXP_ENET0_MDC_CONN_ENET0_MDC			0x06000020
+			IMX8QXP_ENET0_MDIO_CONN_ENET0_MDIO			0x06000020
+			IMX8QXP_ENET0_RGMII_TX_CTL_CONN_ENET0_RGMII_TX_CTL	0x61
+			IMX8QXP_ENET0_RGMII_TXC_CONN_ENET0_RCLK50M_OUT		0x06000061
+			IMX8QXP_ENET0_RGMII_TXD0_CONN_ENET0_RGMII_TXD0		0x61
+			IMX8QXP_ENET0_RGMII_TXD1_CONN_ENET0_RGMII_TXD1		0x61
+			IMX8QXP_ENET0_RGMII_RX_CTL_CONN_ENET0_RGMII_RX_CTL	0x61
+			IMX8QXP_ENET0_RGMII_RXD0_CONN_ENET0_RGMII_RXD0		0x61
+			IMX8QXP_ENET0_RGMII_RXD1_CONN_ENET0_RGMII_RXD1		0x61
+			IMX8QXP_ENET0_RGMII_RXD2_CONN_ENET0_RMII_RX_ER		0x61
+		>;
+	};
+
+	pinctrl_fec1_sleep: fec1slpgrp {
+		fsl,pins = <
+			IMX8QXP_ENET0_MDC_LSIO_GPIO5_IO11		0x06000041
+			IMX8QXP_ENET0_MDIO_LSIO_GPIO5_IO10		0x06000041
+			IMX8QXP_ENET0_RGMII_TX_CTL_LSIO_GPIO4_IO30	0x41
+			IMX8QXP_ENET0_RGMII_TXC_LSIO_GPIO4_IO29		0x41
+			IMX8QXP_ENET0_RGMII_TXD0_LSIO_GPIO4_IO31	0x41
+			IMX8QXP_ENET0_RGMII_TXD1_LSIO_GPIO5_IO00	0x41
+			IMX8QXP_ENET0_RGMII_RX_CTL_LSIO_GPIO5_IO04	0x41
+			IMX8QXP_ENET0_RGMII_RXD0_LSIO_GPIO5_IO05	0x41
+			IMX8QXP_ENET0_RGMII_RXD1_LSIO_GPIO5_IO06	0x41
+			IMX8QXP_ENET0_RGMII_RXD2_LSIO_GPIO5_IO07	0x41
+		>;
+	};
+
+	/* Colibri optional CAN on UART_B RTS/CTS */
+	pinctrl_flexcan1: flexcan0grp {
+		fsl,pins = <
+			IMX8QXP_FLEXCAN0_TX_ADMA_FLEXCAN0_TX		0x21		/* SODIMM  32 */
+			IMX8QXP_FLEXCAN0_RX_ADMA_FLEXCAN0_RX		0x21		/* SODIMM  34 */
+		>;
+	};
+
+	/* Colibri optional CAN on PS2 */
+	pinctrl_flexcan2: flexcan1grp {
+		fsl,pins = <
+			IMX8QXP_FLEXCAN1_TX_ADMA_FLEXCAN1_TX		0x21		/* SODIMM  55 */
+			IMX8QXP_FLEXCAN1_RX_ADMA_FLEXCAN1_RX		0x21		/* SODIMM  63 */
+		>;
+	};
+
+	/* Colibri optional CAN on UART_A TXD/RXD */
+	pinctrl_flexcan3: flexcan2grp {
+		fsl,pins = <
+			IMX8QXP_FLEXCAN2_TX_ADMA_FLEXCAN2_TX		0x21		/* SODIMM  35 */
+			IMX8QXP_FLEXCAN2_RX_ADMA_FLEXCAN2_RX		0x21		/* SODIMM  33 */
+		>;
+	};
+
+	/* Colibri LCD Back-Light GPIO */
+	pinctrl_gpio_bl_on: gpioblongrp {
+		fsl,pins = <
+			IMX8QXP_QSPI0A_DATA3_LSIO_GPIO3_IO12		0x60		/* SODIMM  71 */
+		>;
+	};
+
+	pinctrl_gpiokeys: gpiokeysgrp {
+		fsl,pins = <
+			IMX8QXP_QSPI0A_DATA1_LSIO_GPIO3_IO10		0x06700041	/* SODIMM  45 */
+		>;
+	};
+
+	pinctrl_hog0: hog0grp {
+		fsl,pins = <
+			IMX8QXP_ENET0_RGMII_TXD3_LSIO_GPIO5_IO02	0x06000020	/* SODIMM  65 */
+			IMX8QXP_CSI_D07_CI_PI_D09			0x61		/* SODIMM  65 */
+			IMX8QXP_QSPI0A_DATA2_LSIO_GPIO3_IO11		0x20		/* SODIMM  69 */
+			IMX8QXP_SAI0_TXC_LSIO_GPIO0_IO26		0x20		/* SODIMM  79 */
+			IMX8QXP_CSI_D02_CI_PI_D04			0x61		/* SODIMM  79 */
+			IMX8QXP_ENET0_RGMII_RXC_LSIO_GPIO5_IO03		0x06000020	/* SODIMM  85 */
+			IMX8QXP_CSI_D06_CI_PI_D08			0x61		/* SODIMM  85 */
+			IMX8QXP_QSPI0B_SCLK_LSIO_GPIO3_IO17		0x20		/* SODIMM  95 */
+			IMX8QXP_SAI0_RXD_LSIO_GPIO0_IO27		0x20		/* SODIMM  97 */
+			IMX8QXP_CSI_D03_CI_PI_D05			0x61		/* SODIMM  97 */
+			IMX8QXP_QSPI0B_DATA0_LSIO_GPIO3_IO18		0x20		/* SODIMM  99 */
+			IMX8QXP_SAI0_TXFS_LSIO_GPIO0_IO28		0x20		/* SODIMM 101 */
+			IMX8QXP_CSI_D00_CI_PI_D02			0x61		/* SODIMM 101 */
+			IMX8QXP_SAI0_TXD_LSIO_GPIO0_IO25		0x20		/* SODIMM 103 */
+			IMX8QXP_CSI_D01_CI_PI_D03			0x61		/* SODIMM 103 */
+			IMX8QXP_QSPI0B_DATA1_LSIO_GPIO3_IO19		0x20		/* SODIMM 105 */
+			IMX8QXP_QSPI0B_DATA2_LSIO_GPIO3_IO20		0x20		/* SODIMM 107 */
+			IMX8QXP_USB_SS3_TC2_LSIO_GPIO4_IO05		0x20		/* SODIMM 127 */
+			IMX8QXP_USB_SS3_TC3_LSIO_GPIO4_IO06		0x20		/* SODIMM 131 */
+			IMX8QXP_USB_SS3_TC1_LSIO_GPIO4_IO04		0x20		/* SODIMM 133 */
+			IMX8QXP_CSI_PCLK_LSIO_GPIO3_IO00		0x20		/* SODIMM  96 */
+			IMX8QXP_QSPI0B_DATA3_LSIO_GPIO3_IO21		0x20		/* SODIMM  98 */
+			IMX8QXP_SAI1_RXFS_LSIO_GPIO0_IO31		0x20		/* SODIMM 100 */
+			IMX8QXP_QSPI0B_DQS_LSIO_GPIO3_IO22		0x20		/* SODIMM 102 */
+			IMX8QXP_QSPI0B_SS0_B_LSIO_GPIO3_IO23		0x20		/* SODIMM 104 */
+			IMX8QXP_QSPI0B_SS1_B_LSIO_GPIO3_IO24		0x20		/* SODIMM 106 */
+		>;
+	};
+
+	pinctrl_hog1: hog1grp {
+		fsl,pins = <
+			IMX8QXP_CSI_MCLK_LSIO_GPIO3_IO01		0x20		/* SODIMM  75 */
+			IMX8QXP_QSPI0A_SCLK_LSIO_GPIO3_IO16		0x20		/* SODIMM  93 */
+		>;
+	};
+
+	/*
+	 * This pin is used in the SCFW as a UART. Using it from
+	 * Linux would require rewritting the SCFW board file.
+	 */
+	pinctrl_hog_scfw: hogscfwgrp {
+		fsl,pins = <
+			IMX8QXP_SCU_GPIO0_00_LSIO_GPIO2_IO03		0x20		/* SODIMM 144 */
+		>;
+	};
+
+	/* On Module I2C */
+	pinctrl_i2c0: i2c0grp {
+		fsl,pins = <
+			IMX8QXP_MIPI_CSI0_GPIO0_00_ADMA_I2C0_SCL	0x06000021
+			IMX8QXP_MIPI_CSI0_GPIO0_01_ADMA_I2C0_SDA	0x06000021
+		>;
+	};
+
+	/* MIPI DSI I2C accessible on SODIMM (X1) and FFC (X2) */
+	pinctrl_i2c0_mipi_lvds0: i2c0mipilvds0grp {
+		fsl,pins = <
+			IMX8QXP_MIPI_DSI0_I2C0_SCL_MIPI_DSI0_I2C0_SCL	0xc6000020	/* SODIMM 140 */
+			IMX8QXP_MIPI_DSI0_I2C0_SDA_MIPI_DSI0_I2C0_SDA	0xc6000020	/* SODIMM 142 */
+		>;
+	};
+
+	/* MIPI CSI I2C accessible on SODIMM (X1) and FFC (X3) */
+	pinctrl_i2c0_mipi_lvds1: i2c0mipilvds1grp {
+		fsl,pins = <
+			IMX8QXP_MIPI_DSI1_I2C0_SCL_MIPI_DSI1_I2C0_SCL	0xc6000020	/* SODIMM 186 */
+			IMX8QXP_MIPI_DSI1_I2C0_SDA_MIPI_DSI1_I2C0_SDA	0xc6000020	/* SODIMM 188 */
+		>;
+	};
+
+	/* Colibri I2C */
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			IMX8QXP_MIPI_DSI0_GPIO0_00_ADMA_I2C1_SCL	0x06000021	/* SODIMM 196 */
+			IMX8QXP_MIPI_DSI0_GPIO0_01_ADMA_I2C1_SDA	0x06000021	/* SODIMM 194 */
+		>;
+	};
+
+	/* Colibri Parallel RGB LCD Interface */
+	pinctrl_lcdif: lcdifgrp {
+		fsl,pins = <
+			IMX8QXP_MCLK_OUT0_ADMA_LCDIF_CLK		0x60		/* SODIMM  56 */
+			IMX8QXP_SPI3_CS0_ADMA_LCDIF_HSYNC		0x60		/* SODIMM  68 */
+			IMX8QXP_MCLK_IN0_ADMA_LCDIF_VSYNC		0x60		/* SODIMM  82 */
+			IMX8QXP_MCLK_IN1_ADMA_LCDIF_EN			0x60		/* SODIMM  44 */
+			IMX8QXP_USDHC1_RESET_B_LSIO_GPIO4_IO19		0x60		/* SODIMM  44 */
+			IMX8QXP_ESAI0_FSR_ADMA_LCDIF_D00		0x60		/* SODIMM  76 */
+			IMX8QXP_USDHC1_WP_LSIO_GPIO4_IO21		0x60		/* SODIMM  76 */
+			IMX8QXP_ESAI0_FST_ADMA_LCDIF_D01		0x60		/* SODIMM  70 */
+			IMX8QXP_ESAI0_SCKR_ADMA_LCDIF_D02		0x60		/* SODIMM  60 */
+			IMX8QXP_ESAI0_SCKT_ADMA_LCDIF_D03		0x60		/* SODIMM  58 */
+			IMX8QXP_ESAI0_TX0_ADMA_LCDIF_D04		0x60		/* SODIMM  78 */
+			IMX8QXP_ESAI0_TX1_ADMA_LCDIF_D05		0x60		/* SODIMM  72 */
+			IMX8QXP_ESAI0_TX2_RX3_ADMA_LCDIF_D06		0x60		/* SODIMM  80 */
+			IMX8QXP_ESAI0_TX3_RX2_ADMA_LCDIF_D07		0x60		/* SODIMM  46 */
+			IMX8QXP_ESAI0_TX4_RX1_ADMA_LCDIF_D08		0x60		/* SODIMM  62 */
+			IMX8QXP_ESAI0_TX5_RX0_ADMA_LCDIF_D09		0x60		/* SODIMM  48 */
+			IMX8QXP_SPDIF0_RX_ADMA_LCDIF_D10		0x60		/* SODIMM  74 */
+			IMX8QXP_SPDIF0_TX_ADMA_LCDIF_D11		0x60		/* SODIMM  50 */
+			IMX8QXP_SPDIF0_EXT_CLK_ADMA_LCDIF_D12		0x60		/* SODIMM  52 */
+			IMX8QXP_SPI3_SCK_ADMA_LCDIF_D13			0x60		/* SODIMM  54 */
+			IMX8QXP_SPI3_SDO_ADMA_LCDIF_D14			0x60		/* SODIMM  66 */
+			IMX8QXP_SPI3_SDI_ADMA_LCDIF_D15			0x60		/* SODIMM  64 */
+			IMX8QXP_SPI3_CS1_ADMA_LCDIF_D16			0x60		/* SODIMM  57 */
+			IMX8QXP_ENET0_RGMII_TXD2_LSIO_GPIO5_IO01	0x60		/* SODIMM  57 */
+			IMX8QXP_UART1_CTS_B_ADMA_LCDIF_D17		0x60		/* SODIMM  61 */
+		>;
+	};
+
+	/* Colibri SPI */
+	pinctrl_lpspi2: lpspi2grp {
+		fsl,pins = <
+			IMX8QXP_SPI2_CS0_LSIO_GPIO1_IO00		0x21		/* SODIMM  86 */
+			IMX8QXP_SPI2_SDO_ADMA_SPI2_SDO			0x06000040	/* SODIMM  92 */
+			IMX8QXP_SPI2_SDI_ADMA_SPI2_SDI			0x06000040	/* SODIMM  90 */
+			IMX8QXP_SPI2_SCK_ADMA_SPI2_SCK			0x06000040	/* SODIMM  88 */
+		>;
+	};
+
+	/* Colibri UART_B */
+	pinctrl_lpuart0: lpuart0grp {
+		fsl,pins = <
+			IMX8QXP_UART0_RX_ADMA_UART0_RX			0x06000020	/* SODIMM  36 */
+			IMX8QXP_UART0_TX_ADMA_UART0_TX			0x06000020	/* SODIMM  38 */
+			IMX8QXP_FLEXCAN0_RX_ADMA_UART0_RTS_B		0x06000020	/* SODIMM  34 */
+			IMX8QXP_FLEXCAN0_TX_ADMA_UART0_CTS_B		0x06000020	/* SODIMM  32 */
+		>;
+	};
+
+	/* Colibri UART_C */
+	pinctrl_lpuart2: lpuart2grp {
+		fsl,pins = <
+			IMX8QXP_UART2_RX_ADMA_UART2_RX			0x06000020	/* SODIMM  19 */
+			IMX8QXP_UART2_TX_ADMA_UART2_TX			0x06000020	/* SODIMM  21 */
+		>;
+	};
+
+	/* Colibri UART_A */
+	pinctrl_lpuart3: lpuart3grp {
+		fsl,pins = <
+			IMX8QXP_FLEXCAN2_RX_ADMA_UART3_RX		0x06000020	/* SODIMM  33 */
+			IMX8QXP_FLEXCAN2_TX_ADMA_UART3_TX		0x06000020	/* SODIMM  35 */
+		>;
+	};
+
+	/* Colibri UART_A Control */
+	pinctrl_lpuart3_ctrl: lpuart3ctrlgrp {
+		fsl,pins = <
+			IMX8QXP_MIPI_DSI1_GPIO0_01_LSIO_GPIO2_IO00	0x20		/* SODIMM  23 */
+			IMX8QXP_SAI1_RXD_LSIO_GPIO0_IO29		0x20		/* SODIMM  25 */
+			IMX8QXP_SAI1_RXC_LSIO_GPIO0_IO30		0x20		/* SODIMM  27 */
+			IMX8QXP_CSI_RESET_LSIO_GPIO3_IO03		0x20		/* SODIMM  29 */
+			IMX8QXP_USDHC1_CD_B_LSIO_GPIO4_IO22		0x20		/* SODIMM  31 */
+			IMX8QXP_CSI_EN_LSIO_GPIO3_IO02			0x20		/* SODIMM  37 */
+		>;
+	};
+
+	/* On module wifi module */
+	pinctrl_pcieb: pciebgrp {
+		fsl,pins = <
+			IMX8QXP_PCIE_CTRL0_CLKREQ_B_LSIO_GPIO4_IO01	0x04000061	/* SODIMM 178 */
+			IMX8QXP_PCIE_CTRL0_WAKE_B_LSIO_GPIO4_IO02	0x04000061	/* SODIMM  94 */
+			IMX8QXP_PCIE_CTRL0_PERST_B_LSIO_GPIO4_IO00	0x60		/* SODIMM  81 */
+		>;
+	};
+
+	/* Colibri PWM_A */
+	pinctrl_pwm_a: pwmagrp {
+	/* both pins are connected together, reserve the unused CSI_D05 */
+		fsl,pins = <
+			IMX8QXP_CSI_D05_CI_PI_D07			0x61		/* SODIMM  59 */
+			IMX8QXP_SPI0_CS1_ADMA_LCD_PWM0_OUT		0x60		/* SODIMM  59 */
+		>;
+	};
+
+	/* Colibri PWM_B */
+	pinctrl_pwm_b: pwmbgrp {
+		fsl,pins = <
+			IMX8QXP_UART1_TX_LSIO_PWM0_OUT			0x60		/* SODIMM  28 */
+		>;
+	};
+
+	/* Colibri PWM_C */
+	pinctrl_pwm_c: pwmcgrp {
+		fsl,pins = <
+			IMX8QXP_UART1_RX_LSIO_PWM1_OUT			0x60		/* SODIMM  30 */
+		>;
+	};
+
+	/* Colibri PWM_D */
+	pinctrl_pwm_d: pwmdgrp {
+	/* both pins are connected together, reserve the unused CSI_D04 */
+		fsl,pins = <
+			IMX8QXP_CSI_D04_CI_PI_D06			0x61		/* SODIMM  67 */
+			IMX8QXP_UART1_RTS_B_LSIO_PWM2_OUT		0x60		/* SODIMM  67 */
+		>;
+	};
+
+	/* On-module I2S */
+	pinctrl_sai0: sai0grp {
+		fsl,pins = <
+			IMX8QXP_SPI0_SDI_ADMA_SAI0_TXD			0x06000040
+			IMX8QXP_SPI0_CS0_ADMA_SAI0_RXD			0x06000040
+			IMX8QXP_SPI0_SCK_ADMA_SAI0_TXC			0x06000040
+			IMX8QXP_SPI0_SDO_ADMA_SAI0_TXFS			0x06000040
+		>;
+	};
+
+	/* Colibri Audio Analogue Microphone GND */
+	pinctrl_sgtl5000: sgtl5000grp {
+		fsl,pins = <
+			/* MIC GND EN */
+			IMX8QXP_MIPI_CSI0_I2C0_SDA_LSIO_GPIO3_IO06	0x41
+		>;
+	};
+
+	/* On-module SGTL5000 clock */
+	pinctrl_sgtl5000_usb_clk: sgtl5000usbclkgrp {
+		fsl,pins = <
+			IMX8QXP_ADC_IN3_ADMA_ACM_MCLK_OUT0		0x21
+		>;
+	};
+
+	/* On-module USB interrupt */
+	pinctrl_usb3503a: usb3503agrp {
+		fsl,pins = <
+			IMX8QXP_MIPI_CSI0_MCLK_OUT_LSIO_GPIO3_IO04	0x61
+		>;
+	};
+
+	/* Colibri USB Client Cable Detect */
+	pinctrl_usbc_det: usbcdetgrp {
+		fsl,pins = <
+			IMX8QXP_ENET0_REFCLK_125M_25M_LSIO_GPIO5_IO09	0x06000040	/* SODIMM 137 */
+		>;
+	};
+
+	/* USB Host Power Enable */
+	pinctrl_usbh1_reg: usbh1reggrp {
+		fsl,pins = <
+			IMX8QXP_USB_SS3_TC0_LSIO_GPIO4_IO03		0x06000040	/* SODIMM 129 */
+		>;
+	};
+
+	/* On-module eMMC */
+	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			IMX8QXP_EMMC0_CLK_CONN_EMMC0_CLK		0x06000041
+			IMX8QXP_EMMC0_CMD_CONN_EMMC0_CMD		0x21
+			IMX8QXP_EMMC0_DATA0_CONN_EMMC0_DATA0		0x21
+			IMX8QXP_EMMC0_DATA1_CONN_EMMC0_DATA1		0x21
+			IMX8QXP_EMMC0_DATA2_CONN_EMMC0_DATA2		0x21
+			IMX8QXP_EMMC0_DATA3_CONN_EMMC0_DATA3		0x21
+			IMX8QXP_EMMC0_DATA4_CONN_EMMC0_DATA4		0x21
+			IMX8QXP_EMMC0_DATA5_CONN_EMMC0_DATA5		0x21
+			IMX8QXP_EMMC0_DATA6_CONN_EMMC0_DATA6		0x21
+			IMX8QXP_EMMC0_DATA7_CONN_EMMC0_DATA7		0x21
+			IMX8QXP_EMMC0_STROBE_CONN_EMMC0_STROBE		0x41
+			IMX8QXP_EMMC0_RESET_B_CONN_EMMC0_RESET_B	0x21
+		>;
+	};
+
+	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+		fsl,pins = <
+			IMX8QXP_EMMC0_CLK_CONN_EMMC0_CLK		0x06000041
+			IMX8QXP_EMMC0_CMD_CONN_EMMC0_CMD		0x21
+			IMX8QXP_EMMC0_DATA0_CONN_EMMC0_DATA0		0x21
+			IMX8QXP_EMMC0_DATA1_CONN_EMMC0_DATA1		0x21
+			IMX8QXP_EMMC0_DATA2_CONN_EMMC0_DATA2		0x21
+			IMX8QXP_EMMC0_DATA3_CONN_EMMC0_DATA3		0x21
+			IMX8QXP_EMMC0_DATA4_CONN_EMMC0_DATA4		0x21
+			IMX8QXP_EMMC0_DATA5_CONN_EMMC0_DATA5		0x21
+			IMX8QXP_EMMC0_DATA6_CONN_EMMC0_DATA6		0x21
+			IMX8QXP_EMMC0_DATA7_CONN_EMMC0_DATA7		0x21
+			IMX8QXP_EMMC0_STROBE_CONN_EMMC0_STROBE		0x41
+			IMX8QXP_EMMC0_RESET_B_CONN_EMMC0_RESET_B	0x21
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+		fsl,pins = <
+			IMX8QXP_EMMC0_CLK_CONN_EMMC0_CLK		0x06000041
+			IMX8QXP_EMMC0_CMD_CONN_EMMC0_CMD		0x21
+			IMX8QXP_EMMC0_DATA0_CONN_EMMC0_DATA0		0x21
+			IMX8QXP_EMMC0_DATA1_CONN_EMMC0_DATA1		0x21
+			IMX8QXP_EMMC0_DATA2_CONN_EMMC0_DATA2		0x21
+			IMX8QXP_EMMC0_DATA3_CONN_EMMC0_DATA3		0x21
+			IMX8QXP_EMMC0_DATA4_CONN_EMMC0_DATA4		0x21
+			IMX8QXP_EMMC0_DATA5_CONN_EMMC0_DATA5		0x21
+			IMX8QXP_EMMC0_DATA6_CONN_EMMC0_DATA6		0x21
+			IMX8QXP_EMMC0_DATA7_CONN_EMMC0_DATA7		0x21
+			IMX8QXP_EMMC0_STROBE_CONN_EMMC0_STROBE		0x41
+			IMX8QXP_EMMC0_RESET_B_CONN_EMMC0_RESET_B	0x21
+		>;
+	};
+
+	/* Colibri SD/MMC Card Detect */
+	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
+		fsl,pins = <
+			IMX8QXP_QSPI0A_DATA0_LSIO_GPIO3_IO09		0x06000021	/* SODIMM  43 */
+		>;
+	};
+
+	pinctrl_usdhc2_gpio_sleep: usdhc2gpioslpgrp {
+		fsl,pins = <
+			IMX8QXP_QSPI0A_DATA0_LSIO_GPIO3_IO09		0x60		/* SODIMM  43 */
+		>;
+	};
+
+	/* Colibri SD/MMC Card */
+	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			IMX8QXP_USDHC1_CLK_CONN_USDHC1_CLK		0x06000041	/* SODIMM  47 */
+			IMX8QXP_USDHC1_CMD_CONN_USDHC1_CMD		0x21		/* SODIMM 190 */
+			IMX8QXP_USDHC1_DATA0_CONN_USDHC1_DATA0		0x21		/* SODIMM 192 */
+			IMX8QXP_USDHC1_DATA1_CONN_USDHC1_DATA1		0x21		/* SODIMM  49 */
+			IMX8QXP_USDHC1_DATA2_CONN_USDHC1_DATA2		0x21		/* SODIMM  51 */
+			IMX8QXP_USDHC1_DATA3_CONN_USDHC1_DATA3		0x21		/* SODIMM  53 */
+			IMX8QXP_USDHC1_VSELECT_CONN_USDHC1_VSELECT	0x21
+		>;
+	};
+
+	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
+		fsl,pins = <
+			IMX8QXP_USDHC1_CLK_CONN_USDHC1_CLK		0x06000041	/* SODIMM  47 */
+			IMX8QXP_USDHC1_CMD_CONN_USDHC1_CMD		0x21		/* SODIMM 190 */
+			IMX8QXP_USDHC1_DATA0_CONN_USDHC1_DATA0		0x21		/* SODIMM 192 */
+			IMX8QXP_USDHC1_DATA1_CONN_USDHC1_DATA1		0x21		/* SODIMM  49 */
+			IMX8QXP_USDHC1_DATA2_CONN_USDHC1_DATA2		0x21		/* SODIMM  51 */
+			IMX8QXP_USDHC1_DATA3_CONN_USDHC1_DATA3		0x21		/* SODIMM  53 */
+			IMX8QXP_USDHC1_VSELECT_CONN_USDHC1_VSELECT	0x21
+		>;
+	};
+
+	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
+		fsl,pins = <
+			IMX8QXP_USDHC1_CLK_CONN_USDHC1_CLK		0x06000041	/* SODIMM  47 */
+			IMX8QXP_USDHC1_CMD_CONN_USDHC1_CMD		0x21		/* SODIMM 190 */
+			IMX8QXP_USDHC1_DATA0_CONN_USDHC1_DATA0		0x21		/* SODIMM 192 */
+			IMX8QXP_USDHC1_DATA1_CONN_USDHC1_DATA1		0x21		/* SODIMM  49 */
+			IMX8QXP_USDHC1_DATA2_CONN_USDHC1_DATA2		0x21		/* SODIMM  51 */
+			IMX8QXP_USDHC1_DATA3_CONN_USDHC1_DATA3		0x21		/* SODIMM  53 */
+			IMX8QXP_USDHC1_VSELECT_CONN_USDHC1_VSELECT	0x21
+		>;
+	};
+
+	pinctrl_usdhc2_sleep: usdhc2slpgrp {
+		fsl,pins = <
+			IMX8QXP_USDHC1_CLK_LSIO_GPIO4_IO23		0x60		/* SODIMM  47 */
+			IMX8QXP_USDHC1_CMD_LSIO_GPIO4_IO24		0x60		/* SODIMM 190 */
+			IMX8QXP_USDHC1_DATA0_LSIO_GPIO4_IO25		0x60		/* SODIMM 192 */
+			IMX8QXP_USDHC1_DATA1_LSIO_GPIO4_IO26		0x60		/* SODIMM  49 */
+			IMX8QXP_USDHC1_DATA2_LSIO_GPIO4_IO27		0x60		/* SODIMM  51 */
+			IMX8QXP_USDHC1_DATA3_LSIO_GPIO4_IO28		0x60		/* SODIMM  53 */
+			IMX8QXP_USDHC1_VSELECT_CONN_USDHC1_VSELECT	0x21
+		>;
+	};
+
+	pinctrl_wifi: wifigrp {
+		fsl,pins = <
+			IMX8QXP_SCU_BOOT_MODE3_SCU_DSC_RTC_CLOCK_OUTPUT_32K	0x20
+		>;
+	};
+};
-- 
2.21.0

