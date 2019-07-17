Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42165C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 09:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107B520880
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 09:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563354336;
	bh=hfhBRpDbi1WiaurfbGeV89jyXszNvMLKA0Pq41fCS8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G4kzZdKcAEPsIU5dVWdp28nWlRBnUgX0Yxd9hthUF9LZCBvtKQMnq0wMfCNyIJq3f
	 zJUPHJFWFQCoO9dHXzGMUasuqqXAj64u8Cg+7j7fJNw6FkoLaeDCiJM/vhoAt5HMIY
	 5pvIb3JOKO7VR7D/KcZc0D2EmtGM1ARrOqheP3hA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfGQJFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 05:05:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfGQJFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 05:05:34 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A49B2077C;
        Wed, 17 Jul 2019 09:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563354333;
        bh=hfhBRpDbi1WiaurfbGeV89jyXszNvMLKA0Pq41fCS8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mf7qYJgkfXF1IWlrD2oMPe5TOJwoWc4hbx/bLQMGjWMCe1gNwnuZOlVQoaOjA6lg7
         0vFN4AwVdxGW/u37ULwvtBvtle9yCJGFZrnfBnRbPeCNmAR+7P5FajFgKzESpeLpfu
         hZlXEoxpf3JZ3v5AJtbfbtvLpWpLrp3m/Qb+CjhU=
Date:   Wed, 17 Jul 2019 17:05:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oliver Graute <oliver.graute@gmail.com>
Cc:     narmstrong@baylibre.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] ARM: dts: Add support for i.MX6 UltraLite DART
 Variscite Customboard
Message-ID: <20190717090517.GF3738@dragon>
References: <1561398017-10548-1-git-send-email-oliver.graute@gmail.com>
 <1561398017-10548-3-git-send-email-oliver.graute@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561398017-10548-3-git-send-email-oliver.graute@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 07:40:13PM +0200, Oliver Graute wrote:
> This patch adds DeviceTree Source for the i.MX6 UltraLite DART NAND/WIFI
> 
> Signed-off-by: Oliver Graute <oliver.graute@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile                      |   1 +
>  arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts | 203 ++++++++++++++++++++++++
>  2 files changed, 204 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index c4742af..5dc3fbf 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -577,6 +577,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
>  	imx6ul-tx6ul-0010.dtb \
>  	imx6ul-tx6ul-0011.dtb \
>  	imx6ul-tx6ul-mainboard.dtb \
> +	imx6ul-var-6ulcustomboard.dtb \
>  	imx6ull-14x14-evk.dtb \
>  	imx6ull-colibri-eval-v3.dtb \
>  	imx6ull-colibri-wifi-eval-v3.dtb \
> diff --git a/arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts b/arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts
> new file mode 100644
> index 0000000..59354e6
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6ul-var-6ulcustomboard.dts
> @@ -0,0 +1,203 @@
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
> +	compatible = "fsl,6ulcustomboard", "fsl,imx6ul";

The board compatible is documented?

> +
> +	backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm1 0 20000>;
> +		brightness-levels = <0 4 8 16 32 64 128 255>;
> +		default-brightness-level = <6>;
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +
> +		user {
> +			gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_BACK>;
> +			gpio-key,wakeup;
> +		};
> +	};
> +
> +	gpio-leds {
> +		compatible = "gpio-leds";
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
> +		simple-audio-card,bitclock-master = <&sound_master>;
> +		simple-audio-card,frame-master = <&sound_master>;
> +
> +		sound_master: simple-audio-card,cpu {
> +				sound-dai = <&sai2>;
> +		};
> +	};
> +};
> +
> +&can1 {
> +	status = "okay";
> +};
> +
> +&can2 {
> +	status = "okay";
> +};
> +
> +&gpc {
> +	fsl,cpu_pupscr_sw2iso = <0x2>;
> +	fsl,cpu_pupscr_sw = <0x1>;
> +	fsl,cpu_pdnscr_iso2sw = <0x1>;
> +	fsl,cpu_pdnscr_iso = <0x1>;
> +	fsl,ldo-bypass = <0>; /* DCDC, ldo-enable */

These are not supported by mainline kernel, IIRC.

Shawn

> +};
> +
> +&fec1 {
> +	phy-mode = "rgmii";
> +	phy-reset-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
> +	phy-handle = <&ethphy0>;
> +	status = "okay";
> +};
> +
> +&fec2 {
> +	phy-mode = "rgmii";
> +	phy-reset-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
> +	phy-handle = <&ethphy1>;
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	clock-frequency = <400000>;
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
> +		#sound-dai-cells = <0>;
> +		compatible = "wlf,wm8731";
> +		reg = <0x1a>;
> +		clocks = <&clks IMX6UL_CLK_SAI2>;
> +		clock-names = "mclk";
> +	};
> +
> +	touchscreen@38 {
> +		compatible = "edt,edt-ft5x06";
> +		reg = <0x38>;
> +		interrupt-parent = <&gpio3>;
> +		interrupts = <4 0>;
> +		touchscreen-size-x = <800>;
> +		touchscreen-size-y = <480>;
> +		touchscreen-inverted-x;
> +		touchscreen-inverted-y;
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
> +	pinctrl-0 = <&pinctrl_lcdif_dat
> +		     &pinctrl_lcdif_ctrl>;
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
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	status = "okay";
> +};
> +
> +&uart3 {
> +	status = "okay";
> +};
> +
> +&usbotg1 {
> +	dr_mode = "host";
> +	status = "okay";
> +};
> +
> +&usbotg2 {
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
