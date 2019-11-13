Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF9DC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75001222C1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 07:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfKMHwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 02:52:24 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57551 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfKMHwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 02:52:24 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iUnRp-00009B-5o; Wed, 13 Nov 2019 08:52:17 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iUnRo-0008Kn-4v; Wed, 13 Nov 2019 08:52:16 +0100
Date:   Wed, 13 Nov 2019 08:52:16 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Oliver Graute <oliver.graute@gmail.com>
Cc:     shawnguo@kernel.org, narmstrong@baylibre.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv7 2/3] ARM: dts: Add support for i.MX6 UltraLite DART
 Variscite Customboard
Message-ID: <20191113075216.3yefi4btid4ww7tv@pengutronix.de>
References: <1573586526-15007-1-git-send-email-oliver.graute@gmail.com>
 <1573586526-15007-3-git-send-email-oliver.graute@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573586526-15007-3-git-send-email-oliver.graute@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:41:51 up 179 days, 14:00, 119 users,  load average: 0.16, 0.10,
 0.02
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Oliver,

I made my comments inline.

On 19-11-12 20:22, Oliver Graute wrote:
> This patch adds DeviceTree Source for the i.MX6 UltraLite DART NAND/WIFI
> 
> Signed-off-by: Oliver Graute <oliver.graute@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Marco Felsch <m.felsch@pengutronix.de>
> ---
> Changelog:
> 
> v7
>  - fixed wakeup-source
> 
> v6:
>  - added some muxing
>  - added codec in sound node
>  - added adc1 node
> 
>  arch/arm/boot/dts/Makefile                      |   1 +
>  arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts | 221 ++++++++++++++++++++++++
>  2 files changed, 222 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index df2e1f2..65fac53 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -583,6 +583,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
>  	imx6ul-tx6ul-0010.dtb \
>  	imx6ul-tx6ul-0011.dtb \
>  	imx6ul-tx6ul-mainboard.dtb \
> +	imx6ul-var-6ulcustomboard.dtb \
>  	imx6ull-14x14-evk.dtb \
>  	imx6ull-colibri-eval-v3.dtb \
>  	imx6ull-colibri-wifi-eval-v3.dtb \
> diff --git a/arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts b/arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts
> new file mode 100644
> index 00000000..5b88aad
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts
> @@ -0,0 +1,221 @@
> +// SPDX-License-Identifier: (GPL-2.0)
> +/*
> + * Support for Variscite DART-6UL Module
> + *
> + * Copyright (C) 2015 Freescale Semiconductor, Inc.
> + * Copyright (C) 2015-2016 Variscite Ltd. - http://www.variscite.com
> + * Copyright (C) 2018-2019 Oliver Graute <oliver.graute@gmail.com>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/input/input.h>
> +#include "imx6ul-imx6ull-var-dart-common.dtsi"
> +
> +/ {
> +	model = "Variscite i.MX6 UltraLite Carrier-board";
> +	compatible = "variscite,6ulcustomboard", "fsl,imx6ul";
> +
> +	backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm1 0 20000>;
> +		brightness-levels = <0 4 8 16 32 64 128 255>;
> +		default-brightness-level = <6>;
> +		status = "okay";

The status line can be dropped.

> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_keys>;

Where is the phandle?

> +
> +		user {
> +			gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_BACK>;
> +			wakeup-source;
> +		};
> +	};
> +
> +	gpio-leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_leds>;

Also this phandle.. I saw this a few times within this dts. Please make
sure that your dts(i) files are self-contained so move the muxing to
this dts. This happens a few time, I don't list all phandles.

> +
> +		d16-led {
> +			gpios = <&gpio4 20 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +
> +	sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "wm8731audio";
> +		simple-audio-card,widgets =
> +			"Headphone", "Headphone Jack",
> +			"Line", "Line Jack",
> +			"Microphone", "Mic Jack";
> +		simple-audio-card,routing =
> +			"Headphone Jack", "RHPOUT",
> +			"Headphone Jack", "LHPOUT",
> +			"LLINEIN", "Line Jack",
> +			"RLINEIN", "Line Jack",
> +			"MICIN", "Mic Bias",
> +			"Mic Bias", "Mic Jack";
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,bitclock-master = <&codec_dai>;
> +		simple-audio-card,frame-master = <&codec_dai>;
> +
> +		cpu_dai: simple-audio-card,cpu {

Do you need the cpu_dai phandle?

> +			sound-dai = <&sai2>;
> +		};
> +
> +		codec_dai: simple-audio-card,codec {
> +			sound-dai = <&wm8731>;
> +			system-clock-frequency = <12288000>;
> +		};
> +	};
> +};
> +
> +&adc1 {
> +	vref-supply = <&reg_touch_3v3>;

This is the only place where you use this regulator so can we move the
regulator to this dts instead of the common dtsi?

> +	status = "okay";
> +};
> +
> +&can1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flexcan1>;
> +	status = "okay";
> +};
> +
> +&can2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_flexcan2>;
> +	status = "okay";
> +};
> +
> +&fec1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_enet1>;
> +	status = "okay";
> +};
> +
> +&fec2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_enet2>;
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	clock-frequency = <400000>;

Can this go to the common dtsi file?

> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	clock_frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	status = "okay";
> +
> +	wm8731: audio-codec@1a {
> +		compatible = "wlf,wm8731";
> +		reg = <0x1a>;
> +		#sound-dai-cells = <0>;
> +		clocks = <&clks IMX6UL_CLK_SAI2>;
> +		clock-names = "mclk";
> +	};
> +
> +	touchscreen@38 {
> +		compatible = "edt,edt-ft5x06";
> +		reg = <0x38>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <4 IRQ_TYPE_NONE>;
> +		touchscreen-size-x = <800>;
> +		touchscreen-size-y = <480>;
> +		touchscreen-inverted-x;
> +		touchscreen-inverted-y;
> +		wakeup-source;
> +	};
> +
> +	rtc@68 {
> +		compatible = "dallas,ds1337";
> +		reg = <0x68>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_rtc>;
> +		interrupt-parent = <&gpio5>;
> +		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
> +	};
> +};
> +
> +&lcdif {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_lcdif>;
> +	display = <&display0>;
> +	status = "okay";
> +
> +	display0: display0 {
> +		bits-per-pixel = <16>;
> +		bus-width = <24>;
> +
> +		display-timings {
> +			native-mode = <&timing0>;
> +			timing0: timing0 {
> +				clock-frequency =<35000000>;
> +				hactive = <800>;
> +				vactive = <480>;
> +				hfront-porch = <40>;
> +				hback-porch = <40>;
> +				hsync-len = <48>;
> +				vback-porch = <29>;
> +				vfront-porch = <13>;
> +				vsync-len = <3>;
> +				hsync-active = <0>;
> +				vsync-active = <0>;
> +				de-active = <1>;
> +				pixelclk-active = <0>;
> +			};
> +		};
> +	};
> +};
> +
> +&pwm1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_pwm1>;

Where goes this phandle?

> +	status = "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	status = "okay";
> +};
> +
> +&uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart3>;
> +	uart-has-rtscts;
> +	status = "okay";
> +};
> +
> +&usbotg1 {
> +	disable-over-current;
> +	dr_mode = "host";
> +	status = "okay";
> +};
> +
> +&usbotg2 {
> +	disable-over-current;
> +	dr_mode = "host";
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_rtc: rtcgrp {
> +		fsl,pins = <
> +			MX6UL_PAD_SNVS_TAMPER7__GPIO5_IO07	0x1b0b0
> +		>;
> +	};
> +};
> -- 
> 2.7.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
