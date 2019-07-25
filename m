Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EF6C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 20:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5B220578
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 20:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfGYUzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 16:55:08 -0400
Received: from gloria.sntech.de ([185.11.138.130]:39680 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbfGYUzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 16:55:08 -0400
Received: from d57e23da.static.ziggozakelijk.nl ([213.126.35.218] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hqklT-00021r-MY; Thu, 25 Jul 2019 22:55:03 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] ARM: dts: rockchip: add veyron-fievel board
Date:   Thu, 25 Jul 2019 22:55:02 +0200
Message-ID: <7491854.XWRlesuLgG@phil>
In-Reply-To: <20190725162642.250709-5-mka@chromium.org>
References: <20190725162642.250709-1-mka@chromium.org> <20190725162642.250709-5-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 25. Juli 2019, 18:26:41 CEST schrieb Matthias Kaehlcke:
> Also known as AOpen Chromebox Mini.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v3:
> - patch added to the series
> ---
>  arch/arm/boot/dts/Makefile                 |   1 +
>  arch/arm/boot/dts/rk3288-veyron-fievel.dts | 299 +++++++++++++++++++++
>  2 files changed, 300 insertions(+)
>  create mode 100644 arch/arm/boot/dts/rk3288-veyron-fievel.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 9159fa2cea90..9fd1e075c624 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -919,6 +919,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += \
>  	rk3288-tinker.dtb \
>  	rk3288-tinker-s.dtb \
>  	rk3288-veyron-brain.dtb \
> +	rk3288-veyron-fievel.dtb \
>  	rk3288-veyron-jaq.dtb \
>  	rk3288-veyron-jerry.dtb \
>  	rk3288-veyron-mickey.dtb \
> diff --git a/arch/arm/boot/dts/rk3288-veyron-fievel.dts b/arch/arm/boot/dts/rk3288-veyron-fievel.dts
> new file mode 100644
> index 000000000000..a9716fc3f50a
> --- /dev/null
> +++ b/arch/arm/boot/dts/rk3288-veyron-fievel.dts
> @@ -0,0 +1,299 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Veyron Fievel Rev 0+ board device tree source
> + *
> + * Copyright 2016 Google, Inc
> + */
> +
> +/dts-v1/;
> +#include "rk3288-veyron.dtsi"
> +#include "rk3288-veyron-analog-audio.dtsi"
> +
> +/ {
> +	model = "Google Fievel";
> +	compatible = "google,veyron-fievel-rev8", "google,veyron-fievel-rev7",
> +		     "google,veyron-fievel-rev6", "google,veyron-fievel-rev5",
> +		     "google,veyron-fievel-rev4", "google,veyron-fievel-rev3",
> +		     "google,veyron-fievel-rev2", "google,veyron-fievel-rev1",
> +		     "google,veyron-fievel-rev0", "google,veyron-fievel",
> +		     "google,veyron", "rockchip,rk3288";
> +
> +	/delete-node/ bt-activity;
> +
> +	ext_gmac: external-gmac-clock {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <125000000>;
> +		clock-output-names = "ext_gmac";
> +	};
> +
> +	/*
> +	 * vcc33_pmuio and vcc33_io is sourced directly from vcc33_sys,
> +	 * enabled by vcc_18
> +	 */
> +	vcc33_io: vcc33-io {
> +		compatible = "regulator-fixed";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-name = "vcc33_io";
> +	};
> +
> +	vcc5_host1: vcc5-host1-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio5 RK_PC1 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hub_usb1_pwr_en>;
> +		regulator-name = "vcc5_host1";
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vcc5_host2: vcc5-host2-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio5 RK_PC2 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hub_usb2_pwr_en>;
> +		regulator-name = "vcc5_host2";
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vcc5v_otg: vcc5v-otg-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb_otg_pwr_en>;
> +		regulator-name = "vcc5_otg";
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +};
> +
> +&gmac {
> +	status = "okay";
> +
> +	assigned-clocks = <&cru SCLK_MAC>;
> +	assigned-clock-parents = <&ext_gmac>;
> +	clock_in_out = "input";
> +	phy-handle = <&ethphy>;
> +	phy-mode = "rgmii";
> +	phy-supply = <&vcc33_lan>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&rgmii_pins>, <&phy_rst>, <&phy_pmeb>, <&phy_int>;
> +	resets = <&cru SRST_MAC>;
> +	reset-names = "stmmaceth";
> +	rx_delay = <0x10>;
> +	tx_delay = <0x30>;
> +
> +	/* Reset for the RTL8211 PHY which requires a 10-ms reset pulse (low)
> +	 * with a 30ms settling time. */
> +	snps,reset-gpio = <&gpio4 RK_PB0 0>;
> +	snps,reset-active-low;
> +	snps,reset-delays-us = <0 10000 30000>;
> +	wakeup-source;
> +
> +	mdio0 {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy: ethernet-phy@1 {
> +			reg = <1>;
> +		};
> +	};
> +};
> +
> +&rk808 {
> +	dvs-gpios = <&gpio7 RK_PB4 GPIO_ACTIVE_HIGH>,
> +		    <&gpio7 RK_PB7 GPIO_ACTIVE_HIGH>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pmic_int_l &dvs_1 &dvs_2>;
> +
> +	vcc6-supply = <&vcc33_sys>;
> +	vcc10-supply = <&vcc33_sys>;
> +	vcc11-supply = <&vcc_5v>;
> +	vcc12-supply = <&vcc33_sys>;
> +
> +	regulators {
> +		/delete-node/ LDO_REG1;
> +
> +		/* According to the schematic, vcc18_lcdt is for
> +		 * HDMI_AVDD_1V8
> +		 */
> +		vcc18_lcdt: LDO_REG2 {
> +			regulator-always-on;
> +			regulator-boot-on;
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-name = "vdd18_lcdt";
> +			regulator-state-mem {
> +				regulator-on-in-suspend;
> +				regulator-suspend-microvolt = <1800000>;
> +			};
> +		};
> +
> +		/* This is not a pwren anymore, but the real power supply,
> +		 * vdd10_lcd for HDMI_AVDD_1V0
> +		 */
> +		vdd10_lcd: LDO_REG7 {
> +			regulator-always-on;
> +			regulator-boot-on;
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1000000>;
> +			regulator-name = "vdd10_lcd";
> +			regulator-state-mem {
> +				regulator-on-in-suspend;
> +				regulator-suspend-microvolt = <1000000>;
> +			};
> +

I've dropped this unnecessary newline

> +		};

and applied the result for 5.4

Thanks
Heiko


