Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705D4C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 08:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F8D2077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 08:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575881869;
	bh=UdVrxFkQyZG28u0Hdc95DyuTak04p9szo9hdkx4JIik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cpsMjxCcNcvz7n3VftH4ie3WMzDbFXuOxKjJxKf4BcxqwIMbsu+q+Kf1H2q4KtP5u
	 aakfKkn2uTAeosTr0bFdy+N/I4fuE6ZxTdjZTNBZN4vbo7FGAoQv6IdD/iCCZ0U4Vb
	 O6bLBZGq5Cns6tOv3d4aQW7F28CpuDkeqiX/Wpq4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfLII5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 03:57:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:36210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbfLII5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 03:57:47 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 870CE20692;
        Mon,  9 Dec 2019 08:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575881866;
        bh=UdVrxFkQyZG28u0Hdc95DyuTak04p9szo9hdkx4JIik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jFM2fN4oniF0/NqyKFulpDsi2didOP/x9LEi5OxJ7IiFa0nWPcv4SbyBpaGu9IxgN
         uMatQwFuNmImKUD9u5HIbEG4o92v/7Uyblew9Ljx6Pc5QudrK70I17tfyuy57Hr4m9
         Fzfe+zeSX9SVuNUmevkIOrfuUnxK1A+aDtxl/iiY=
Date:   Mon, 9 Dec 2019 16:57:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marco Antonio Franchi <marco.franchi@nxp.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marcofrk@gmail.com" <marcofrk@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "atv@google.com" <atv@google.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: freescale: add initial support for
 Google i.MX 8MQ Phanbell
Message-ID: <20191209085729.GK3365@dragon>
References: <20191128194815.26642-1-marco.franchi@nxp.com>
 <20191128194815.26642-2-marco.franchi@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128194815.26642-2-marco.franchi@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 28, 2019 at 07:48:34PM +0000, Marco Antonio Franchi wrote:
> This patch adds the device tree to support Google Coral Edge TPU,
> historicaly named as fsl-imx8mq-phanbell, a computer on module
> which can be used for AI/ML propose.
> 
> It introduces a minimal enablement support for this module and
> was totally based on the NXP i.MX 8MQ EVK board and i.MX 8MQ Phanbell
> Google Source Code for Coral Edge TPU Mendel release:
> https://coral.googlesource.com/linux-imx/
> 
> Tested components:
> - PMIC;
> - USB-C OTG;
> - USB-C PWR;
> - micro-USB;
> - USB.
> 
> Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> ---
> Changes since v3:
> - remove reg_gpio_dvfs regulator
> - change cpu-supply to buck2
> - fix regulators values and properties
> - remove sai2 node
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../boot/dts/freescale/imx8mq-phanbell.dts    | 377 ++++++++++++++++++
>  2 files changed, 378 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 38e344a2f0ff..e50a934e2417 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -28,6 +28,7 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mq-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-hummingboard-pulse.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-devkit.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-nitrogen.dtb
> +dtb-$(CONFIG_ARCH_MXC) += imx8mq-phanbell.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-pico-pi.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-zii-ultra-rmb3.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-zii-ultra-zest.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts b/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts
> new file mode 100644
> index 000000000000..a7565a0146ee
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-phanbell.dts
> @@ -0,0 +1,377 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright 2017-2019 NXP
> + */
> +
> +/dts-v1/;
> +
> +#include "imx8mq.dtsi"
> +
> +/ {
> +	model = "Google i.MX8MQ Phanbell";
> +	compatible = "google,imx8mq-phanbell", "fsl,imx8mq";
> +
> +	chosen {
> +		stdout-path = &uart1;
> +	};
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0x00000000 0x40000000 0 0x40000000>;
> +	};
> +
> +	pmic_osc: clock-pmic {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <32768>;
> +		clock-output-names = "pmic_osc";
> +	};
> +
> +	reg_usdhc2_vmmc: usdhc2_vmmc {

Please name the fixed regulator node like regulator-xxx.

> +		compatible = "regulator-fixed";
> +		regulator-name = "VSD_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +};
> +
> +&A53_0 {
> +	cpu-supply = <&buck2>;
> +};
> +
> +&A53_1 {
> +	cpu-supply = <&buck2>;
> +};
> +
> +&A53_2 {
> +	cpu-supply = <&buck2>;
> +};
> +
> +&A53_3 {
> +	cpu-supply = <&buck2>;
> +};
> +
> +&i2c1 {
> +	clock-frequency = <400000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +
> +	pmic: pmic@4b {
> +		reg = <0x4b>;

Nit: we usually start properties with 'compatible'.

> +		compatible = "rohm,bd71837";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_pmic>;
> +		clocks = <&pmic_osc>;
> +		clock-names = "osc";

Is this clock-names needed?

> +		clock-output-names = "pmic_clk";

Binding doc says #clock-cells is a required property, but I cannot find
it anywhere.

> +		interrupt-parent = <&gpio1>;
> +		interrupts = <3 GPIO_ACTIVE_LOW>;
> +		interrupt-names = "irq";

Is this interrupt-names really needed?

> +
> +		regulators {
> +			buck1: BUCK1 {
> +				regulator-name = "buck1";
> +				regulator-min-microvolt = <700000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <1250>;
> +				rohm,dvs-run-voltage = <900000>;
> +				rohm,dvs-idle-voltage = <900000>;
> +				rohm,dvs-suspend-voltage = <800000>;
> +			};
> +
> +			buck2: BUCK2 {
> +				regulator-name = "buck2";
> +				regulator-min-microvolt = <850000>;
> +				regulator-max-microvolt = <1000000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				rohm,dvs-run-voltage = <1000000>;
> +				rohm,dvs-idle-voltage = <900000>;
> +			};
> +
> +			buck3: BUCK3 {
> +				regulator-name = "buck3";
> +				regulator-min-microvolt = <700000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-boot-on;
> +				rohm,dvs-run-voltage = <900000>;
> +			};
> +
> +			buck4: BUCK4 {
> +				regulator-name = "buck4";
> +				regulator-min-microvolt = <700000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				rohm,dvs-run-voltage = <900000>;
> +			};
> +
> +			buck5: BUCK5 {
> +				regulator-name = "buck5";
> +				regulator-min-microvolt = <700000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck6: BUCK6 {
> +				regulator-name = "buck6";
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck7: BUCK7 {
> +				regulator-name = "buck7";
> +				regulator-min-microvolt = <1605000>;
> +				regulator-max-microvolt = <1995000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck8: BUCK8 {
> +				regulator-name = "buck8";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1400000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo1: LDO1 {
> +				regulator-name = "ldo1";
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo2: LDO2 {
> +				regulator-name = "ldo2";
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo3: LDO3 {
> +				regulator-name = "ldo3";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo4: LDO4 {
> +				regulator-name = "ldo4";
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo5: LDO5 {
> +				regulator-name = "ldo5";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo6: LDO6 {
> +				regulator-name = "ldo6";
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo7: LDO7 {
> +				regulator-name = "ldo7";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	status = "okay";
> +};
> +
> +&usdhc1 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc1>;
> +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
> +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
> +	bus-width = <8>;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +&usdhc2 {
> +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
> +	bus-width = <4>;
> +	cd-gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;
> +	vmmc-supply = <&reg_usdhc2_vmmc>;
> +	status = "okay";
> +};
> +
> +&usb3_phy0 {
> +	status = "okay";
> +};
> +
> +&usb_dwc3_0 {
> +	status = "okay";
> +	dr_mode = "otg";

As a idiomatic practice, we end property list with 'status'.

> +};
> +
> +&usb3_phy1 {
> +	status = "okay";
> +};
> +
> +&usb_dwc3_1 {
> +	status = "okay";
> +	dr_mode = "host";

Ditto

Shawn

> +};
> +
> +&wdog1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_wdog>;
> +	fsl,ext-reset-output;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl_i2c1: i2c1grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_I2C1_SCL_I2C1_SCL			0x4000007f
> +			MX8MQ_IOMUXC_I2C1_SDA_I2C1_SDA			0x4000007f
> +		>;
> +	};
> +
> +	pinctrl_pmic: pmicirq {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_GPIO1_IO03_GPIO1_IO3	0x41
> +		>;
> +	};
> +
> +	pinctrl_uart1: uart1grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_UART1_RXD_UART1_DCE_RX		0x49
> +			MX8MQ_IOMUXC_UART1_TXD_UART1_DCE_TX		0x49
> +		>;
> +	};
> +
> +	pinctrl_usdhc1: usdhc1grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x83
> +			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc3
> +			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc3
> +			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc3
> +			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc3
> +			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc3
> +			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc3
> +			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc3
> +			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc3
> +			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc3
> +			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x83
> +			MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x85
> +			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc5
> +			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc5
> +			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc5
> +			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc5
> +			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc5
> +			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc5
> +			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc5
> +			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc5
> +			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc5
> +			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x85
> +			MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
> +		>;
> +	};
> +
> +	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x87
> +			MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc7
> +			MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc7
> +			MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc7
> +			MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc7
> +			MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc7
> +			MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc7
> +			MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc7
> +			MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc7
> +			MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc7
> +			MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x87
> +			MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_gpio: usdhc2grpgpio {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_SD2_CD_B_GPIO2_IO12	0x41
> +			MX8MQ_IOMUXC_SD2_RESET_B_GPIO2_IO19	0x41
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x83
> +			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc3
> +			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc3
> +			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc3
> +			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc3
> +			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc3
> +			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x85
> +			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc5
> +			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc5
> +			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc5
> +			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc5
> +			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc5
> +			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x87
> +			MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc7
> +			MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc7
> +			MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc7
> +			MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc7
> +			MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc7
> +			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
> +		>;
> +	};
> +
> +	pinctrl_wdog: wdoggrp {
> +		fsl,pins = <
> +			MX8MQ_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B 0xc6
> +		>;
> +	};
> +};
> -- 
> 2.17.1
> 
