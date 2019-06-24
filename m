Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78858C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 05:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43E652083D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 05:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfFXFxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 01:53:01 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36837 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFXFw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 01:52:58 -0400
Received: by mail-lf1-f65.google.com with SMTP id q26so9084433lfc.3;
        Sun, 23 Jun 2019 22:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8VHCAm+hYdFDIXtmf443m3LBaXBMxitpFyn5ZW0K3xE=;
        b=qMl2HEhfmeyZrxZqkNBNxzbWQDtu9YOK0DAWpqENAj+cmJI92Ov2T+YnGYugQVXeh6
         MKrMPl5/mzMbg8yNMkOuuFNWnxFhKg7JrXPgqGJTCfgGm26dqt6o1TBGOMSAJskEvzu5
         r1QkKdtqd5DPk1tXjKxH/dOyJdiQjS0+v34uSlU0NduG4hL0l9yG35wgFwjB55v1Ri90
         NCj4fm0mwjphQriUSNL52anw5bxel7PleeSCgZUwVtC4+aN8P5UEkCZefW/pj0NF5MD3
         5tBBn944OsfhvaQJZ5ciJ82kBQrCXb+PluZZZAUkiV7d1+rGHdcRny/cmm+yGRCQsjva
         QfNg==
X-Gm-Message-State: APjAAAUp86JouZGJnET1tMMKG0LX8GxgKc0AMUfI9+GrTRi85VJhJndA
        uTqIhOuwej1jRs0mCI4q/U0=
X-Google-Smtp-Source: APXvYqx5jRgJntG/VtXsIwD9/7hnm9rPPVhWP4P5E155YspUq6VTiNb/8SihbFK++DAyMAOH5yPN5A==
X-Received: by 2002:ac2:46d5:: with SMTP id p21mr27110999lfo.133.1561355575169;
        Sun, 23 Jun 2019 22:52:55 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id h10sm1406091lfj.10.2019.06.23.22.52.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Jun 2019 22:52:54 -0700 (PDT)
Date:   Mon, 24 Jun 2019 08:52:47 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Andra Danciu <andradanciu1997@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        leoyang.li@nxp.com, aisheng.dong@nxp.com, sriram.dash@nxp.com,
        pramod.kumar_1@nxp.com, bhaskar.upadhaya@nxp.com,
        vabhav.sharma@nxp.com, pankaj.bansal@nxp.com,
        richard.hu@technexion.com, l.stach@pengutronix.de,
        ping.bai@nxp.com, manivannan.sadhasivam@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.baluta@nxp.com
Subject: Re: [RFC PATCH] arm64: dts: fsl: wandboard: Add a device tree for
 the PICO-PI-IMX8M
Message-ID: <20190624055247.GA10377@localhost.localdomain>
References: <20190620133252.31373-1-andradanciu1997@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620133252.31373-1-andradanciu1997@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Richard,

Nice to see you upstreaming this! Thumbs up!

Just few remarks to pmic node from me:

On Thu, Jun 20, 2019 at 04:32:52PM +0300, Andra Danciu wrote:
> From: Richard Hu <richard.hu@technexion.com>
> 
> The current level of support yields a working console and is able to boot
> userspace from an initial ramdisk copied via u-boot in RAM.
> 
> Additional subsystems that are active :
> 	- Ethernet
> 	- USB
> 
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Richard Hu <richard.hu@technexion.com>
> Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
> ---
>  I am using pico-pi-8mxm board to work on my project for Google Summer of Code.
>  This is based on patches from https://github.com/wandboard-org.
> 
>  arch/arm64/boot/dts/freescale/Makefile       |   1 +
>  arch/arm64/boot/dts/freescale/wand-pi-8m.dts | 590 +++++++++++++++++++++++++++
>  2 files changed, 591 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/wand-pi-8m.dts
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 984554343c83..5904d6a8a033 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -23,3 +23,4 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
> +dtb-$(CONFIG_ARCH_MXC) += wand-pi-8m.dtb
> diff --git a/arch/arm64/boot/dts/freescale/wand-pi-8m.dts b/arch/arm64/boot/dts/freescale/wand-pi-8m.dts
> new file mode 100644
> index 000000000000..9f7121014722
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/wand-pi-8m.dts
> @@ -0,0 +1,590 @@

// snip

> +
> +&i2c1 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +
> +	typec_tusb320:tusb320@47 {
> +		compatible = "ti,tusb320";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_tusb320_irq &pinctrl_typec_ss_sel>;
> +		reg = <0x47>;
> +		vbus-supply = <&reg_usb_otg_vbus>;
> +		ss-sel-gpios = <&gpio3 5 GPIO_ACTIVE_HIGH>;
> +		tusb320,int-gpio = <&gpio3 6 GPIO_ACTIVE_LOW>;
> +		tusb320,select-mode = <0>;
> +		tusb320,dfp-power = <0>;
> +	};
> +
> +	pmic: bd71837@4b {

I was once told the node names should be generic :] So, I'd suggest
using "pmic@4b".

> +		reg = <0x4b>;
> +		compatible = "rohm,bd71837";
> +		/* PMIC BD71837 PMIC_nINT GPIO1_IO12 */
> +		pinctrl-0 = <&pinctrl_pmic>;
> +		gpio_intr = <&gpio1 3 GPIO_ACTIVE_LOW>;
> +
> +		bd71837,pmic-buck1-uses-i2c-dvs;
> +		bd71837,pmic-buck1-dvs-voltage = <900000>, <850000>, <800000>; /* VDD_SOC: Run-Idle-Suspend */
> +		bd71837,pmic-buck2-uses-i2c-dvs;
> +		bd71837,pmic-buck2-dvs-voltage = <1000000>, <900000>, <0>; /* VDD_ARM: Run-Idle */
> +		bd71837,pmic-buck3-uses-i2c-dvs;
> +		bd71837,pmic-buck3-dvs-voltage = <1000000>, <0>, <0>; /* VDD_GPU: Run */
> +		bd71837,pmic-buck4-uses-i2c-dvs;
> +		bd71837,pmic-buck4-dvs-voltage = <1000000>, <0>, <0>; /* VDD_VPU: Run */

These entries should be replaced by proper properties for run-level voltage
configuration. Please see the
Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt and
Documentation/devicetree/bindings/regulator/rohm,bd71837-regulator.txt.

I think you wish to use rohm,dvs-run-voltage, rohm,dvs-idle-voltage,
and rohm,dvs-suspend-voltage instead.

Furthermore, I see you are not specifying rohm,reset-snvs-powered.
I wonder if it is intentional to not use SNVS as reset target. Seeing you
use i.MX8 and seeing used those unsupported run-level configuration properties
which were present only in some very first proprietary driver draft - I
expect this may not be intentional. I think that early driver defaulted
to SNVS while it also failed to provide any regulator enable/disable
control.

> +
> +		gpo {
> +			rohm,drv = <0x0C>;	/* 0b0000_1100 all gpos with cmos output mode */
> +		};

What is this?

> +
> +		regulators {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			buck1_reg: regulator@0 {

I don't think the node names are correct. As far as I know the regulator
core uses node names - please see the valid names from documentation.

> +				reg = <0>;
> +				regulator-compatible = "buck1";
I think you shouldn't use regulator-compatible. On the other hand, I
think you should use regulator-name.
> +				regulator-min-microvolt = <700000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <1250>;
> +			};
> +
> +			buck2_reg: regulator@1 {
> +				reg = <1>;
> +				regulator-compatible = "buck2";
> +				regulator-min-microvolt = <700000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <1250>;
> +			};
> +
> +			buck3_reg: regulator@2 {
> +				reg = <2>;
> +				regulator-compatible = "buck3";
> +				regulator-min-microvolt = <700000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-boot-on;
> +				regulator-always-on;

In typical BD71837 use-cases the buck 3 is used to power graphichs accelerator.
I wonder if enable/disable control should be allowed to help thermal
issues and power saving? (This comment can be ignored if not applicaple
to your board)

> +			};
> +
> +			buck4_reg: regulator@3 {
> +				reg = <3>;
> +				regulator-compatible = "buck4";
> +				regulator-min-microvolt = <700000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-boot-on;
> +				regulator-always-on;

In typical BD71837 use-cases the buck 4 is used to power VPU.
I wonder if enable/disable control should be allowed to help thermal
issues and power saving? (This comment can be ignored if not applicaple          
to your board)

> +			};
> +
> +			buck5_reg: regulator@4 {
> +				reg = <4>;
> +				regulator-compatible = "buck5";
> +				regulator-min-microvolt = <700000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck6_reg: regulator@5 {
> +				reg = <5>;
> +				regulator-compatible = "buck6";
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck7_reg: regulator@6 {
> +				reg = <6>;
> +				regulator-compatible = "buck7";
> +				regulator-min-microvolt = <1605000>;
> +				regulator-max-microvolt = <1995000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			buck8_reg: regulator@7 {
> +				reg = <7>;
> +				regulator-compatible = "buck8";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1400000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo1_reg: regulator@8 {
> +				reg = <8>;
> +				regulator-compatible = "ldo1";
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo2_reg: regulator@9 {
> +				reg = <9>;
> +				regulator-compatible = "ldo2";
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <900000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo3_reg: regulator@10 {
> +				reg = <10>;
> +				regulator-compatible = "ldo3";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo4_reg: regulator@11 {
> +				reg = <11>;
> +				regulator-compatible = "ldo4";
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +
> +			ldo5_reg: regulator@12 {
> +				reg = <12>;
> +				regulator-compatible = "ldo5";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;

You may want to mark the BUCK6 as a supply for LDO5.

> +			};
> +
> +			ldo6_reg: regulator@13 {
> +				reg = <13>;
> +				regulator-compatible = "ldo6";
> +				regulator-min-microvolt = <900000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-boot-on;
> +				regulator-always-on;

You may want to mark the BUCK7 as a supply for LDO6.

> +			};
> +
> +			ldo7_reg: regulator@14 {
> +				reg = <14>;
> +				regulator-compatible = "ldo7";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +			};
> +		};
> +	};
> +};
> +

Best Regards
	Matti Vaittinen

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
