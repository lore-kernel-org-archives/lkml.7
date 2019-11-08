Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19D1FC6195
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96ED62075C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="sG3Jzje1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbfKHSe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 13:34:58 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:13015 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfKHSe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:34:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573238095;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=GnRw42vPtsFekp3j/5R3etXbDUBgSRlx8obp99khaMk=;
        b=sG3Jzje18iLlLnV4rm8fvOOeT9HjUnpnbHKjEaFqtcX6d0H/FBjVhI5LDEeFGxDg37
        9W7CP97GVgnrlyzUmSz6Iw+Zcu4KHtt9gs4IW/wxbg3Z0XEVWf9EUONTsxzxkbqe0xiO
        MEOwIBrn5FzJSIBqK/Naxf/O+ENo9yeA7yUo1xm38hspWWvhiqKud+H0sUjcMuuRQ8+B
        oxYZANHo+D4x2S7QlW7gdV0xrT7PSz/+IW4BoAeig44BfARv6mH3UMpdAmzGqRygm2Kr
        45WN49ykTwofXmD3cTP0QVJxB6P4x+qVzitMBmxdULn9qRY0SFGhvTXoewCC/I3lRMCe
        8Kuw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Qpw97WFDleUXAoPgQ=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.29.0 DYNA|AUTH)
        with ESMTPSA id L09db3vA8IYomD3
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 8 Nov 2019 19:34:50 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [Letux-kernel] [PATCH 2/2] ARM: dts: add devicetree entry for Tolino Shine 3
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20191108111834.18610-3-andreas@kemnade.info>
Date:   Fri, 8 Nov 2019 19:34:50 +0100
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, andrew.smirnov@gmail.com,
        manivannan.sadhasivam@linaro.org,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        j.neuschaefer@gmx.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <F3C4901A-411E-4ED1-B765-AF3EE0FC1CF9@goldelico.com>
References: <20191108111834.18610-1-andreas@kemnade.info> <20191108111834.18610-3-andreas@kemnade.info>
To:     Andreas Kemnade <andreas@kemnade.info>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 08.11.2019 um 12:18 schrieb Andreas Kemnade <andreas@kemnade.info>:
>=20
> The device is almost identical to the Kobo Clara HD. The only
> spotted difference is the SoC. It contains an imx6sl
> instead of an imx6sll.
>=20
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> arch/arm/boot/dts/Makefile                 |   1 +
> arch/arm/boot/dts/imx6sl-tolino-shine3.dts | 326 =
+++++++++++++++++++++++++++++
> 2 files changed, 327 insertions(+)
> create mode 100644 arch/arm/boot/dts/imx6sl-tolino-shine3.dts
>=20
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index f969c37729d5..1486615470b2 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -550,6 +550,7 @@ dtb-$(CONFIG_SOC_IMX6Q) +=3D \
> 	imx6qp-zii-rdu2.dtb
> dtb-$(CONFIG_SOC_IMX6SL) +=3D \
> 	imx6sl-evk.dtb \
> +	imx6sl-tolino-shine3.dtb \
> 	imx6sl-warp.dtb
> dtb-$(CONFIG_SOC_IMX6SLL) +=3D \
> 	imx6sll-evk.dtb \
> diff --git a/arch/arm/boot/dts/imx6sl-tolino-shine3.dts =
b/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
> new file mode 100644
> index 000000000000..0ee49258f22c
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
> @@ -0,0 +1,326 @@
> +// SPDX-License-Identifier: (GPL-2.0)
> +/*
> + * Device tree for the Tolino Shine 3 ebook reader
> + *
> + * Name on mainboard is: 37NB-E60K00+4A4
> + * Serials start with: E60K02 (a number also seen in
> + * vendor kernel sources)
> + *
> + * This mainboard seems to be equipped with different SoCs.
> + * In the Toline Shine 3 ebook reader it is a i.MX6SL
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
> +#include "imx6sl.dtsi"
> +#include "e60k02.dtsi"
> +
> +/ {
> +	model =3D "Tolino Shine 3";
> +	compatible =3D "kobo,tolino-shine3", "fsl,imx6sl";
> +};
> +
> +&gpio_keys {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_gpio_keys>;
> +};
> +
> +&i2c1 {
> +	pinctrl-names =3D "default","sleep";
> +	pinctrl-0 =3D <&pinctrl_i2c1>;
> +	pinctrl-1 =3D <&pinctrl_i2c1_sleep>;
> +};
> +
> +&i2c2 {
> +	pinctrl-names =3D "default","sleep";
> +	pinctrl-0 =3D <&pinctrl_i2c2>;
> +	pinctrl-1 =3D <&pinctrl_i2c2_sleep>;
> +};
> +
> +&i2c3 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_i2c3>;
> +};
> +
> +&iomuxc {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_hog>;
> +
> +	pinctrl_gpio_keys: gpio-keysgrp {
> +		fsl,pins =3D <
> +			MX6SL_PAD_SD1_DAT1__GPIO5_IO08	0x17059	/* =
PWR_SW */
> +			MX6SL_PAD_SD1_DAT4__GPIO5_IO12	0x17059	/* =
HALL_EN */
> +		>;
> +	};
> +
> +	pinctrl_hog: hoggrp {
> +		fsl,pins =3D <
> +			MX6SL_PAD_LCD_DAT0__GPIO2_IO20	0x79
> +			MX6SL_PAD_LCD_DAT1__GPIO2_IO21	0x79
> +			MX6SL_PAD_LCD_DAT2__GPIO2_IO22	0x79
> +			MX6SL_PAD_LCD_DAT3__GPIO2_IO23	0x79
> +			MX6SL_PAD_LCD_DAT4__GPIO2_IO24	0x79
> +			MX6SL_PAD_LCD_DAT5__GPIO2_IO25	0x79
> +			MX6SL_PAD_LCD_DAT6__GPIO2_IO26	0x79
> +			MX6SL_PAD_LCD_DAT7__GPIO2_IO27	0x79
> +			MX6SL_PAD_LCD_DAT8__GPIO2_IO28	0x79
> +			MX6SL_PAD_LCD_DAT9__GPIO2_IO29	0x79
> +			MX6SL_PAD_LCD_DAT10__GPIO2_IO30	0x79
> +			MX6SL_PAD_LCD_DAT11__GPIO2_IO31	0x79
> +			MX6SL_PAD_LCD_DAT12__GPIO3_IO00	0x79
> +			MX6SL_PAD_LCD_DAT13__GPIO3_IO01	0x79
> +			MX6SL_PAD_LCD_DAT14__GPIO3_IO02	0x79
> +			MX6SL_PAD_LCD_DAT15__GPIO3_IO03	0x79
> +			MX6SL_PAD_LCD_DAT16__GPIO3_IO04	0x79
> +			MX6SL_PAD_LCD_DAT17__GPIO3_IO05	0x79
> +			MX6SL_PAD_LCD_DAT18__GPIO3_IO06	0x79
> +			MX6SL_PAD_LCD_DAT19__GPIO3_IO07	0x79
> +			MX6SL_PAD_LCD_DAT20__GPIO3_IO08	0x79
> +			MX6SL_PAD_LCD_DAT21__GPIO3_IO09	0x79
> +			MX6SL_PAD_LCD_DAT22__GPIO3_IO10	0x79
> +			MX6SL_PAD_LCD_DAT23__GPIO3_IO11	0x79
> +			MX6SL_PAD_LCD_CLK__GPIO2_IO15		0x79
> +			MX6SL_PAD_LCD_ENABLE__GPIO2_IO16	0x79
> +			MX6SL_PAD_LCD_HSYNC__GPIO2_IO17	0x79
> +			MX6SL_PAD_LCD_VSYNC__GPIO2_IO18	0x79
> +			MX6SL_PAD_LCD_RESET__GPIO2_IO19	0x79
> +			MX6SL_PAD_KEY_COL3__GPIO3_IO30		0x79
> +			MX6SL_PAD_KEY_ROW7__GPIO4_IO07		0x79
> +			MX6SL_PAD_ECSPI2_MOSI__GPIO4_IO13	0x79
> +			MX6SL_PAD_KEY_COL5__GPIO4_IO02		0x79
> +			MX6SL_PAD_KEY_ROW6__GPIO4_IO05		0x79
> +		>;
> +	};
> +
> +	pinctrl_i2c1: i2c1grp {
> +		fsl,pins =3D <
> +			MX6SL_PAD_I2C1_SCL__I2C1_SCL	 0x4001f8b1
> +			MX6SL_PAD_I2C1_SDA__I2C1_SDA	 0x4001f8b1
> +		>;
> +	};
> +
> +	pinctrl_i2c1_sleep: i2c1grp-sleep {
> +		fsl,pins =3D <
> +			MX6SL_PAD_I2C1_SCL__I2C1_SCL	 0x400108b1
> +			MX6SL_PAD_I2C1_SDA__I2C1_SDA	 0x400108b1
> +		>;
> +	};
> +
> +	pinctrl_i2c2: i2c2grp {
> +		fsl,pins =3D <
> +			MX6SL_PAD_I2C2_SCL__I2C2_SCL	 0x4001f8b1
> +			MX6SL_PAD_I2C2_SDA__I2C2_SDA	 0x4001f8b1
> +		>;
> +	};
> +
> +	pinctrl_i2c2_sleep: i2c2grp-sleep {
> +		fsl,pins =3D <
> +			MX6SL_PAD_I2C2_SCL__I2C2_SCL	 0x400108b1
> +			MX6SL_PAD_I2C2_SDA__I2C2_SDA	 0x400108b1
> +		>;
> +	};
> +
> +	pinctrl_i2c3: i2c3grp {
> +		fsl,pins =3D <
> +			MX6SL_PAD_REF_CLK_24M__I2C3_SCL  0x4001f8b1
> +			MX6SL_PAD_REF_CLK_32K__I2C3_SDA  0x4001f8b1
> +		>;
> +	};
> +
> +	pinctrl_led: ledgrp {
> +		fsl,pins =3D <
> +			MX6SL_PAD_SD1_DAT6__GPIO5_IO07 0x17059
> +		>;
> +	};
> +
> +	pinctrl_lm3630a_bl_gpio: lm3630a-bl-gpiogrp {
> +		fsl,pins =3D <
> +			MX6SL_PAD_EPDC_PWRCTRL3__GPIO2_IO10		=
0x10059 /* HWEN */
> +		>;
> +	};
> +
> +	pinctrl_ricoh_gpio: ricoh_gpiogrp {
> +		fsl,pins =3D <
> +			MX6SL_PAD_SD1_CLK__GPIO5_IO15                  =
0x1b8b1 /* ricoh619 chg */
> +			MX6SL_PAD_SD1_DAT0__GPIO5_IO11        0x1b8b1 /* =
ricoh619 irq */
> +			MX6SL_PAD_KEY_COL2__GPIO3_IO28                   =
      0x1b8b1 /* ricoh619 bat_low_int */
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins =3D <
> +			MX6SL_PAD_UART1_TXD__UART1_TX_DATA 0x1b0b1
> +			MX6SL_PAD_UART1_RXD__UART1_TX_DATA 0x1b0b1
> +		>;
> +	};
> +
> +	pinctrl_usbotg1: usbotg1grp {
> +		fsl,pins =3D <
> +			MX6SL_PAD_EPDC_PWRCOM__USB_OTG1_ID 0x17059
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins =3D <
> +			MX6SL_PAD_SD2_CMD__SD2_CMD		0x17059
> +			MX6SL_PAD_SD2_CLK__SD2_CLK		0x13059
> +			MX6SL_PAD_SD2_DAT0__SD2_DATA0		0x17059
> +			MX6SL_PAD_SD2_DAT1__SD2_DATA1		0x17059
> +			MX6SL_PAD_SD2_DAT2__SD2_DATA2		0x17059
> +			MX6SL_PAD_SD2_DAT3__SD2_DATA3		0x17059
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_100mhz: usdhc2grp-100mhz {
> +		fsl,pins =3D <
> +			MX6SL_PAD_SD2_CMD__SD2_CMD		0x170b9
> +			MX6SL_PAD_SD2_CLK__SD2_CLK		0x130b9
> +			MX6SL_PAD_SD2_DAT0__SD2_DATA0		0x170b9
> +			MX6SL_PAD_SD2_DAT1__SD2_DATA1		0x170b9
> +			MX6SL_PAD_SD2_DAT2__SD2_DATA2		0x170b9
> +			MX6SL_PAD_SD2_DAT3__SD2_DATA3		0x170b9
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_200mhz: usdhc2grp-200mhz {
> +		fsl,pins =3D <
> +			MX6SL_PAD_SD2_CMD__SD2_CMD		0x170f9
> +			MX6SL_PAD_SD2_CLK__SD2_CLK		0x130f9
> +			MX6SL_PAD_SD2_DAT0__SD2_DATA0		0x170f9
> +			MX6SL_PAD_SD2_DAT1__SD2_DATA1		0x170f9
> +			MX6SL_PAD_SD2_DAT2__SD2_DATA2		0x170f9
> +			MX6SL_PAD_SD2_DAT3__SD2_DATA3		0x170f9
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_sleep: usdhc2grp-sleep {
> +		fsl,pins =3D <
> +			MX6SL_PAD_SD2_CMD__GPIO5_IO04		0x100f9
> +			MX6SL_PAD_SD2_CLK__GPIO5_IO05		0x100f9
> +			MX6SL_PAD_SD2_DAT0__GPIO5_IO01		0x100f9
> +			MX6SL_PAD_SD2_DAT1__GPIO4_IO30		0x100f9
> +			MX6SL_PAD_SD2_DAT2__GPIO5_IO03		0x100f9
> +			MX6SL_PAD_SD2_DAT3__GPIO4_IO28		0x100f9
> +		>;
> +	};
> +
> +	pinctrl_usdhc3: usdhc3grp {
> +		fsl,pins =3D <
> +			MX6SL_PAD_SD3_CMD__SD3_CMD	0x11059
> +			MX6SL_PAD_SD3_CLK__SD3_CLK	0x11059
> +			MX6SL_PAD_SD3_DAT0__SD3_DATA0	0x11059
> +			MX6SL_PAD_SD3_DAT1__SD3_DATA1	0x11059
> +			MX6SL_PAD_SD3_DAT2__SD3_DATA2	0x11059
> +			MX6SL_PAD_SD3_DAT3__SD3_DATA3	0x11059
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_100mhz: usdhc3grp-100mhz {
> +		fsl,pins =3D <
> +			MX6SL_PAD_SD3_CMD__SD3_CMD	0x170b9
> +			MX6SL_PAD_SD3_CLK__SD3_CLK	0x170b9
> +			MX6SL_PAD_SD3_DAT0__SD3_DATA0	0x170b9
> +			MX6SL_PAD_SD3_DAT1__SD3_DATA1	0x170b9
> +			MX6SL_PAD_SD3_DAT2__SD3_DATA2	0x170b9
> +			MX6SL_PAD_SD3_DAT3__SD3_DATA3	0x170b9
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_200mhz: usdhc3grp-200mhz {
> +		fsl,pins =3D <
> +			MX6SL_PAD_SD3_CMD__SD3_CMD	0x170f9
> +			MX6SL_PAD_SD3_CLK__SD3_CLK	0x170f9
> +			MX6SL_PAD_SD3_DAT0__SD3_DATA0	0x170f9
> +			MX6SL_PAD_SD3_DAT1__SD3_DATA1	0x170f9
> +			MX6SL_PAD_SD3_DAT2__SD3_DATA2	0x170f9
> +			MX6SL_PAD_SD3_DAT3__SD3_DATA3	0x170f9
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_sleep: usdhc3grp-sleep {
> +		fsl,pins =3D <
> +			MX6SL_PAD_SD3_CMD__GPIO5_IO21	0x100c1
> +			MX6SL_PAD_SD3_CLK__GPIO5_IO18	0x100c1
> +			MX6SL_PAD_SD3_DAT0__GPIO5_IO19	0x100c1
> +			MX6SL_PAD_SD3_DAT1__GPIO5_IO20	0x100c1
> +			MX6SL_PAD_SD3_DAT2__GPIO5_IO16	0x100c1
> +			MX6SL_PAD_SD3_DAT3__GPIO5_IO17	0x100c1
> +		>;
> +	};
> +
> +	pinctrl_wifi_power: wifi-powergrp {
> +		fsl,pins =3D <
> +			MX6SL_PAD_SD2_DAT6__GPIO4_IO29	0x10059	/* =
WIFI_3V3_ON */
> +		>;
> +	};
> +
> +	pinctrl_wifi_reset: wifi-resetgrp {
> +		fsl,pins =3D <
> +			MX6SL_PAD_SD2_DAT7__GPIO5_IO00	0x10059	/* =
WIFI_RST */
> +		>;
> +	};
> +};
> +
> +&leds {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_led>;
> +};
> +
> +&lm3630a {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_lm3630a_bl_gpio>;
> +};
> +
> +&reg_wifi {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_wifi_power>;
> +};
> +
> +&reg_vdd1p1 {
> +	vin-supply =3D <&dcdc2_reg>;
> +};
> +
> +&reg_vdd2p5 {
> +	vin-supply =3D <&dcdc2_reg>;
> +};
> +
> +&reg_vdd3p0 {
> +	vin-supply =3D <&dcdc2_reg>;
> +};
> +
> +&ricoh619 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_ricoh_gpio>;
> +};
> +
> +&uart1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_uart1>;
> +};
> +
> +&usdhc2 {
> +	pinctrl-names =3D "default", "state_100mhz", "state_200mhz", =
"sleep";
> +	pinctrl-0 =3D <&pinctrl_usdhc2>;
> +	pinctrl-1 =3D <&pinctrl_usdhc2_100mhz>;
> +	pinctrl-2 =3D <&pinctrl_usdhc2_200mhz>;
> +	pinctrl-3 =3D <&pinctrl_usdhc2_sleep>;
> +};
> +
> +&usdhc3 {
> +	pinctrl-names =3D "default", "state_100mhz", "state_200mhz", =
"sleep";
> +	pinctrl-0 =3D <&pinctrl_usdhc3>;
> +	pinctrl-1 =3D <&pinctrl_usdhc3_100mhz>;
> +	pinctrl-2 =3D <&pinctrl_usdhc3_200mhz>;
> +	pinctrl-3 =3D <&pinctrl_usdhc3_sleep>;
> +};
> +
> +&wifi_pwrseq {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_wifi_reset>;
> +};
> --=20
> 2.11.0

Tested-by: H. Nikolaus Schaller <hns@goldelico.com> # Tolino Shine3

