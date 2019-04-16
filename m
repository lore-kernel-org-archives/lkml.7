Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B2EC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 22:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6211620868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 22:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="oJZmHwFR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbfDPWgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 18:36:48 -0400
Received: from node.akkea.ca ([192.155.83.177]:46928 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727057AbfDPWgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 18:36:47 -0400
Received: by node.akkea.ca (Postfix, from userid 33)
        id 7F8044E204B; Tue, 16 Apr 2019 22:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1555454205; bh=nnwsNf0UDLLYgWs5trJXOXQa4KpT7gGMt6bYRNMJN9w=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=oJZmHwFRF3rplzMVZKRnWpeFVrT9rKF7tYx1gBF6eIt1UMpCqDNugSEYPJb4NOzWz
         EvBdkkskGSWnBrdTL1VX8gQpTYyGzsNrIgLJKvldQDMHvGyqpxOjLA6iSLZfBEv5SF
         U+aLf16hVkpWGdFX7A9jFmYF9Xz0ADQob5bMtFc8=
To:     Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH v4 1/2] arm64: dts: fsl: librem5: Add a device tree for  the Librem5 devkit
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 16 Apr 2019 16:36:45 -0600
From:   Angus Ainslie <angus@akkea.ca>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
In-Reply-To: <20190416212021.3ee47m6bo2p3xkkl@pengutronix.de>
References: <20190415235343.16565-1-angus@akkea.ca>
 <20190415235343.16565-2-angus@akkea.ca>
 <20190416075435.uv3otbsxyy66gx67@pengutronix.de>
 <5c349f99d2bd543f5e56e0fffcb6682e@www.akkea.ca>
 <20190416212021.3ee47m6bo2p3xkkl@pengutronix.de>
Message-ID: <cfbfb4a7703b905ef10c47334b857e3f@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On 2019-04-16 15:20, Marco Felsch wrote:
> Hi Angus,
> 
> On 19-04-16 11:02, Angus Ainslie wrote:
>> Hi Marco,
>> 
>> On 2019-04-16 00:54, Marco Felsch wrote:
>> > Hi Agnus,
>> >
>> 
>> Just a nitpick but could you spell my name correctly :)
> 
> Sorry it was to early that morning and I haven't had my first coffee.
> 
>> > On 19-04-15 16:53, Angus Ainslie (Purism) wrote:
>> > > This is the development kit board for the Librem 5. The current
>> > > level of
>> > > support yields a working console and is able to boot userspace from
>> > > the
>> > > Network or eMMC.
>> > >
>> > > Additional subsystems that are active :
>> > >
>> > > - Both USB ports
>> > > - SD card socket
>> > > - WiFi usdhc
>> > > - WWAN modem
>> > > - GNSS
>> > > - GPIO keys
>> > > - LEDs
>> > > - gyro
>> > > - magnetometer
>> > > - touchscreen
>> > > - pwm
>> > > - backlight
>> > > - haptic motor
>> > >
>> > > Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
>> > > ---
>> > >  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>> > >  .../dts/freescale/imx8mq-librem5-devkit.dts   | 822
>> > > ++++++++++++++++++
>> > >  2 files changed, 823 insertions(+)
>> > >  create mode 100644
>> > > arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
>> > >
>> > > diff --git a/arch/arm64/boot/dts/freescale/Makefile
>> > > b/arch/arm64/boot/dts/freescale/Makefile
>> > > index 0bd122f60549..c043aca66572 100644
>> > > --- a/arch/arm64/boot/dts/freescale/Makefile
>> > > +++ b/arch/arm64/boot/dts/freescale/Makefile
>> > > @@ -22,6 +22,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
>> > >
>> > >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
>> > >  dtb-$(CONFIG_ARCH_MXC) += imx8mq-evk.dtb
>> > > +dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-devkit.dtb
>> > >  dtb-$(CONFIG_ARCH_MXC) += imx8mq-zii-ultra-rmb3.dtb
>> > >  dtb-$(CONFIG_ARCH_MXC) += imx8mq-zii-ultra-zest.dtb
>> > >  dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
>> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
>> > > b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
>> > > new file mode 100644
>> > > index 000000000000..dd705b6b94a4
>> > > --- /dev/null
>> > > +++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
>> > > @@ -0,0 +1,822 @@
>> > > +/* SPDX-License-Identifier: GPL-2.0+
>> > > + *
>> > > + * Copyright 2018-2019 Purism SPC
>> > > + */
>> > > +
>> > > +/dts-v1/;
>> > > +
>> > > +#include "imx8mq.dtsi"
>> > > +#include "dt-bindings/usb/pd.h"
>> > > +#include "dt-bindings/input/input.h"
>> >
>> > Just a nitpick but this should be alphabetical too.
>> >
>> 
>> Ok.
>> 
>> > > +
>> > > +/ {
>> > > +	model = "Purism Librem 5 devkit";
>> > > +	compatible = "purism,librem5-devkit", "fsl,imx8mq";
>> > > +
>> > > +	backlight_dsi: backlight-dsi {
>> > > +		compatible = "pwm-backlight";
>> > > +		/* 200 Hz for the PAM2841 */
>> > > +		pwms = <&pwm1 0 5000000>;
>> > > +		brightness-levels = <0 100>;
>> > > +		num-interpolated-steps = <100>;
>> > > +		/* Default brightness level (index into the array defined by */
>> > > +		/* the "brightness-levels" property) */
>> > > +		default-brightness-level = <0>;
>> > > +		power-supply = <&reg_22V4_P>;
>> > > +	};
>> > > +
>> > > +	chosen {
>> > > +		stdout-path = &uart1;
>> > > +	};
>> > > +
>> > > +	gpio-keys {
>> > > +		compatible = "gpio-keys";
>> > > +		pinctrl-names = "default";
>> > > +		pinctrl-0 = <&pinctrl_gpio_keys>;
>> > > +
>> > > +		btn1 {
>> > > +			label = "VOL_UP";
>> > > +			gpios = <&gpio4 21 GPIO_ACTIVE_LOW>;
>> > > +			gpio-key,wakeup;
>> > > +			linux,code = <KEY_VOLUMEUP>;
>> > > +		};
>> > > +
>> > > +		btn2 {
>> > > +			label = "VOL_DOWN";
>> > > +			gpios = <&gpio4 22 GPIO_ACTIVE_LOW>;
>> > > +			gpio-key,wakeup;
>> > > +			linux,code = <KEY_VOLUMEDOWN>;
>> > > +		};
>> > > +
>> > > +		hp_det {
>> > > +			label = "HP_DET";
>> > > +			gpios = <&gpio3 20 GPIO_ACTIVE_LOW>;
>> > > +			gpio-key,wakeup;
>> > > +			linux,code = <KEY_HP>;
>> > > +		};
>> > > +	};
>> > > +
>> > > +	leds {
>> > > +		compatible = "gpio-leds";
>> > > +		pinctrl-names = "default";
>> > > +		pinctrl-0 = <&pinctrl_gpio_leds>;
>> > > +		status = "okay";
>> >
>> > You can drop the status since the default is "okay".
>> >
>> 
>> Ok.
>> 
>> > > +
>> > > +		led1 {
>> > > +			label = "LED 1";
>> > > +			gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
>> > > +			default-state = "off";
>> > > +		};
>> > > +	};
>> > > +
>> > > +	pmic_osc: pmic-osc {
>> > > +		compatible = "fixed-clock";
>> > > +		#clock-cells = <0>;
>> > > +		clock-frequency = <32768>;
>> > > +		clock-output-names = "pmic_osc";
>> > > +	};
>> > > +
>> > > +	pwmleds {
>> > > +		compatible = "pwm-leds";
>> >
>> > Can you add a blank line? It's just a nitpick.
>> >
>> 
>> Sure.
>> 
>> > > +		haptic {
>> > > +			label = "librem5::haptic";
>> > > +			pwms = <&pwm2 0 200000>;
>> > > +			active-low;
>> > > +			max-brightness = <255>;
>> > > +			power-supply = <&reg_3V3_P>;
>> > > +		};
>> > > +	};
>> > > +
>> > > +	reg_1V8_P: regulator-1V8-P {
>> >
>> > I don't know the policy but I would name the nodes and phandles always
>> > in lower case.
>> >
>> 
>> Ok.
>> 
>> > > +		compatible = "regulator-fixed";
>> > > +		regulator-name = "1V8_P";
>> > > +		regulator-min-microvolt = <1800000>;
>> > > +		regulator-max-microvolt = <1800000>;
>> > > +		vin-supply = <&reg_vbat>;
>> > > +		en-supply = <&reg_pwr_en>;
>> >
>> > What is 'en-supply'? Just checked the v5.1-rc5 and didn't found that
>> > property at all. This applies to the other regulator nodes too.
>> >
>> 
>> I was attempting to show a dependency on both supplies but I'll change 
>> the
>> way it is structured.
>> 
>> > > +	};
>> > > +
>> > > +	reg_2V8_P: regulator-2V8-P {
>> > > +		compatible = "regulator-fixed";
>> > > +		regulator-name = "2V8_P";
>> > > +		regulator-min-microvolt = <2800000>;
>> > > +		regulator-max-microvolt = <2800000>;
>> > > +		vin-supply = <&reg_3V3_P>;
>> > > +	};
>> > > +
>> > > +	reg_3V3_P: regulator-3V3-P {
>> > > +		compatible = "regulator-fixed";
>> > > +		regulator-name = "3V3_P";
>> > > +		regulator-min-microvolt = <3300000>;
>> > > +		regulator-max-microvolt = <3300000>;
>> > > +		vin-supply = <&reg_vbat>;
>> > > +		en-supply = <&reg_pwr_en>;
>> > > +	};
>> > > +
>> > > +	reg_5V_P: regulator-5V-P {
>> > > +		/* Supplies HDMI, USB hub and smartcard */
>> > > +		compatible = "regulator-fixed";
>> > > +		regulator-name = "5V_P";
>> > > +		regulator-min-microvolt = <5000000>;
>> > > +		regulator-max-microvolt = <5000000>;
>> > > +		vin-supply = <&reg_vbat>;
>> > > +		en-supply = <&reg_pwr_en>;
>> > > +	};
>> > > +
>> > > +	reg_5V_SOM: regulator-5V-SOM {
>> > > +		compatible = "regulator-fixed";
>> > > +		regulator-name = "5V_SOM";
>> > > +		regulator-min-microvolt = <5000000>;
>> > > +		regulator-max-microvolt = <5000000>;
>> > > +		vin-supply = <&reg_vbat>;
>> > > +		regulator-always-on;
>> > > +	};
>> > > +
>> > > +	reg_22V4_P: regulator-22V4-P {
>> > > +		compatible = "regulator-fixed";
>> > > +		regulator-name = "22V4_P";
>> > > +		regulator-min-microvolt = <22400000>;
>> > > +		regulator-max-microvolt = <22400000>;
>> > > +		vin-supply = <&reg_vbat>;
>> > > +	};
>> > > +
>> > > +	reg_pwr_en: regulator-pwr-en {
>> > > +		compatible = "regulator-fixed";
>> > > +		regulator-name = "PWR_EN";
>> > > +		regulator-min-microvolt = <3300000>;
>> > > +		regulator-max-microvolt = <3300000>;
>> > > +		gpio = <&gpio1 8 GPIO_ACTIVE_HIGH>;
>> >
>> > You missed the pinctrl-0, pinctrl-names property since you already have
>> > a pinctrl_pwr_en phandle.
>> >
>> > > +		enable-active-high;
>> > > +		regulator-always-on;
>> > > +	};
>> > > +
>> > > +	reg_usdhc2_vmmc: regulator-usdhc2-vmmc {
>> > > +		compatible = "regulator-fixed";
>> > > +		regulator-name = "VSD_3V3";
>> > > +		regulator-min-microvolt = <3300000>;
>> > > +		regulator-max-microvolt = <3300000>;
>> > > +		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
>> >
>> > IMHO you should mux (pinctrl) a gpio where you use them but that's only
>> > my opinion.
>> >
>> > > +		enable-active-high;
>> > > +		regulator-always-on;
>> > > +	};
>> > > +
>> > > +	reg_vbat: regulator-vbat {
>> > > +		compatible = "regulator-fixed";
>> > > +		regulator-name = "VBAT_REG";
>> > > +		regulator-always-on;
>> > > +	};
>> >
>> > A fixed regulator without a regulator-min-microvolt
>> > regulator-max-microvolt?
>> >
>> 
>> That will get fixed with the issue above.
>> 
>> > > +
>> > > +	wifi_pwr_en: wifi-en {
>> > > +		compatible = "regulator-fixed";
>> > > +		regulator-name = "WIFI_EN";
>> > > +		regulator-min-microvolt = <3300000>;
>> > > +		regulator-max-microvolt = <3300000>;
>> > > +		gpio = <&gpio3 5 GPIO_ACTIVE_HIGH>;
>> >
>> > Where do you mux that gpio? It seems that you use the
>> > pinctrl_usdhc2_gpio for muxing but there is no GPIO3 mux.
>> >
>> 
>> I'll fix it with the regulators.
>> 
>> > > +		enable-active-high;
>> > > +		regulator-always-on;
>> > > +	};
>> > > +};
>> > > +
>> > > +
>> > > +&clk {
>> > > +	assigned-clocks = <&clk IMX8MQ_AUDIO_PLL1>, <&clk
>> > > IMX8MQ_AUDIO_PLL2>;
>> > > +	assigned-clock-rates = <786432000>, <722534400>;
>> > > +};
>> > > +
>> > > +&fec1 {
>> > > +	pinctrl-names = "default";
>> > > +	pinctrl-0 = <&pinctrl_fec1>;
>> > > +	phy-mode = "rgmii-id";
>> > > +	phy-handle = <&ethphy0>;
>> > > +	fsl,magic-packet;
>> > > +	status = "okay";
>> >
>> > status should be the last property in this list.
>> >
>> 
>> Ok.
>> 
>> > > +	phy-supply = <&reg_3V3_P>;
>> > > +
>> > > +	mdio {
>> > > +		#address-cells = <1>;
>> > > +		#size-cells = <0>;
>> > > +
>> > > +		ethphy0: ethernet-phy@1 {
>> >
>> > Is it necessary to name it ethphy0? Just a nitpick.
>> >
>> > > +			compatible = "ethernet-phy-ieee802.3-c22";
>> > > +			reg = <1>;
>> > > +		};
>> > > +	};
>> > > +};
>> > > +
>> > > +&i2c1 {
>> > > +	clock-frequency = <400000>;
>> > > +	pinctrl-names = "default";
>> > > +	pinctrl-0 = <&pinctrl_i2c1>;
>> > > +	status = "okay";
>> > > +
>> > > +	pmic: pmic@4b {
>> > > +		reg = <0x4b>;
>> > > +		compatible = "rohm,bd71837";
>> >
>> > Please swap the reg and compatible property.
>> >
>> > > +		pinctrl-names = "default";
>> > > +		pinctrl-0 = <&pinctrl_pmic>;
>> > > +		clocks = <&pmic_osc>;
>> > > +		clock-names = "osc";
>> > > +		clock-output-names = "pmic_clk";
>> > > +		interrupt-parent = <&gpio1>;
>> > > +		interrupts = <3 GPIO_ACTIVE_LOW>;
>> > > +		interrupt-names = "irq";
>> > > +		rohm,reset-snvs-powered;
>> > > +
>> > > +		regulators {
>> > > +			#address-cells = <1>;
>> > > +			#size-cells = <0>;
>> >
>> > Please drop the #address-cells, #size-cells and the @<reg> suffix
>> > including the reg = <> property. So it would look like:
>> >
>> > 			buck1_reg: BUCK1 {
>> > 				regulator-name = "buck1";
>> > 				regulator-min-microvolt = <700000>;
>> > 				regulator-max-microvolt = <1300000>;
>> > 				regulator-boot-on;
>> > 				regulator-always-on;
>> > 				regulator-ramp-delay = <1250>;
>> > 				rohm,dvs-run-voltage = <900000>;
>> > 				rohm,dvs-idle-voltage = <850000>;
>> > 				rohm,dvs-suspend-voltage = <800000>;
>> > 			};
>> >
>> > Please look at
>> > Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt.
>> >
>> 
>> Thanks hadn't noticed the documentation change.
>> 
>> > > +
>> > > +			buck1_reg: BUCK1@0 {
>> > > +				reg = <0>;
>> > > +				regulator-name = "buck1";
>> > > +				regulator-min-microvolt = <700000>;
>> > > +				regulator-max-microvolt = <1300000>;
>> > > +				regulator-boot-on;
>> > > +				regulator-always-on;
>> > > +				regulator-ramp-delay = <1250>;
>> > > +				rohm,dvs-run-voltage = <900000>;
>> > > +				rohm,dvs-idle-voltage = <850000>;
>> > > +				rohm,dvs-suspend-voltage = <800000>;
>> > > +			};
>> > > +
>> > > +			buck2_reg: BUCK2@1 {
>> > > +				reg = <1>;
>> > > +				regulator-name = "buck2";
>> > > +				regulator-min-microvolt = <700000>;
>> > > +				regulator-max-microvolt = <1300000>;
>> > > +				regulator-boot-on;
>> > > +				regulator-always-on;
>> > > +				regulator-ramp-delay = <1250>;
>> > > +				rohm,dvs-run-voltage = <1000000>;
>> > > +				rohm,dvs-idle-voltage = <900000>;
>> > > +			};
>> > > +
>> > > +			buck3_reg: BUCK3@2 {
>> > > +				reg = <2>;
>> > > +				regulator-name = "buck3";
>> > > +				regulator-min-microvolt = <700000>;
>> > > +				regulator-max-microvolt = <1300000>;
>> > > +				rohm,dvs-run-voltage = <1000000>;
>> > > +			};
>> > > +
>> > > +			buck4_reg: BUCK4@3 {
>> > > +				reg = <3>;
>> > > +				regulator-name = "buck4";
>> > > +				regulator-min-microvolt = <700000>;
>> > > +				regulator-max-microvolt = <1300000>;
>> > > +				rohm,dvs-run-voltage = <1000000>;
>> > > +			};
>> > > +
>> > > +			buck5_reg: BUCK5@4 {
>> > > +				reg = <4>;
>> > > +				regulator-name = "buck5";
>> > > +				regulator-min-microvolt = <700000>;
>> > > +				regulator-max-microvolt = <1350000>;
>> > > +				regulator-boot-on;
>> > > +				regulator-always-on;
>> > > +			};
>> > > +
>> > > +			buck6_reg: BUCK6@5 {
>> > > +				reg = <5>;
>> > > +				regulator-name = "buck6";
>> > > +				regulator-min-microvolt = <3000000>;
>> > > +				regulator-max-microvolt = <3300000>;
>> > > +				regulator-boot-on;
>> > > +				regulator-always-on;
>> > > +			};
>> > > +
>> > > +			buck7_reg: BUCK7@6 {
>> > > +				reg = <6>;
>> > > +				regulator-name = "buck7";
>> > > +				regulator-min-microvolt = <1605000>;
>> > > +				regulator-max-microvolt = <1995000>;
>> > > +				regulator-boot-on;
>> > > +				regulator-always-on;
>> > > +			};
>> > > +
>> > > +			buck8_reg: BUCK8@7 {
>> > > +				reg = <7>;
>> > > +				regulator-name = "buck8";
>> > > +				regulator-min-microvolt = <800000>;
>> > > +				regulator-max-microvolt = <1400000>;
>> > > +				regulator-boot-on;
>> > > +				regulator-always-on;
>> > > +			};
>> > > +
>> > > +			ldo1_reg: LDO1@8 {
>> > > +				reg = <8>;
>> > > +				regulator-name = "ldo1";
>> > > +				regulator-min-microvolt = <3000000>;
>> > > +				regulator-max-microvolt = <3300000>;
>> > > +				regulator-boot-on;
>> > > +				regulator-always-on;
>> > > +			};
>> > > +
>> > > +			ldo2_reg: LDO2@9 {
>> > > +				reg = <9>;
>> > > +				regulator-name = "ldo2";
>> > > +				regulator-min-microvolt = <900000>;
>> > > +				regulator-max-microvolt = <900000>;
>> > > +				regulator-boot-on;
>> > > +				regulator-always-on;
>> > > +			};
>> > > +
>> > > +			ldo3_reg: LDO3@10 {
>> > > +				reg = <10>;
>> > > +				regulator-name = "ldo3";
>> > > +				regulator-min-microvolt = <1800000>;
>> > > +				regulator-max-microvolt = <3300000>;
>> > > +				regulator-boot-on;
>> > > +				regulator-always-on;
>> > > +			};
>> > > +
>> > > +			ldo4_reg: LDO4@11 {
>> > > +				reg = <11>;
>> > > +				regulator-name = "ldo4";
>> > > +				regulator-min-microvolt = <900000>;
>> > > +				regulator-max-microvolt = <1800000>;
>> > > +				regulator-boot-on;
>> > > +				regulator-always-on;
>> > > +			};
>> > > +
>> > > +			ldo5_reg: LDO5@12 {
>> > > +				reg = <12>;
>> > > +				regulator-name = "ldo5";
>> > > +				regulator-min-microvolt = <1800000>;
>> > > +				regulator-max-microvolt = <3300000>;
>> > > +			};
>> > > +
>> > > +			ldo6_reg: LDO6@13 {
>> > > +				reg = <13>;
>> > > +				regulator-name = "ldo6";
>> > > +				regulator-min-microvolt = <900000>;
>> > > +				regulator-max-microvolt = <1800000>;
>> > > +			};
>> > > +
>> > > +			ldo7_reg: LDO7@14 {
>> > > +				reg = <14>;
>> > > +				regulator-name = "ldo7";
>> > > +				regulator-min-microvolt = <1800000>;
>> > > +				regulator-max-microvolt = <3300000>;
>> > > +			};
>> > > +		};
>> > > +	};
>> > > +
>> > > +	typec_ptn5100: usb_typec@52 {
>> > > +		compatible = "nxp,ptn5110";
>> > > +		pinctrl-names = "default";
>> > > +		pinctrl-0 = <&pinctrl_typec>;
>> > > +		reg = <0x52>;
>> >
>> > The reg = <> should be followed after the compatible.
>> >
>> > > +		interrupt-parent = <&gpio3>;
>> > > +		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
>> > > +		vconn-supply = <&reg_5V_P>;
>> >
>> > The vconn-supply isn't documented elsewhere.
>> >
>> 
>> Yeah that came from the schematic not the code or documentation.
> 
> I wouldn't add properties which aren't supported.
> 

Agreed

>> > > +		usb_con: connector {
>> >
>> > Is that phandle nedded?
>> >
>> > > +			compatible = "usb-c-connector";
>> > > +			label = "USB-C";
>> > > +			data-role = "dual";
>> > > +			power-role = "dual";
>> > > +			try-power-role = "sink";
>> > > +			source-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM |
>> > > PDO_FIXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP )>;
>> > > +			sink-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM |
>> > > PDO_FIXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP )
>> > > +			     PDO_VAR(5000, 12000, 2000)>;
>> >
>> > Just a nitpick but I would break the lines, e.g.
>> >
>> > 			source-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM |
>> > 							     PDO_FIXED_DUAL_ROLE |
>> > 							     PDO_FIXED_DATA_SWAP )>;
>> > 			sink-pdos = <PDO_FIXED(5000, 2000, PDO_FIXED_USB_COMM |
>> > 							   PDO_FIXED_DUAL_ROLE |
>> > 							   PDO_FIXED_DATA_SWAP )
>> > 			     	     PDO_VAR(5000, 12000, 2000)>;
>> >
>> >
>> 
>> Ok they are longer than 80 cols anyway
> 
> That's true it was just a idea. You can break the lines where you want 
> :)
> 
>> 
>> > > +			op-sink-microwatt = <10000000>;
>> > > +			ports {
>> > > +				#address-cells = <1>;
>> > > +				#size-cells = <0>;
>> >
>> > Blank line please.
>> >
>> > > +				port@0 {
>> > > +					reg = <0>;
>> > > +					usb_con_hs: endpoint {
>> > > +						remote-endpoint = <&typec_hs>;
>> > > +					};
>> > > +				};
>> >
>> > Here too.
>> >
>> > > +				port@1 {
>> > > +					reg = <1>;
>> > > +					usb_con_ss: endpoint {
>> > > +						remote-endpoint = <&typec_ss>;
>> > > +					};
>> > > +				};
>> > > +			};
>> > > +		};
>> > > +
>> > > +	};
>> > > +
>> > > +	rtc@68 {
>> > > +		pinctrl-names = "default";
>> > > +		compatible = "microcrystal,rv4162";
>> > > +		reg = <0x68>;
>> > > +		pinctrl-0 = <&pinctrl_rtc>;
>> > > +		interrupt-parent = <&gpio4>;
>> > > +		interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
>> > > +	};
>> > > +
>> > > +	charger: charger@6b { /* bq25896 */
>> >
>> > Is that phandle necessary?
>> >
>> > > +		compatible = "ti,bq25890";
>> > > +		reg = <0x6b>;
>> > > +		pinctrl-names = "default";
>> > > +		pinctrl-0 = <&pinctrl_charger>;
>> > > +		interrupt-parent = <&gpio3>;
>> > > +		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
>> > > +		ti,battery-regulation-voltage = <4192000>; /* 4.192V */
>> > > +		ti,charge-current = <1600000>; /* 1.6 A */
>> > > +		ti,termination-current = <66000>;  /* 66mA */
>> > > +		ti,precharge-current = <1300000>; /* 1.3A */
>> > > +		ti,minimum-sys-voltage = <2750000>; /* 2.75V */
>> > > +		ti,boost-voltage = <5000000>; /* 5V */
>> > > +		ti,boost-max-current = <50000>; /* 50mA */
>> >
>> > IMHO I would comment only the measurments.
>> >
>> 
>> Sorry do you mean the units ?
> 
> Yes and sorry my english wasn't the best this morning.
> 

Sure no problem, I just wanted to be sure I understood.

>> 
>> I liked the additional clarity of not having to count zero's.
> 
> Like you prefer. I knew cases where the comments and the values didn't
> matched anymore. Then it gets harder to decide which value is correct.
> 

Yes they should be kept in sync.

>> > > +	};
>> > > +};
>> > > +
>> > > +&i2c3 {
>> > > +	clock-frequency = <100000>;
>> > > +	pinctrl-names = "default";
>> > > +	pinctrl-0 = <&pinctrl_i2c3>, <&pinctrl_imu>;
>> >
>> > Why do you don't mux the pinctrl_imu within the magnetometer@1e node?
>> >
>> > > +	status = "okay";
>> > > +
>> > > +	lsm9d_magn: magnetometer@1e	{
>> >
>> > Is that phandle necessary?
>> >
>> > > +		compatible = "st,lsm9ds1-magn";
>> > > +		reg = <0x1e>;
>> > > +		interrupt-parent = <&gpio3>;
>> > > +		interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
>> > > +		vdd-supply = <&reg_3V3_P>;
>> > > +		vddio-supply = <&reg_3V3_P>;
>> > > +	};
>> > > +
>> > > +	goodix_ts: touchscreen@5d {
>> >
>> > This here too.
>> >
>> > > +		compatible = "goodix,gt5688";
>> > > +		pinctrl-names = "default";
>> > > +		pinctrl-0 = <&pinctrl_goodix_ts>;
>> > > +		reg = <0x5d>;
>> >
>> > The reg = <> should be followed the compatible string.
>> >
>> > > +		interrupt-parent = <&gpio3>;
>> > > +		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>> > > +		reset-gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
>> > > +		irq-gpios = <&gpio3 0 GPIO_ACTIVE_HIGH>;
>> > > +		touchscreen-size-x = <720>;
>> > > +		touchscreen-size-y = <1440>;
>> > > +		AVDD28-supply = <&reg_2V8_P>;
>> > > +		VDDIO-supply = <&reg_1V8_P>;
>> >
>> > Didn't found any of these supplies. Can you drop them?
>> >
>> 
>> AVDD28 line 539 in drivers/input/touchscreen/goodix.c
>> 
>> VDDIO line 548 in drivers/input/touchscreen/goodix.c
> 
> Nope,
> https://elixir.bootlin.com/linux/v5.1-rc5/source/drivers/input/touchscreen/goodix.c#L539
> 
> Did you have any patches applied or are there some ongoing patches?
> 

This is based on linux-next next-20190415

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/input/touchscreen/goodix.c?h=next-20190412#n539

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/input/touchscreen/goodix.c?h=next-20190412#n548

>> 
>> > > +	};
>> > > +};
>> > > +
>> > > +&iomuxc {
>> >
>> > It seems a bit inconsistent to add a comment behind the
>> > mux or above. I would add comments just above.
>> >
>> 
>> My preference was for commenting after but that made some lines longer 
>> than
>> 80 cols so I reduced the offending lines.
>> 
>> > > +	pinctrl_bt: btgrp {
>> > > +		fsl,pins = <
>> > > +		/* nBT_DISABLE */
>> > > +		MX8MQ_IOMUXC_NAND_DATA05_GPIO3_IO11             0x16
>> >
>> > As you do it here.
>> >
>> > > +		/* BT_HOST_WAKE */
>> > > +		MX8MQ_IOMUXC_NAND_DATA01_GPIO3_IO7              0x10
>> > > +		>;
>> > > +	};
>> > > +
>> > > +	pinctrl_charger: chargernirq {
>> > > +		fsl,pins = <
>> > > +		/* CHRG_nINT */
>> > > +		MX8MQ_IOMUXC_SAI5_MCLK_GPIO3_IO25	0x80
>> > > +		>;
>> > > +	};
>> > > +
>> > > +	pinctrl_fec1: fec1grp {
>> > > +		fsl,pins = <
>> > > +		MX8MQ_IOMUXC_ENET_MDC_ENET1_MDC		0x3
>> > > +		MX8MQ_IOMUXC_ENET_MDIO_ENET1_MDIO	0x3
>> > > +		MX8MQ_IOMUXC_ENET_TD3_ENET1_RGMII_TD3	0x1f
>> > > +		MX8MQ_IOMUXC_ENET_TD2_ENET1_RGMII_TD2	0x1f
>> > > +		MX8MQ_IOMUXC_ENET_TD1_ENET1_RGMII_TD1	0x1f
>> > > +		MX8MQ_IOMUXC_ENET_TD0_ENET1_RGMII_TD0	0x1f
>> > > +		MX8MQ_IOMUXC_ENET_RD3_ENET1_RGMII_RD3	0x91
>> > > +		MX8MQ_IOMUXC_ENET_RD2_ENET1_RGMII_RD2	0x91
>> > > +		MX8MQ_IOMUXC_ENET_RD1_ENET1_RGMII_RD1	0x91
>> > > +		MX8MQ_IOMUXC_ENET_RD0_ENET1_RGMII_RD0	0x91
>> > > +		MX8MQ_IOMUXC_ENET_TXC_ENET1_RGMII_TXC	0x1f
>> > > +		MX8MQ_IOMUXC_ENET_RXC_ENET1_RGMII_RXC	0x91
>> > > +		MX8MQ_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
>> > > +		MX8MQ_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
>> > > +		MX8MQ_IOMUXC_GPIO1_IO09_GPIO1_IO9	0x19
>> > > +		MX8MQ_IOMUXC_GPIO1_IO15_CCMSRCGPCMIX_CLKO2      0x1f
>> > > +		>;
>> > > +	};
>> > > +
>> > > +	pinctrl_goodix_ts: gt5688 {
>> > > +		fsl,pins = <
>> > > +		/* TOUCH INT */
>> > > +		MX8MQ_IOMUXC_NAND_ALE_GPIO3_IO0         0x16
>> > > +		/* TOUCH RST */
>> > > +		MX8MQ_IOMUXC_GPIO1_IO05_GPIO1_IO5	0x19
>> > > +		>;
>> > > +	};
>> > > +
>> > > +	pinctrl_gpio_leds: gpioleds {
>> > > +		fsl,pins = <
>> > > +		MX8MQ_IOMUXC_GPIO1_IO13_GPIO1_IO13	0x16
>> > > +		>;
>> > > +	};
>> > > +
>> > > +	pinctrl_gpio_keys: gpiokeys {
>> > > +		fsl,pins = <
>> > > +		MX8MQ_IOMUXC_SAI2_RXFS_GPIO4_IO21	0x16
>> > > +		MX8MQ_IOMUXC_SAI2_RXC_GPIO4_IO22	0x16
>> > > +		/* HP_DET */
>> > > +		MX8MQ_IOMUXC_SAI5_RXC_GPIO3_IO20	0x180
>> > > +		>;
>> > > +	};
>> > > +
>> > > +	pinctrl_haptic: hapticgrp {
>> > > +		fsl,pins = <
>> > > +		MX8MQ_IOMUXC_SPDIF_RX_PWM2_OUT		0xc6  /* nHAPTIC */
>> > > +		>;
>> > > +	};
>> > > +
>> > > +	pinctrl_i2c1: i2c1grp {
>> > > +		fsl,pins = <
>> > > +		MX8MQ_IOMUXC_I2C1_SCL_I2C1_SCL		0x4000001f
>> > > +		MX8MQ_IOMUXC_I2C1_SDA_I2C1_SDA		0x4000001f
>> > > +		>;
>> > > +	};
>> > > +
>> > > +	pinctrl_i2c3: i2c3grp {
>> > > +		fsl,pins = <
>> > > +		MX8MQ_IOMUXC_I2C3_SCL_I2C3_SCL		0x4000001f
>> > > +		MX8MQ_IOMUXC_I2C3_SDA_I2C3_SDA		0x4000001f
>> > > +		>;
>> > > +	};
>> > > +
>> > > +	pinctrl_imu: imugrp {
>> > > +		fsl,pins = <
>> > > +		/* IMU_INT */
>> > > +		MX8MQ_IOMUXC_SAI5_RXFS_GPIO3_IO19	0x8
>> > > +		>;
>> > > +	};
>> > > +
>> > > +	pinctrl_pmic: pmicint {
>> > > +		fsl,pins = <
>> > > +		MX8MQ_IOMUXC_GPIO1_IO03_GPIO1_IO3	0x80
>> > > +		>;
>> > > +	};
>> > > +
>> > > +	pinctrl_pwr_en: pwrengrp {
>> > > +		fsl,pins = <
>> > > +		MX8MQ_IOMUXC_GPIO1_IO08_GPIO1_IO8               0x06
>> > > +		>;
>> > > +	};
>> > > +
>> > > +	pinctrl_pwm1: pwm1 {
>> > > +		fsl,pins = <
>> > > +		MX8MQ_IOMUXC_GPIO1_IO01_PWM1_OUT	0x6  /* DSI_BL_PWM */
>> > > +		>;
>> > > +	};
>> > > +
>> > > +	pinctrl_rtc: rtcirq {
>> > > +		fsl,pins = <
>> > > +		MX8MQ_IOMUXC_SAI3_RXC_GPIO4_IO29	0x80
>> > > +		>;
>> > > +	};
>> > > +
>> > > +	pinctrl_typec: typecgrp {
>> > > +		fsl,pins = <
>> > > +		MX8MQ_IOMUXC_NAND_DATA06_GPIO3_IO12	0x16
>> > > +		MX8MQ_IOMUXC_NAND_CE0_B_GPIO3_IO1	0x80
>> > > +		>;
>> > > +	};
>> > > +
>> > > +	pinctrl_uart1: uart1grp {
>> > > +		fsl,pins = <
>> > > +		MX8MQ_IOMUXC_UART1_RXD_UART1_DCE_RX		0x49
>> > > +		MX8MQ_IOMUXC_UART1_TXD_UART1_DCE_TX		0x49
>> > > +		>;
>> > > +	};
>> > > +
>> > > +	pinctrl_uart2: uart2grp {
>> > > +		fsl,pins = <
>> > > +		MX8MQ_IOMUXC_UART2_TXD_UART2_DCE_TX		0x49
>> > > +		MX8MQ_IOMUXC_UART2_RXD_UART2_DCE_RX		0x49
>> > > +		MX8MQ_IOMUXC_UART4_RXD_UART2_DCE_CTS_B		0x49
>> > > +		MX8MQ_IOMUXC_UART4_TXD_UART2_DCE_RTS_B		0x49
>> > > +		>;
>> > > +	};
>> > > +
>> > > +	pinctrl_uart3: uart3grp {
>> > > +		fsl,pins = <
>> > > +		MX8MQ_IOMUXC_UART3_RXD_UART3_DCE_RX		0x49
>> > > +		MX8MQ_IOMUXC_UART3_TXD_UART3_DCE_TX		0x49
>> > > +		>;
>> > > +	};
>> > > +
>> > > +	pinctrl_uart4: uart4grp {
>> > > +		fsl,pins = <
>> > > +		MX8MQ_IOMUXC_ECSPI2_SCLK_UART4_DCE_RX		0x49
>> > > +		MX8MQ_IOMUXC_ECSPI2_MOSI_UART4_DCE_TX		0x49
>> > > +		MX8MQ_IOMUXC_ECSPI2_MISO_UART4_DCE_CTS_B	0x49
>> > > +		MX8MQ_IOMUXC_ECSPI2_SS0_UART4_DCE_RTS_B		0x49
>> > > +		MX8MQ_IOMUXC_GPIO1_IO00_ANAMIX_REF_CLK_32K	0x49
>> > > +		>;
>> > > +	};
>> > > +
>> > > +	pinctrl_usdhc1: usdhc1grp {
>> > > +		fsl,pins = <
>> > > +		MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x83
>> > > +		MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xc3
>> > > +		MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xc3
>> > > +		MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xc3
>> > > +		MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xc3
>> > > +		MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xc3
>> > > +		MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xc3
>> > > +		MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xc3
>> > > +		MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xc3
>> > > +		MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xc3
>> > > +		MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x83
>> > > +		MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
>> > > +		>;
>> > > +	};
>> > > +
>> > > +	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
>> > > +		fsl,pins = <
>> > > +		MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x8d
>> > > +		MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xcd
>> > > +		MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xcd
>> > > +		MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xcd
>> > > +		MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xcd
>> > > +		MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xcd
>> > > +		MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xcd
>> > > +		MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xcd
>> > > +		MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xcd
>> > > +		MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xcd
>> > > +		MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x8d
>> > > +		MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
>> > > +		>;
>> > > +	};
>> > > +
>> > > +	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
>> > > +		fsl,pins = <
>> > > +		MX8MQ_IOMUXC_SD1_CLK_USDHC1_CLK			0x9f
>> > > +		MX8MQ_IOMUXC_SD1_CMD_USDHC1_CMD			0xdf
>> > > +		MX8MQ_IOMUXC_SD1_DATA0_USDHC1_DATA0		0xdf
>> > > +		MX8MQ_IOMUXC_SD1_DATA1_USDHC1_DATA1		0xdf
>> > > +		MX8MQ_IOMUXC_SD1_DATA2_USDHC1_DATA2		0xdf
>> > > +		MX8MQ_IOMUXC_SD1_DATA3_USDHC1_DATA3		0xdf
>> > > +		MX8MQ_IOMUXC_SD1_DATA4_USDHC1_DATA4		0xdf
>> > > +		MX8MQ_IOMUXC_SD1_DATA5_USDHC1_DATA5		0xdf
>> > > +		MX8MQ_IOMUXC_SD1_DATA6_USDHC1_DATA6		0xdf
>> > > +		MX8MQ_IOMUXC_SD1_DATA7_USDHC1_DATA7		0xdf
>> > > +		MX8MQ_IOMUXC_SD1_STROBE_USDHC1_STROBE		0x9f
>> > > +		MX8MQ_IOMUXC_SD1_RESET_B_USDHC1_RESET_B		0xc1
>> > > +		>;
>> > > +	};
>> > > +
>> > > +	pinctrl_usdhc2_gpio: usdhc2grpgpio {
>> > > +		fsl,pins = <
>> > > +		MX8MQ_IOMUXC_SD2_RESET_B_GPIO2_IO19		0x41
>> > > +		/* WIFI_WAKE */
>> > > +		MX8MQ_IOMUXC_SD2_WP_GPIO2_IO20			0x80
>> > > +		>;
>> > > +	};
>> > > +
>> > > +	pinctrl_usdhc2: usdhc2grp {
>> > > +		fsl,pins = <
>> > > +		MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x83
>> > > +		MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xc3
>> > > +		MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xc3
>> > > +		MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xc3
>> > > +		MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xc3
>> > > +		MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xc3
>> > > +		>;
>> > > +	};
>> > > +
>> > > +	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
>> > > +		fsl,pins = <
>> > > +		MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x8d
>> > > +		MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xcd
>> > > +		MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xcd
>> > > +		MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xcd
>> > > +		MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xcd
>> > > +		MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xcd
>> > > +		>;
>> > > +	};
>> > > +
>> > > +	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
>> > > +		fsl,pins = <
>> > > +		MX8MQ_IOMUXC_SD2_CLK_USDHC2_CLK			0x9f
>> > > +		MX8MQ_IOMUXC_SD2_CMD_USDHC2_CMD			0xcf
>> > > +		MX8MQ_IOMUXC_SD2_DATA0_USDHC2_DATA0		0xcf
>> > > +		MX8MQ_IOMUXC_SD2_DATA1_USDHC2_DATA1		0xcf
>> > > +		MX8MQ_IOMUXC_SD2_DATA2_USDHC2_DATA2		0xcf
>> > > +		MX8MQ_IOMUXC_SD2_DATA3_USDHC2_DATA3		0xcf
>> > > +		>;
>> > > +	};
>> > > +
>> > > +	pinctrl_wdog: wdoggrp {
>> > > +		fsl,pins = <
>> > > +		MX8MQ_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B	0xc6
>> > > +		>;
>> > > +	};
>> > > +
>> > > +	pinctrl_wwan: wwangrp {
>> > > +		fsl,pins = <
>> > > +		/* nWWAN_DISABLE */
>> > > +		MX8MQ_IOMUXC_NAND_CE3_B_GPIO3_IO4	0x09
>> > > +		/* nWoWWAN */
>> > > +		MX8MQ_IOMUXC_NAND_DATA02_GPIO3_IO8	0x80
>> > > +		/* WWAN_RESET */
>> > > +		MX8MQ_IOMUXC_NAND_DATA03_GPIO3_IO9	0x19
>> > > +		>;
>> > > +	};
>> > > +
>> > > +};
>> > > +
>> > > +&pwm1 {
>> > > +	pinctrl-names = "default";
>> > > +	pinctrl-0 = <&pinctrl_pwm1>;
>> > > +	status = "okay";
>> > > +};
>> > > +
>> > > +&pwm2 {
>> > > +	pinctrl-names = "default";
>> > > +	pinctrl-0 = <&pinctrl_haptic>;
>> >
>> > Just a nitpick but I would name it pinctrl_pwm2 as you did it for pwm1.
>> >
>> 
>> I figured haptic was more descriptive.
> 
> Descriptive for the pwm node? If that is the case the pwm1 node should 
> be
> called backlight. Anyway as I said it's just a nitpick.
> 
>> 
>> > > +	status = "okay";
>> > > +};
>> > > +
>> > > +&uart1 { /* console */
>> > > +	pinctrl-names = "default";
>> > > +	pinctrl-0 = <&pinctrl_uart1>;
>> > > +	status = "okay";
>> > > +};
>> > > +
>> > > +&uart3 { /* GNSS */
>> > > +	pinctrl-names = "default";
>> > > +	pinctrl-0 = <&pinctrl_uart3>;
>> > > +	status = "okay";
>> > > +};
>> > > +
>> > > +&uart4 { /* BT */
>> > > +	pinctrl-names = "default";
>> > > +	pinctrl-0 = <&pinctrl_uart4>, <&pinctrl_bt>;
>> > > +	uart-has-rtscts;
>> > > +	status = "okay";
>> > > +};
>> > > +
>> > > +&usb3_phy0 {
>> > > +	status = "okay";
>> >
>> > Should be the last property.
>> >
>> > > +	#address-cells = <1>;
>> > > +	#size-cells = <0>;
>> >
>> > Blank line.
>> > > +	port@0 {
>> > > +		reg = <0>;
>> >
>> > and here
>> > > +		typec_hs: endpoint {
>> > > +			remote-endpoint = <&usb_con_hs>;
>> > > +		};
>> > > +	};
>> >
>> > here
>> >
>> > > +	port@1 {
>> > > +		reg = <1>;
>> >
>> > and here.
>> >
>> > > +		typec_ss: endpoint {
>> > > +			remote-endpoint = <&usb_con_ss>;
>> > > +		};
>> > > +	};
>> > > +};
>> > > +
>> > > +&usb3_phy1 {
>> > > +	status = "okay";
>> > > +	#address-cells = <1>;
>> > > +	#size-cells = <0>;
>> >
>> > Why did you assign the #address-cells and #size-cells without specify
>> > any port? Status should be the last property.
>> >
>> 
>> Cut and paste from phy0.
>> 
>> > > +};
>> > > +
>> > > +&usb_dwc3_0 {
>> > > +	status = "okay";
>> >
>> > Here also.
>> >
>> > > +	extcon = <&typec_ptn5100>;
>> > > +	dr_mode = "otg";
>> > > +};
>> > > +
>> > > +&usb_dwc3_1 {
>> > > +	status = "okay";
>> >
>> > And here.
>> >
>> > > +	dr_mode = "host";
>> > > +};
>> > > +
>> > > +&usdhc1 {
>> > > +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
>> > > +	pinctrl-0 = <&pinctrl_usdhc1>;
>> > > +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
>> > > +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
>> > > +	bus-width = <8>;
>> > > +	non-removable;
>> > > +	status = "okay";
>> > > +};
>> > > +
>> > > +&usdhc2 {
>> > > +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
>> > > +	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
>> >
>> > You can drop the pinctrl_usdhc2_gpio handle if you mux them within the
>> > regulator node.
>> 
>> Ok
>> 
>> >
>> > > +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
>> > > +	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
>> > > +	bus-width = <4>;
>> > > +	vmmc-supply = <&reg_usdhc2_vmmc>;
>> > > +	power-supply = <&wifi_pwr_en>;
>> > > +
>> > > +	non-removable;
>> > > +	disable-wp;
>> > > +	cap-sdio-irq;
>> > > +	keep-power-in-suspend;
>> > > +	wakeup-source;
>> > > +	status = "okay";
>> > > +};
>> > > +
>> > > +&wdog1 {
>> > > +	pinctrl-names = "default";
>> > > +	pinctrl-0 = <&pinctrl_wdog>;
>> > > +	fsl,ext-reset-output;
>> > > +	status = "okay";
>> > > +};
>> > > --
>> > > 2.17.1
>> > >
>> >
>> > So now I finished, sorry for don't cover that in your v3.
>> >

And you're sure there aren't any more :)

Thanks
Angus

>> > Regards,
>> >   Marco
>> 
>> Thanks
>> Angus
> 
> Regards,
>   Marco
> 
>> 
>> 

