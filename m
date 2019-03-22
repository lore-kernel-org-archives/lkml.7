Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF38CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D4320700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553218346;
	bh=OVzh/0wg9uiQK9IOT3dYhmzsMv8mvSaRvQykIFKAvOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Jypx7NX/IbZ/AWuqiIXhkkP+Tr29PcPIhQJ51HDMyR1tQ4J+L4AJQH8jgjeHJUTPT
	 t+7VSuxZFELKKxjHDK5xn1mOgroWzF0gLIlWBK0LEN69wzyV7nJjQSaaL55l89l30X
	 feLzclutaxikSy3L8fqqfPDHue+e6bQp+N6asyH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfCVBcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 21:32:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727397AbfCVBcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 21:32:24 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DB8F20700;
        Fri, 22 Mar 2019 01:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553218342;
        bh=OVzh/0wg9uiQK9IOT3dYhmzsMv8mvSaRvQykIFKAvOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GvX9gfUVIGB0S4RsdR15TI4rn6XgLZPIWHWJpKlD/PjrDHP7nglL7yO97YYVWY7+g
         3guSwX6WT9wImkPuCG2DY/4yegDZ5q/ZA1P2flsV2BN1SK0nmYuMxpmphko2cjeMwc
         007wx4LmkZLZGSnmFeXc6jiExCcdf+0NF8SmDL1o=
Date:   Fri, 22 Mar 2019 09:31:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <treding@nvidia.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] ARM: dts: imx50: Add Kobo Aura DTS
Message-ID: <20190322013151.GR12513@dragon>
References: <20190319152421.16179-1-j.neuschaefer@gmx.net>
 <20190319152421.16179-3-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190319152421.16179-3-j.neuschaefer@gmx.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 04:24:17PM +0100, Jonathan Neuschäfer wrote:
> The Kobo Aura is an e-book reader released in 2013.
> 
> With the devicetree in its current state, the kernel will boot and run
> for about ten seconds. To solve this, the embedded controller needs to
> be told that the system should stay powered on. This will be done in a
> later patchset.
> 
> - The IOMUXC mode bits for the SD interfaces were taken from the
>   vendor's U-Boot fork.
> - The bus width of the eMMC is 4 bits in the vendor kernel, but I
>   achieved better performance with 8 bits.
> - The SDIO clock frequency for the WiFi chip is 25MHz in the vendor
>   kernel, but the WiFi chip (BCM43362) supports 50MHz, which works
>   reliably on this board and gives slightly better performance.
> - The I2C pins' IOMUXC settings come from the vendor's U-Boot fork.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  arch/arm/boot/dts/Makefile            |   3 +-
>  arch/arm/boot/dts/imx50-kobo-aura.dts | 245 ++++++++++++++++++++++++++
>  2 files changed, 247 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/imx50-kobo-aura.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index f4f5aeaf3298..0c85156c552b 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -363,7 +363,8 @@ dtb-$(CONFIG_SOC_IMX35) += \
>  	imx35-eukrea-mbimxsd35-baseboard.dtb \
>  	imx35-pdk.dtb
>  dtb-$(CONFIG_SOC_IMX50) += \
> -	imx50-evk.dtb
> +	imx50-evk.dtb \
> +	imx50-kobo-aura.dtb
>  dtb-$(CONFIG_SOC_IMX51) += \
>  	imx51-apf51.dtb \
>  	imx51-apf51dev.dtb \
> diff --git a/arch/arm/boot/dts/imx50-kobo-aura.dts b/arch/arm/boot/dts/imx50-kobo-aura.dts
> new file mode 100644
> index 000000000000..e778a677c752
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx50-kobo-aura.dts
> @@ -0,0 +1,245 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +// Copyright 2019 Jonathan Neuschäfer
> +//
> +// The Kobo Aura e-book reader, model N514. The mainboard is marked as E606F0B.
> +
> +/dts-v1/;
> +#include "imx50.dtsi"
> +#include <dt-bindings/input/input.h>
> +
> +/ {
> +	model = "Kobo Aura (N514)";
> +	compatible = "kobo,aura", "fsl,imx50";

Board compatible should also be documented.

> +
> +	chosen {
> +		stdout-path = "serial1:115200n8";
> +	};
> +
> +	memory@70000000 {
> +		device_type = "memory";
> +		reg = <0x70000000 0x10000000>;
> +	};
> +
> +	gpio-leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_leds>;
> +
> +		on {
> +			label = "kobo_aura:orange:on";
> +			gpios = <&gpio6 24 GPIO_ACTIVE_LOW>;
> +			panic-indicator;
> +		};
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpiokeys>;
> +
> +		power {
> +			label = "Power Button";
> +			gpios = <&gpio4 10 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_POWER>;
> +		};
> +
> +		hallsensor {
> +			label = "Hallsensor";
> +			gpios = <&gpio5 15 GPIO_ACTIVE_LOW>;
> +			linux,code = <0>;

Use define KEY_RESERVED?

> +			linux,input-type = <5>;

Use define EV_SW?

> +		};
> +
> +		frontlight {
> +			label = "Frontlight";
> +			gpios = <&gpio4 1 GPIO_ACTIVE_LOW>;
> +			linux,code = <KEY_DISPLAYTOGGLE>;
> +		};
> +	};
> +
> +	sd2_pwrseq: pwrseq {
> +		compatible = "mmc-pwrseq-simple";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_sd2_reset>;
> +

Please do not have random newlines.

> +		reset-gpios = <&gpio4 17 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	sd2_vmmc: gpio-regulator {
> +		compatible = "regulator-gpio";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_sd2_vmmc>;
> +
> +		regulator-name = "vmmc";
> +		states = <3300000 0>;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		enable-gpio = <&gpio4 12 GPIO_ACTIVE_LOW>;
> +		startup-delay-us = <100000>;
> +	};
> +};
> +
> +&iomuxc {
> +	pinctrl_uart2: uart2 {
> +		fsl,pins = <
> +			MX50_PAD_UART2_TXD__UART2_TXD_MUX	0x1e4
> +			MX50_PAD_UART2_RXD__UART2_RXD_MUX	0x1e4
> +		>;
> +	};
> +
> +	pinctrl_i2c1: i2c1 {

Please sort these pinctrl nodes alphabetically.

> +		fsl,pins = <
> +			MX50_PAD_I2C1_SCL__I2C1_SCL		0x400001fd
> +			MX50_PAD_I2C1_SDA__I2C1_SDA		0x400001fd
> +		>;
> +	};
> +
> +	pinctrl_i2c2: i2c2 {
> +		fsl,pins = <
> +			MX50_PAD_I2C2_SCL__I2C2_SCL		0x400001fd
> +			MX50_PAD_I2C2_SDA__I2C2_SDA		0x400001fd
> +		>;
> +	};
> +
> +	pinctrl_i2c3: i2c3 {
> +		fsl,pins = <
> +			MX50_PAD_I2C3_SCL__I2C3_SCL		0x400001fd
> +			MX50_PAD_I2C3_SDA__I2C3_SDA		0x400001fd
> +		>;
> +	};
> +
> +	pinctrl_leds: leds {
> +		fsl,pins = <
> +			MX50_PAD_PWM1__GPIO6_24			0x0
> +		>;
> +	};
> +
> +	pinctrl_gpiokeys: gpiokeys {
> +		fsl,pins = <
> +			MX50_PAD_CSPI_MISO__GPIO4_10		0x0
> +			MX50_PAD_SD2_D7__GPIO5_15		0x0
> +			MX50_PAD_KEY_ROW0__GPIO4_1		0x0
> +		>;
> +	};
> +
> +	pinctrl_sd1: sd1 {
> +		fsl,pins = <
> +			MX50_PAD_SD1_CMD__ESDHC1_CMD		0x1e4
> +			MX50_PAD_SD1_CLK__ESDHC1_CLK		0xd4
> +			MX50_PAD_SD1_D0__ESDHC1_DAT0		0x1d4
> +			MX50_PAD_SD1_D1__ESDHC1_DAT1		0x1d4
> +			MX50_PAD_SD1_D2__ESDHC1_DAT2		0x1d4
> +			MX50_PAD_SD1_D3__ESDHC1_DAT3		0x1d4
> +
> +			MX50_PAD_SD2_CD__GPIO5_17		0x0
> +		>;
> +	};
> +
> +	pinctrl_sd2: sd2 {
> +		fsl,pins = <
> +			MX50_PAD_SD2_CMD__ESDHC2_CMD		0x1e4
> +			MX50_PAD_SD2_CLK__ESDHC2_CLK		0xd4
> +			MX50_PAD_SD2_D0__ESDHC2_DAT0		0x1d4
> +			MX50_PAD_SD2_D1__ESDHC2_DAT1		0x1d4
> +			MX50_PAD_SD2_D2__ESDHC2_DAT2		0x1d4
> +			MX50_PAD_SD2_D3__ESDHC2_DAT3		0x1d4
> +		>;
> +	};
> +
> +	pinctrl_sd2_reset: sd2-reset {
> +		fsl,pins = <
> +			MX50_PAD_ECSPI2_MOSI__GPIO4_17		0x0
> +		>;
> +	};
> +
> +	pinctrl_sd2_vmmc: sd2-vmmc {
> +		fsl,pins = <
> +			MX50_PAD_ECSPI1_SCLK__GPIO4_12		0x0
> +		>;
> +	};
> +
> +	pinctrl_sd3: sd3 {
> +		fsl,pins = <
> +			MX50_PAD_SD3_CMD__ESDHC3_CMD		0x1e4
> +			MX50_PAD_SD3_CLK__ESDHC3_CLK		0xd4
> +			MX50_PAD_SD3_D0__ESDHC3_DAT0		0x1d4
> +			MX50_PAD_SD3_D1__ESDHC3_DAT1		0x1d4
> +			MX50_PAD_SD3_D2__ESDHC3_DAT2		0x1d4
> +			MX50_PAD_SD3_D3__ESDHC3_DAT3		0x1d4
> +			MX50_PAD_SD3_D4__ESDHC3_DAT4		0x1d4
> +			MX50_PAD_SD3_D5__ESDHC3_DAT5		0x1d4
> +			MX50_PAD_SD3_D6__ESDHC3_DAT6		0x1d4
> +			MX50_PAD_SD3_D7__ESDHC3_DAT7		0x1d4
> +		>;
> +	};
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	status = "okay";
> +};
> +
> +&i2c1 {

Please sort these labeled nodes alphabetically.

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +
> +	/* TODO: ektf2132 touch controller at 0x15 */
> +};
> +
> +&i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	status = "okay";
> +
> +	/* TODO: TPS65185 PMIC for E Ink at 0x68 */
> +};
> +
> +&i2c3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	status = "okay";
> +
> +	/* TODO: embedded controller at 0x43 */
> +};
> +
> +&esdhc1 {
> +	status = "okay";

We usually end property list with 'status'.

Shawn

> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sd1>;
> +
> +	max-frequency = <50000000>;
> +	bus-width = <4>;
> +	cd-gpios = <&gpio5 17 GPIO_ACTIVE_LOW>;
> +	disable-wp;
> +
> +	/* External µSD card */
> +};
> +
> +&esdhc2 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sd2>;
> +
> +	bus-width = <4>;
> +	max-frequency = <50000000>;
> +	disable-wp;
> +	mmc-pwrseq = <&sd2_pwrseq>;
> +	vmmc-supply = <&sd2_vmmc>;
> +
> +	/* CyberTan WC121 SDIO WiFi (BCM43362) */
> +};
> +
> +&esdhc3 {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_sd3>;
> +
> +	bus-width = <8>;
> +	non-removable;
> +	max-frequency = <50000000>;
> +	disable-wp;
> +
> +	/* Internal eMMC */
> +};
> --
> 2.20.1
> 
