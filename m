Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3C9CA9EBD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9C02084C
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 13:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572011222;
	bh=1vfCZVf8R7wizvLESCzNOlNuV+dFi7d1UMuZ48enj4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XQc5g9L8CRCLlT7+DGWAv8nXdL3na697mGfEGLOp8k48kJC6Le/csVfINNz3FqkS6
	 qvjaTxL1ilR0I1B6RuNvmFtZT5BmaSqX4KtqjJyhAoBDx7ttahbzIL9+F7JqTAZ1I8
	 kVL2yGQzuzLQ21wUBLC61p48i2meAIiDKhqlSvGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504824AbfJYNrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 09:47:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfJYNrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 09:47:00 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E7B620679;
        Fri, 25 Oct 2019 13:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572011218;
        bh=1vfCZVf8R7wizvLESCzNOlNuV+dFi7d1UMuZ48enj4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mMqo8hYbhXJIdbpc6FDTPulc4ZxjA+LzS8QAEftueDgISuzUydaQ4+9GVT76bcivP
         688n/HlQSz4D8NfDM4ZuggylmPTuZqmYGLSr6qYDodbzO+R8QyL+7ftdFSyBlc1lbE
         R7xAVpkCZUyBMDFK6+M7BLNrP8WDuEfArYYYMQzI=
Date:   Fri, 25 Oct 2019 21:46:24 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        manivannan.sadhasivam@linaro.org, andrew.smirnov@gmail.com,
        marex@denx.de, angus@akkea.ca, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        j.neuschaefer@gmx.net,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH v3 3/3] ARM: dts: imx: add devicetree for Kobo Clara HD
Message-ID: <20191025134621.GN3208@dragon>
References: <20191010192357.27884-1-andreas@kemnade.info>
 <20191010192357.27884-4-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010192357.27884-4-andreas@kemnade.info>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 09:23:57PM +0200, Andreas Kemnade wrote:
> This adds a devicetree for the Kobo Clara HD Ebook reader. It
> is on based on boards called "e60k02". It is equipped with an
> imx6sll SoC.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  arch/arm/boot/dts/Makefile                 |   3 +-
>  arch/arm/boot/dts/imx6sll-kobo-clarahd.dts | 279 +++++++++++++++++++++
>  2 files changed, 281 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/imx6sll-kobo-clarahd.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 9159fa2cea90c..a8a235c74c37f 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -551,7 +551,8 @@ dtb-$(CONFIG_SOC_IMX6SL) += \
>  	imx6sl-evk.dtb \
>  	imx6sl-warp.dtb
>  dtb-$(CONFIG_SOC_IMX6SLL) += \
> -	imx6sll-evk.dtb
> +	imx6sll-evk.dtb \
> +	imx6sll-kobo-clarahd.dtb
>  dtb-$(CONFIG_SOC_IMX6SX) += \
>  	imx6sx-nitrogen6sx.dtb \
>  	imx6sx-sabreauto.dtb \
> diff --git a/arch/arm/boot/dts/imx6sll-kobo-clarahd.dts b/arch/arm/boot/dts/imx6sll-kobo-clarahd.dts
> new file mode 100644
> index 0000000000000..c2df2a567585f
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6sll-kobo-clarahd.dts
> @@ -0,0 +1,279 @@
> +// SPDX-License-Identifier: (GPL-2.0)
> +/*
> + * Device tree for the Kobo Clara HD ebook reader
> + *
> + * Name on mainboard is: 37NB-E60K00+4A4
> + * Serials start with: E60K02 (a number also seen in
> + * vendor kernel sources)
> + *
> + * This mainboard seems to be equipped with different SoCs.
> + * In the Kobo Clara HD ebook reader it is an i.MX6SLL
> + *
> + * Copyright 2019 Andreas Kemnade
> + * based on works
> + * Copyright 2016 Freescale Semiconductor, Inc.
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include "imx6sll.dtsi"
> +#include "e60k02.dtsi"
> +
> +/ {
> +	model = "Kobo Clara HD";
> +	compatible = "kobo,clarahd", "fsl,imx6sll";
> +};
> +
> +&clks {
> +	assigned-clocks = <&clks IMX6SLL_CLK_PLL4_AUDIO_DIV>;
> +	assigned-clock-rates = <393216000>;
> +};
> +
> +&cpu0 {
> +	arm-supply = <&dcdc3_reg>;
> +	soc-supply = <&dcdc1_reg>;
> +};
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hog>;
> +
> +	imx6sll-lpddr3-arm2 {

This container node is not needed.

> +		pinctrl_hog: hoggrp {
> +			fsl,pins = <
> +				MX6SLL_PAD_LCD_DATA00__GPIO2_IO20	0x79
> +				MX6SLL_PAD_LCD_DATA01__GPIO2_IO21	0x79
> +				MX6SLL_PAD_LCD_DATA02__GPIO2_IO22	0x79
> +				MX6SLL_PAD_LCD_DATA03__GPIO2_IO23	0x79
> +				MX6SLL_PAD_LCD_DATA04__GPIO2_IO24	0x79
> +				MX6SLL_PAD_LCD_DATA05__GPIO2_IO25	0x79
> +				MX6SLL_PAD_LCD_DATA06__GPIO2_IO26	0x79
> +				MX6SLL_PAD_LCD_DATA07__GPIO2_IO27	0x79
> +				MX6SLL_PAD_LCD_DATA08__GPIO2_IO28	0x79
> +				MX6SLL_PAD_LCD_DATA09__GPIO2_IO29	0x79
> +				MX6SLL_PAD_LCD_DATA10__GPIO2_IO30	0x79
> +				MX6SLL_PAD_LCD_DATA11__GPIO2_IO31	0x79
> +				MX6SLL_PAD_LCD_DATA12__GPIO3_IO00	0x79
> +				MX6SLL_PAD_LCD_DATA13__GPIO3_IO01	0x79
> +				MX6SLL_PAD_LCD_DATA14__GPIO3_IO02	0x79
> +				MX6SLL_PAD_LCD_DATA15__GPIO3_IO03	0x79
> +				MX6SLL_PAD_LCD_DATA16__GPIO3_IO04	0x79
> +				MX6SLL_PAD_LCD_DATA17__GPIO3_IO05	0x79
> +				MX6SLL_PAD_LCD_DATA18__GPIO3_IO06	0x79
> +				MX6SLL_PAD_LCD_DATA19__GPIO3_IO07	0x79
> +				MX6SLL_PAD_LCD_DATA20__GPIO3_IO08	0x79
> +				MX6SLL_PAD_LCD_DATA21__GPIO3_IO09	0x79
> +				MX6SLL_PAD_LCD_DATA22__GPIO3_IO10	0x79
> +				MX6SLL_PAD_LCD_DATA23__GPIO3_IO11	0x79
> +				MX6SLL_PAD_LCD_CLK__GPIO2_IO15		0x79
> +				MX6SLL_PAD_LCD_ENABLE__GPIO2_IO16	0x79
> +				MX6SLL_PAD_LCD_HSYNC__GPIO2_IO17	0x79
> +				MX6SLL_PAD_LCD_VSYNC__GPIO2_IO18	0x79
> +				MX6SLL_PAD_LCD_RESET__GPIO2_IO19	0x79
> +				MX6SLL_PAD_KEY_COL3__GPIO3_IO30		0x79
> +				MX6SLL_PAD_KEY_ROW7__GPIO4_IO07		0x79
> +				MX6SLL_PAD_ECSPI2_MOSI__GPIO4_IO13	0x79
> +				MX6SLL_PAD_KEY_COL5__GPIO4_IO02		0x79
> +				MX6SLL_PAD_KEY_ROW6__GPIO4_IO05		0x79
> +			>;
> +		};
> +
> +		pinctrl_wifi_reset: wifi_reset_grp {
> +			fsl,pins = <
> +				MX6SLL_PAD_SD2_DATA7__GPIO5_IO00	0x10059		/* WIFI_RST */
> +			>;
> +		};
> +
> +		pinctrl_wifi_power: wifi_power_grp {

I guess you can have one pinctrl node to include both reset and power
pins?  Also, to be consistent with other pinctrl nodes on naming, the
node name should probably be wifigrp.

> +			fsl,pins = <
> +				MX6SLL_PAD_SD2_DATA6__GPIO4_IO29	0x10059		/* WIFI_3V3_ON */
> +			>;
> +		};
> +
> +		pinctrl_audmux3: audmux3grp {

Please keep pinctrl nodes sort alphabetically.

> +			fsl,pins = <
> +				MX6SLL_PAD_AUD_TXC__AUD3_TXC		0x4130b0
> +				MX6SLL_PAD_AUD_TXFS__AUD3_TXFS		0x4130b0
> +				MX6SLL_PAD_AUD_TXD__AUD3_TXD		0x4110b0
> +				MX6SLL_PAD_AUD_RXD__AUD3_RXD		0x4130b0
> +				MX6SLL_PAD_AUD_MCLK__AUDIO_CLK_OUT	0x4130b0
> +			>;
> +		};
> +
> +		pinctrl_led: ledgrp {
> +			fsl,pins = <
> +				MX6SLL_PAD_SD1_DATA6__GPIO5_IO07 0x17059
> +			>;
> +		};
> +
> +		pinctrl_uart1: uart1grp {
> +			fsl,pins = <
> +				MX6SLL_PAD_UART1_TXD__UART1_DCE_TX 0x1b0b1
> +				MX6SLL_PAD_UART1_RXD__UART1_DCE_RX 0x1b0b1
> +			>;
> +		};
> +
> +		pinctrl_usdhc2: usdhc2grp {
> +			fsl,pins = <
> +				MX6SLL_PAD_SD2_CMD__SD2_CMD		0x17059
> +				MX6SLL_PAD_SD2_CLK__SD2_CLK		0x13059
> +				MX6SLL_PAD_SD2_DATA0__SD2_DATA0		0x17059
> +				MX6SLL_PAD_SD2_DATA1__SD2_DATA1		0x17059
> +				MX6SLL_PAD_SD2_DATA2__SD2_DATA2		0x17059
> +				MX6SLL_PAD_SD2_DATA3__SD2_DATA3		0x17059
> +			>;
> +		};
> +
> +		pinctrl_usdhc2_100mhz: usdhc2grp_100mhz {

We generally use hyphen than underscore in node name.

Shawn

> +			fsl,pins = <
> +				MX6SLL_PAD_SD2_CMD__SD2_CMD		0x170b9
> +				MX6SLL_PAD_SD2_CLK__SD2_CLK		0x130b9
> +				MX6SLL_PAD_SD2_DATA0__SD2_DATA0		0x170b9
> +				MX6SLL_PAD_SD2_DATA1__SD2_DATA1		0x170b9
> +				MX6SLL_PAD_SD2_DATA2__SD2_DATA2		0x170b9
> +				MX6SLL_PAD_SD2_DATA3__SD2_DATA3		0x170b9
> +			>;
> +		};
> +
> +		pinctrl_usdhc2_200mhz: usdhc2grp_200mhz {
> +			fsl,pins = <
> +				MX6SLL_PAD_SD2_CMD__SD2_CMD		0x170f9
> +				MX6SLL_PAD_SD2_CLK__SD2_CLK		0x130f9
> +				MX6SLL_PAD_SD2_DATA0__SD2_DATA0		0x170f9
> +				MX6SLL_PAD_SD2_DATA1__SD2_DATA1		0x170f9
> +				MX6SLL_PAD_SD2_DATA2__SD2_DATA2		0x170f9
> +				MX6SLL_PAD_SD2_DATA3__SD2_DATA3		0x170f9
> +			>;
> +		};
> +
> +		pinctrl_usdhc2_sleep: usdhc2grp_sleep {
> +			fsl,pins = <
> +				MX6SLL_PAD_SD2_CMD__GPIO5_IO04		0x100f9
> +				MX6SLL_PAD_SD2_CLK__GPIO5_IO05		0x100f9
> +				MX6SLL_PAD_SD2_DATA0__GPIO5_IO01	0x100f9
> +				MX6SLL_PAD_SD2_DATA1__GPIO4_IO30	0x100f9
> +				MX6SLL_PAD_SD2_DATA2__GPIO5_IO03	0x100f9
> +				MX6SLL_PAD_SD2_DATA3__GPIO4_IO28	0x100f9
> +			>;
> +		};
> +
> +		pinctrl_usdhc3: usdhc3grp {
> +			fsl,pins = <
> +				MX6SLL_PAD_SD3_CMD__SD3_CMD	0x11059
> +				MX6SLL_PAD_SD3_CLK__SD3_CLK	0x11059
> +				MX6SLL_PAD_SD3_DATA0__SD3_DATA0	0x11059
> +				MX6SLL_PAD_SD3_DATA1__SD3_DATA1	0x11059
> +				MX6SLL_PAD_SD3_DATA2__SD3_DATA2	0x11059
> +				MX6SLL_PAD_SD3_DATA3__SD3_DATA3	0x11059
> +			>;
> +		};
> +
> +		pinctrl_usdhc3_100mhz: usdhc3grp_100mhz {
> +			fsl,pins = <
> +				MX6SLL_PAD_SD3_CMD__SD3_CMD	0x170b9
> +				MX6SLL_PAD_SD3_CLK__SD3_CLK	0x170b9
> +				MX6SLL_PAD_SD3_DATA0__SD3_DATA0	0x170b9
> +				MX6SLL_PAD_SD3_DATA1__SD3_DATA1	0x170b9
> +				MX6SLL_PAD_SD3_DATA2__SD3_DATA2	0x170b9
> +				MX6SLL_PAD_SD3_DATA3__SD3_DATA3	0x170b9
> +			>;
> +		};
> +
> +		pinctrl_usdhc3_200mhz: usdhc3grp_200mhz {
> +			fsl,pins = <
> +				MX6SLL_PAD_SD3_CMD__SD3_CMD	0x170f9
> +				MX6SLL_PAD_SD3_CLK__SD3_CLK	0x170f9
> +				MX6SLL_PAD_SD3_DATA0__SD3_DATA0	0x170f9
> +				MX6SLL_PAD_SD3_DATA1__SD3_DATA1	0x170f9
> +				MX6SLL_PAD_SD3_DATA2__SD3_DATA2	0x170f9
> +				MX6SLL_PAD_SD3_DATA3__SD3_DATA3	0x170f9
> +			>;
> +		};
> +
> +		pinctrl_usdhc3_sleep: usdhc3grp_sleep {
> +			fsl,pins = <
> +				MX6SLL_PAD_SD3_CMD__GPIO5_IO21	0x100c1
> +				MX6SLL_PAD_SD3_CLK__GPIO5_IO18	0x100c1
> +				MX6SLL_PAD_SD3_DATA0__GPIO5_IO19	0x100c1
> +				MX6SLL_PAD_SD3_DATA1__GPIO5_IO20	0x100c1
> +				MX6SLL_PAD_SD3_DATA2__GPIO5_IO16	0x100c1
> +				MX6SLL_PAD_SD3_DATA3__GPIO5_IO17	0x100c1
> +			>;
> +		};
> +
> +		pinctrl_usbotg1: usbotg1grp {
> +			fsl,pins = <
> +				MX6SLL_PAD_EPDC_PWR_COM__USB_OTG1_ID 0x17059
> +			>;
> +		};
> +
> +		pinctrl_i2c1: i2c1grp {
> +			fsl,pins = <
> +				MX6SLL_PAD_I2C1_SCL__I2C1_SCL	 0x4001f8b1
> +				MX6SLL_PAD_I2C1_SDA__I2C1_SDA	 0x4001f8b1
> +			>;
> +		};
> +
> +		pinctrl_i2c1_sleep: i2c1grp_sleep {
> +			fsl,pins = <
> +				MX6SLL_PAD_I2C1_SCL__I2C1_SCL	 0x400108b1
> +				MX6SLL_PAD_I2C1_SDA__I2C1_SDA	 0x400108b1
> +			>;
> +		};
> +
> +		pinctrl_i2c2: i2c2grp {
> +			fsl,pins = <
> +				MX6SLL_PAD_I2C2_SCL__I2C2_SCL	 0x4001f8b1
> +				MX6SLL_PAD_I2C2_SDA__I2C2_SDA	 0x4001f8b1
> +			>;
> +		};
> +
> +		pinctrl_i2c2_sleep: i2c2grp_sleep {
> +			fsl,pins = <
> +				MX6SLL_PAD_I2C2_SCL__I2C2_SCL	 0x400108b1
> +				MX6SLL_PAD_I2C2_SDA__I2C2_SDA	 0x400108b1
> +			>;
> +		};
> +
> +		pinctrl_i2c3: i2c3grp {
> +			fsl,pins = <
> +				MX6SLL_PAD_REF_CLK_24M__I2C3_SCL  0x4001f8b1
> +				MX6SLL_PAD_REF_CLK_32K__I2C3_SDA  0x4001f8b1
> +			>;
> +		};
> +
> +		pinctrl_ecspi1: ecspi1grp {
> +			fsl,pins = <
> +				MX6SLL_PAD_ECSPI1_MISO__ECSPI1_MISO	 0x100b1
> +				MX6SLL_PAD_ECSPI1_MOSI__ECSPI1_MOSI	 0x100b1
> +				MX6SLL_PAD_ECSPI1_SCLK__ECSPI1_SCLK	 0x100b1
> +				MX6SLL_PAD_ECSPI1_SS0__GPIO4_IO11	 0x100b1
> +			>;
> +		};
> +
> +		pinctrl_lm3630a_bl_gpio: lm3630a_bl_gpio_grp {
> +			fsl,pins = <
> +				MX6SLL_PAD_EPDC_PWR_CTRL3__GPIO2_IO10	0x10059 /* HWEN */
> +			>;
> +		};
> +
> +		pinctrl_ricoh_gpio: ricoh_gpio_grp {
> +			fsl,pins = <
> +				MX6SLL_PAD_SD1_CLK__GPIO5_IO15	0x1b8b1 /* ricoh619 chg */
> +				MX6SLL_PAD_SD1_DATA0__GPIO5_IO11 0x1b8b1 /* ricoh619 irq */
> +				MX6SLL_PAD_KEY_COL2__GPIO3_IO28	0x1b8b1 /* ricoh619 bat_low_int */
> +			>;
> +		};
> +
> +		pinctrl_gpio_keys: gpio_keys_grp {
> +			fsl,pins = <
> +				MX6SLL_PAD_SD1_DATA1__GPIO5_IO08	0x17059	/* PWR_SW */
> +				MX6SLL_PAD_SD1_DATA4__GPIO5_IO12	0x17059	/* HALL_EN */
> +			>;
> +		};
> +
> +	};
> +};
> +
> -- 
> 2.20.1
> 
