Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998BBC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 06:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B106214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 06:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbfJKG4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 02:56:24 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51701 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbfJKG4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 02:56:23 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iIoqS-0005wk-Fx; Fri, 11 Oct 2019 08:56:12 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iIoqP-0003n4-4k; Fri, 11 Oct 2019 08:56:09 +0200
Date:   Fri, 11 Oct 2019 08:56:09 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, manivannan.sadhasivam@linaro.org,
        andrew.smirnov@gmail.com, marex@denx.de, angus@akkea.ca,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, j.neuschaefer@gmx.net,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH v3 2/3] ARM: dts: add Netronix E60K02 board common file
Message-ID: <20191011065609.6irap7elicatmsgg@pengutronix.de>
References: <20191010192357.27884-1-andreas@kemnade.info>
 <20191010192357.27884-3-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010192357.27884-3-andreas@kemnade.info>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:54:01 up 146 days, 13:12, 99 users,  load average: 0.06, 0.04,
 0.03
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On 19-10-10 21:23, Andreas Kemnade wrote:
> The Netronix board E60K02 can be found some several Ebook-Readers,
> at least the Kobo Clara HD and the Tolino Shine 3. The board
> is equipped with different SoCs requiring different pinmuxes.
> 
> For now the following peripherals are included:
> - LED
> - Power Key
> - Cover (gpio via hall sensor)
> - RC5T619 PMIC (the kernel misses support for rtc and charger
>   subdevices).
> - Backlight via lm3630a
> - Wifi sdio chip detection (mmc-powerseq and stuff)
> 
> It is based on vendor kernel but heavily reworked due to many
> changed bindings.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Changes in v3:
> - better led name
> - correct memory size
> - comments about missing devices
> 
> Changes in v2:
> - reordered, was 1/3
> - moved pinmuxes to their actual users, not the parents
>   of them
> - removed some already-disabled stuff
> - minor cleanups

You won't change the muxing, so a this dtsi can be self contained?

Regards,
  Marco

> backligt dependencies:
> module autoloading:
> https://patchwork.kernel.org/patch/11139987/ 
> enable-gpios property (accepted and acked):
> https://patchwork.kernel.org/patch/11143795/
> 
>  arch/arm/boot/dts/e60k02.dtsi | 337 ++++++++++++++++++++++++++++++++++
>  1 file changed, 337 insertions(+)
>  create mode 100644 arch/arm/boot/dts/e60k02.dtsi
> 
> diff --git a/arch/arm/boot/dts/e60k02.dtsi b/arch/arm/boot/dts/e60k02.dtsi
> new file mode 100644
> index 0000000000000..84c0447b9a1bd
> --- /dev/null
> +++ b/arch/arm/boot/dts/e60k02.dtsi
> @@ -0,0 +1,337 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2019 Andreas Kemnade
> + * based on works
> + * Copyright 2016 Freescale Semiconductor, Inc.
> + * and
> + * Copyright (C) 2014 Ricoh Electronic Devices Co., Ltd
> + *
> + * Netronix E60K02 board common.
> + * This board is equipped with different SoCs and
> + * found in ebook-readers like the Kobo Clara HD (with i.MX6SLL) and
> + * the Tolino Shine 3 (with i.MX6SL)
> + */
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +
> +	chosen {
> +		stdout-path = &uart1;
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_keys>;
> +		power {
> +			label = "Power";
> +			gpios = <&gpio5 8 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_POWER>;
> +			gpio-key,wakeup;
> +		};
> +		cover {
> +			label = "Cover";
> +			gpios = <&gpio5 12 GPIO_ACTIVE_LOW>;
> +			linux,code = <SW_LID>;
> +			linux,input-type = <EV_SW>;
> +			gpio-key,wakeup;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_led>;
> +
> +		on {
> +			label = "e60k02:white:on";
> +			gpios = <&gpio5 7 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "timer";
> +		};
> +	};
> +
> +	memory {
> +		reg = <0x80000000 0x20000000>;
> +	};
> +
> +	reg_wifi: regulator-wifi {
> +		compatible = "regulator-fixed";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_wifi_power>;
> +		regulator-name = "SD3_SPWR";
> +		regulator-min-microvolt = <3000000>;
> +		regulator-max-microvolt = <3000000>;
> +
> +		gpio = <&gpio4 29 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +	};
> +
> +	wifi_pwrseq: wifi_pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_wifi_reset>;
> +		post-power-on-delay-ms = <20>;
> +		reset-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
> +	};
> +
> +};
> +
> +
> +&i2c1 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default","sleep";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	pinctrl-1 = <&pinctrl_i2c1_sleep>;
> +	status = "okay";
> +
> +	lm3630a: backlight@36 {
> +		reg = <0x36>;
> +
> +		compatible = "ti,lm3630a";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_lm3630a_bl_gpio>;
> +		enable-gpios = <&gpio2 10 GPIO_ACTIVE_HIGH>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		led@0 {
> +			reg = <0>;
> +			led-sources = <0>;
> +			label = "backlight_warm";
> +			default-brightness = <0>;
> +			max-brightness = <255>;
> +		};
> +
> +		led@1 {
> +			reg = <1>;
> +			led-sources = <1>;
> +			label = "backlight_cold";
> +			default-brightness = <0>;
> +			max-brightness = <255>;
> +		};
> +
> +	};
> +};
> +
> +&i2c2 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default","sleep";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	pinctrl-1 = <&pinctrl_i2c2_sleep>;
> +	status = "okay";
> +
> +	/* TODO: CYTTSP5 touch controller at 0x24 */
> +
> +	/* TODO: TPS65185 PMIC for E Ink at 0x68 */
> +
> +};
> +
> +&i2c3 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	status = "okay";
> +
> +	ricoh619: pmic@32 {
> +		compatible = "ricoh,rc5t619";
> +		reg = <0x32>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_ricoh_gpio>;
> +		system-power-controller;
> +
> +		regulators {
> +			dcdc1_reg: DCDC1 {
> +				regulator-name = "DCDC1";
> +				regulator-min-microvolt = <300000>;
> +				regulator-max-microvolt = <1875000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-max-microvolt = <900000>;
> +					regulator-suspend-min-microvolt = <900000>;
> +				};
> +			};
> +
> +			/* Core3_3V3 */
> +			dcdc2_reg: DCDC2 {
> +				regulator-name = "DCDC2";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-max-microvolt = <3300000>;
> +					regulator-suspend-min-microvolt = <3300000>;
> +				};
> +			};
> +
> +			dcdc3_reg: DCDC3 {
> +				regulator-name = "DCDC3";
> +				regulator-min-microvolt = <300000>;
> +				regulator-max-microvolt = <1875000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-max-microvolt = <1140000>;
> +					regulator-suspend-min-microvolt = <1140000>;
> +				};
> +			};
> +
> +			/* Core4_1V2 */
> +			dcdc4_reg: DCDC4 {
> +				regulator-name = "DCDC4";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1200000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-max-microvolt = <1140000>;
> +					regulator-suspend-min-microvolt = <1140000>;
> +				};
> +			};
> +
> +			/* Core4_1V8 */
> +			dcdc5_reg: DCDC5 {
> +				regulator-name = "DCDC5";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-max-microvolt = <1700000>;
> +					regulator-suspend-min-microvolt = <1700000>;
> +				};
> +			};
> +
> +			/* IR_3V3 */
> +			ldo1_reg: LDO1  {
> +				regulator-name = "LDO1";
> +				regulator-boot-on;
> +			};
> +
> +			/* Core1_3V3 */
> +			ldo2_reg: LDO2  {
> +				regulator-name = "LDO2";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +					regulator-suspend-max-microvolt = <3000000>;
> +					regulator-suspend-min-microvolt = <3000000>;
> +				};
> +			};
> +
> +			/* Core5_1V2 */
> +			ldo3_reg: LDO3  {
> +				regulator-name = "LDO3";
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldo4_reg: LDO4 {
> +				regulator-name = "LDO4";
> +				regulator-boot-on;
> +			};
> +
> +			/* SPD_3V3 */
> +			ldo5_reg: LDO5 {
> +				regulator-name = "LDO5";
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			/* DDR_0V6 */
> +			ldo6_reg: LDO6 {
> +				regulator-name = "LDO6";
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			/* VDD_PWM */
> +			ldo7_reg: LDO7 {
> +				regulator-name = "LDO7";
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			/* ldo_1v8 */
> +			ldo8_reg: LDO8 {
> +				regulator-name = "LDO8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldo9_reg: LDO9 {
> +				regulator-name = "LDO9";
> +				regulator-boot-on;
> +			};
> +
> +			ldo10_reg: LDO10 {
> +				regulator-name = "LDO10";
> +				regulator-boot-on;
> +			};
> +
> +			ldortc1_reg: LDORTC1  {
> +				regulator-name = "LDORTC1";
> +				regulator-boot-on;
> +			};
> +
> +			ldortc2_reg: LDORTC2 {
> +				regulator-name = "LDORTC2";
> +				regulator-boot-on;
> +			};
> +		};
> +
> +	};
> +
> +};
> +
> +&snvs_rtc {
> +	/* we are using the rtc in the pmic, not disabled imx6sll.dtsi */
> +	status = "disabled";
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	status = "okay";
> +};
> +
> +&usdhc2 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz","sleep";
> +	pinctrl-0 = <&pinctrl_usdhc2>;
> +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
> +	pinctrl-3 = <&pinctrl_usdhc2_sleep>;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +&usdhc3 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz","sleep";
> +	pinctrl-0 = <&pinctrl_usdhc3>;
> +	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
> +	pinctrl-3 = <&pinctrl_usdhc3_sleep>;
> +	vmmc-supply = <&reg_wifi>;
> +	mmc-pwrseq = <&wifi_pwrseq>;
> +	cap-power-off-card;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +&usbotg1 {
> +	pinctrl-names = "default";
> +	disable-over-current;
> +	srp-disable;
> +	hnp-disable;
> +	adp-disable;
> +	status = "okay";
> +};
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
