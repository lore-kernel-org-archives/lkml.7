Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B392BC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D02250C9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 12:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559564253;
	bh=sBfDXaKYYspOaLjvuV3ipW7W6LXBlb3ERQHLAVWIPlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b/9xXCiEJwyxTYW4wf0jNiiBfLfSIphaZdU768oB4Uulhpn/svl18oUoxOlT/iP7K
	 iGL/0XZWA0cQe5yHKGDbfe+RzNPB8dHfxjpLMC2h89AT1rj5nP+S2ZgqiTvM3U/BRj
	 8ZudvZ+QQoc9jZ++maXnnBqGgmkYcVD4MKnSy5XA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfFCMRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 08:17:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbfFCMRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 08:17:32 -0400
Received: from dragon (li1232-89.members.linode.com [45.79.133.89])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 867A221BE2;
        Mon,  3 Jun 2019 12:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559564251;
        bh=sBfDXaKYYspOaLjvuV3ipW7W6LXBlb3ERQHLAVWIPlI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xvi/1IADssYIdEdIjsoD4fcUzYtjmXMeuKfBohG95/AzL7AMCkQNGC3j79wJAvPI1
         W3G+hnKKXnQAwueZqSczKKQ85TjpIWNZcAkqg/O+6ozGL81agaSm5zPODSuQcD2AQ+
         +evOeNkIWhOVejfjpxexai0j5b9N3WGLQ2pnt9AQ=
Date:   Mon, 3 Jun 2019 20:17:17 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     s.hauer@pengutronix.de, robh+dt@kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, pbrobinson@gmail.com,
        yossi@novtech.com, nazik@novtech.com
Subject: Re: [PATCH 2/2] ARM: dts: Add support for 96Boards Meerkat96 board
Message-ID: <20190603121710.GB15919@dragon>
References: <20190522131550.9034-1-manivannan.sadhasivam@linaro.org>
 <20190522131550.9034-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522131550.9034-3-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 06:45:50PM +0530, Manivannan Sadhasivam wrote:
> Add devicetree support for 96Boards Meerkat96 board from Novtech. This
> board is one of the Consumer Edition boards of the 96Boards family based
> on i.MX7D SoC. Following are the currently supported features of the
> board:
> 
> * uSD
> * WiFi/BT
> * USB
> 
> More information about this board can be found in 96Boards product page:
> https://www.96boards.org/product/imx7-96/
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm/boot/dts/Makefile            |   1 +
>  arch/arm/boot/dts/imx7d-meerkat96.dts | 396 ++++++++++++++++++++++++++
>  2 files changed, 397 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx7d-meerkat96.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index f4f5aeaf3298..3018a763dbd1 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -579,6 +579,7 @@ dtb-$(CONFIG_SOC_IMX7D) += \
>  	imx7d-cl-som-imx7.dtb \
>  	imx7d-colibri-emmc-eval-v3.dtb \
>  	imx7d-colibri-eval-v3.dtb \
> +	imx7d-meerkat96.dtb \
>  	imx7d-nitrogen7.dtb \
>  	imx7d-pico-hobbit.dtb \
>  	imx7d-pico-pi.dtb \
> diff --git a/arch/arm/boot/dts/imx7d-meerkat96.dts b/arch/arm/boot/dts/imx7d-meerkat96.dts
> new file mode 100644
> index 000000000000..7898d27340f6
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx7d-meerkat96.dts
> @@ -0,0 +1,396 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Copyright (C) 2019 Linaro Ltd.
> + */
> +
> +/dts-v1/;
> +
> +#include "imx7d.dtsi"
> +
> +/ {
> +	model = "96Boards Meerkat96 Board";
> +	compatible = "novtech,imx7d-meerkat96", "fsl,imx7d";
> +
> +	chosen {
> +		stdout-path = &uart6;
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x20000000>; /* 512MB */
> +	};
> +
> +	reg_wlreg_on: regulator-wlreg_on {

Use hyphen consistently in node name: regulator-wlreg-on

> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_wlreg_on>;
> +		regulator-name = "wlreg_on";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		startup-delay-us = <100>;
> +		gpio = <&gpio6 15 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		regulator-always-on;
> +	};
> +
> +	reg_3p3v: regulator-3p3v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "3P3V";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
> +
> +	reg_usb_otg1_vbus: regulator-usb-otg1-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb_otg1_vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +	};
> +
> +	reg_usb_otg2_vbus: regulator-usb-otg2-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb_otg2_vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&gpio1 2 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	sw1a_reg: sw1a {
> +		regulator-name = "sw1a_reg";

Is it a fixed regulator or what?

> +		regulator-min-microvolt = <700000>;
> +		regulator-max-microvolt = <1475000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +		regulator-ramp-delay = <6250>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_leds>;
> +
> +		led1 {
> +			label = "green:user1";
> +			gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "heartbeat";
> +			default-state = "off";
> +		};
> +
> +		led2 {
> +			label = "green:user2";
> +			gpios = <&gpio1 5 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "mmc0";
> +			default-state = "off";
> +		};
> +
> +		led3 {
> +			label = "green:user3";
> +			gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "mmc1";
> +			default-state = "off";
> +		};
> +
> +		led4 {
> +			label = "green:user4";
> +			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "none";
> +			default-state = "off";
> +			panic-indicator;
> +		};
> +
> +		led@5 {

led5

> +			label = "yellow:wlan";
> +			gpios = <&gpio1 0 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "phy0tx";
> +			default-state = "off";
> +		};
> +
> +		led@6 {

led6

> +			label = "blue:bt";
> +			gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "bluetooth-power";
> +			default-state = "off";
> +		};
> +	};
> +};
> +
> +&cpu0 {
> +	cpu-supply = <&sw1a_reg>;
> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	status = "okay";
> +};
> +
> +&i2c3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	status = "okay";
> +};
> +
> +&i2c4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c4>;
> +	status = "okay";
> +};
> +
> +&lcdif {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_lcdif>;
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	assigned-clocks = <&clks IMX7D_UART1_ROOT_SRC>;
> +	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
> +	status = "okay";
> +};
> +
> +&uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart3>;
> +	assigned-clocks = <&clks IMX7D_UART3_ROOT_SRC>;
> +	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
> +	fsl,uart-has-rtscts;

fsl,uart-has-rtscts is deprecated, should use uart-has-rtscts instead.

> +	status = "okay";
> +};
> +
> +&uart6 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart6>;
> +	assigned-clocks = <&clks IMX7D_UART6_ROOT_SRC>;
> +	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
> +	status = "okay";
> +};
> +
> +&uart7 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart7 &pinctrl_bt_gpios>;
> +	assigned-clocks = <&clks IMX7D_UART7_ROOT_SRC>;
> +	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
> +	fsl,uart-has-rtscts;

Ditto

> +	fsl,dte-mode;
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "brcm,bcm43438-bt";
> +		device-wakeup-gpios = <&gpio6 13 GPIO_ACTIVE_HIGH>;
> +		host-wakeup-gpios = <&gpio4 17 GPIO_ACTIVE_HIGH>;
> +	};
> +};
> +
> +&usbotg1 {
> +	vbus-supply = <&reg_usb_otg1_vbus>;
> +	status = "okay";
> +};
> +
> +&usbotg2 {
> +	vbus-supply = <&reg_usb_otg2_vbus>;
> +	dr_mode = "host";
> +	status = "okay";
> +};
> +
> +&usdhc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	keep-power-in-suspend;
> +	tuning-step = <2>;
> +	vmmc-supply = <&reg_3p3v>;
> +	no-1-8-v;
> +	broken-cd;
> +	status = "okay";
> +};
> +
> +&usdhc3 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc3>;
> +	bus-width = <4>;
> +	no-1-8-v;
> +	no-mmc;
> +	non-removable;
> +	keep-power-in-suspend;
> +	enable-sdio-wakeup;

Should use 'wakeup-source'.  See bindings/power/wakeup-source.txt.

> +	vmmc-supply = <&reg_wlreg_on>;
> +	vqmmc-supply =<&reg_3p3v>;
> +	status = "okay";
> +
> +	brcmf: wifi@1 {
> +		reg = <1>;
> +		compatible = "brcm,bcm4329-fmac";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_wlan_irq>;
> +		interrupt-parent = <&gpio6>;
> +		interrupts = <14 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "host-wake";
> +	};
> +};
> +
> +&iomuxc {
> +	imx7d-sdb {

This container node is unnecessary now, and can be dropped to save one
level of indentation.

> +		pinctrl_bt_gpios: bt_gpios {

Please name these pinctrl group node more consistently, something like
below:

	pinctrl_xxx: xxxgrp {
		...
	};

Also keep them alphabetically sorted.

> +			fsl,pins = <
> +				MX7D_PAD_SAI1_TX_BCLK__GPIO6_IO13	0x59
> +				MX7D_PAD_ECSPI1_MOSI__GPIO4_IO17	0x1f
> +			>;
> +		};
> +
> +		pinctrl_i2c1: i2c1grp {
> +			fsl,pins = <
> +				MX7D_PAD_I2C1_SDA__I2C1_SDA		0x4000007f
> +				MX7D_PAD_I2C1_SCL__I2C1_SCL		0x4000007f
> +			>;
> +		};
> +
> +		pinctrl_i2c2: i2c2grp {
> +			fsl,pins = <
> +				MX7D_PAD_I2C2_SDA__I2C2_SDA		0x4000007f
> +				MX7D_PAD_I2C2_SCL__I2C2_SCL		0x4000007f
> +			>;
> +		};
> +
> +		pinctrl_i2c3: i2c3grp {
> +			fsl,pins = <
> +				MX7D_PAD_ENET1_RGMII_RD1__I2C3_SDA	0x4000007f
> +				MX7D_PAD_ENET1_RGMII_RD0__I2C3_SCL	0x4000007f
> +			>;
> +		};
> +
> +		pinctrl_i2c4: i2c4grp {
> +			fsl,pins = <
> +				MX7D_PAD_SAI1_RX_BCLK__I2C4_SDA		0x4000007f
> +				MX7D_PAD_SAI1_RX_SYNC__I2C4_SCL		0x4000007f
> +			>;
> +		};
> +
> +		pinctrl_lcdif: lcdifgrp {
> +			fsl,pins = <
> +				MX7D_PAD_LCD_DATA00__LCD_DATA0		0x79
> +				MX7D_PAD_LCD_DATA01__LCD_DATA1		0x79
> +				MX7D_PAD_LCD_DATA02__LCD_DATA2		0x79
> +				MX7D_PAD_LCD_DATA03__LCD_DATA3		0x79
> +				MX7D_PAD_LCD_DATA04__LCD_DATA4		0x79
> +				MX7D_PAD_LCD_DATA05__LCD_DATA5		0x79
> +				MX7D_PAD_LCD_DATA06__LCD_DATA6		0x79
> +				MX7D_PAD_LCD_DATA07__LCD_DATA7		0x79
> +				MX7D_PAD_LCD_DATA08__LCD_DATA8		0x79
> +				MX7D_PAD_LCD_DATA09__LCD_DATA9		0x79
> +				MX7D_PAD_LCD_DATA10__LCD_DATA10		0x79
> +				MX7D_PAD_LCD_DATA11__LCD_DATA11		0x79
> +				MX7D_PAD_LCD_DATA12__LCD_DATA12		0x79
> +				MX7D_PAD_LCD_DATA13__LCD_DATA13		0x79
> +				MX7D_PAD_LCD_DATA14__LCD_DATA14		0x79
> +				MX7D_PAD_LCD_DATA15__LCD_DATA15		0x79
> +				MX7D_PAD_LCD_DATA16__LCD_DATA16		0x79
> +				MX7D_PAD_LCD_DATA17__LCD_DATA17		0x79
> +				MX7D_PAD_LCD_DATA18__LCD_DATA18		0x79
> +				MX7D_PAD_LCD_DATA19__LCD_DATA19		0x79
> +				MX7D_PAD_LCD_DATA20__LCD_DATA20		0x79
> +				MX7D_PAD_LCD_DATA21__LCD_DATA21		0x79
> +				MX7D_PAD_LCD_DATA22__LCD_DATA22		0x79
> +				MX7D_PAD_LCD_DATA23__LCD_DATA23		0x79
> +				MX7D_PAD_LCD_CLK__LCD_CLK		0x79
> +				MX7D_PAD_LCD_ENABLE__LCD_ENABLE		0x79
> +				MX7D_PAD_LCD_VSYNC__LCD_VSYNC		0x79
> +				MX7D_PAD_LCD_HSYNC__LCD_HSYNC		0x79
> +				MX7D_PAD_LCD_RESET__LCD_RESET		0x79
> +			>;
> +		};
> +
> +		pinctrl_gpio_leds: gpioledsgrp {
> +			fsl,pins = <
> +				MX7D_PAD_LPSR_GPIO1_IO00__GPIO1_IO0	0x59
> +				MX7D_PAD_LPSR_GPIO1_IO04__GPIO1_IO4	0x59
> +				MX7D_PAD_LPSR_GPIO1_IO05__GPIO1_IO5	0x59
> +				MX7D_PAD_LPSR_GPIO1_IO06__GPIO1_IO6	0x59
> +				MX7D_PAD_LPSR_GPIO1_IO07__GPIO1_IO7	0x59
> +				MX7D_PAD_SD1_RESET_B__GPIO5_IO2		0x59
> +			>;
> +		};
> +
> +		pinctrl_tda998x: hdmigrp-1 {

Unused?  Maybe add it later when needed.

Shawn

> +			fsl,pins = <
> +				MX7D_PAD_EPDC_BDR0__GPIO2_IO28		0x59
> +			>;
> +		};
> +
> +		pinctrl_uart1: uart1grp {
> +			fsl,pins = <
> +				MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
> +				MX7D_PAD_UART1_RX_DATA__UART1_DCE_RX	0x79
> +			>;
> +		};
> +
> +		pinctrl_uart3: uart3grp {
> +			fsl,pins = <
> +				MX7D_PAD_SD3_DATA4__UART3_DCE_RX	0x79
> +				MX7D_PAD_SD3_DATA5__UART3_DCE_TX	0x79
> +				MX7D_PAD_SD3_DATA6__UART3_DCE_RTS	0x79
> +				MX7D_PAD_SD3_DATA7__UART3_DCE_CTS	0x79
> +			>;
> +		};
> +
> +		pinctrl_uart6: uart6grp {
> +			fsl,pins = <
> +				MX7D_PAD_SD1_CD_B__UART6_DCE_RX		0x79
> +				MX7D_PAD_SD1_WP__UART6_DCE_TX		0x79
> +			>;
> +		};
> +
> +		pinctrl_uart7: uart7grp {
> +			fsl,pins = <
> +				MX7D_PAD_ECSPI2_SCLK__UART7_DTE_TX	0x79
> +				MX7D_PAD_ECSPI2_MOSI__UART7_DTE_RX	0x79
> +				MX7D_PAD_ECSPI2_MISO__UART7_DTE_CTS	0x79
> +				MX7D_PAD_ECSPI2_SS0__UART7_DTE_RTS	0x79
> +			>;
> +		};
> +
> +		pinctrl_usdhc1: usdhc1grp {
> +			fsl,pins = <
> +				MX7D_PAD_SD1_CMD__SD1_CMD		0x59
> +				MX7D_PAD_SD1_CLK__SD1_CLK		0x19
> +				MX7D_PAD_SD1_DATA0__SD1_DATA0		0x59
> +				MX7D_PAD_SD1_DATA1__SD1_DATA1		0x59
> +				MX7D_PAD_SD1_DATA2__SD1_DATA2		0x59
> +				MX7D_PAD_SD1_DATA3__SD1_DATA3		0x59
> +			>;
> +		};
> +
> +		pinctrl_usdhc3: usdhc3grp {
> +			fsl,pins = <
> +				MX7D_PAD_SD3_CMD__SD3_CMD		0x59
> +				MX7D_PAD_SD3_CLK__SD3_CLK		0x0D
> +				MX7D_PAD_SD3_DATA0__SD3_DATA0		0x59
> +				MX7D_PAD_SD3_DATA1__SD3_DATA1		0x59
> +				MX7D_PAD_SD3_DATA2__SD3_DATA2		0x59
> +				MX7D_PAD_SD3_DATA3__SD3_DATA3		0x59
> +			>;
> +		};
> +
> +		pinctrl_wlreg_on: wlreg_on {
> +			fsl,pins = <
> +				MX7D_PAD_SAI1_TX_DATA__GPIO6_IO15	0x19
> +			>;
> +		};
> +
> +		pinctrl_wlan_irq: wlan_irq {
> +			fsl,pins = <
> +				MX7D_PAD_SAI1_TX_SYNC__GPIO6_IO14	0x19
> +			>;
> +		};
> +	};
> +};
> -- 
> 2.17.1
> 
