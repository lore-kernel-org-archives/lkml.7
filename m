Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC64C04AAF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 02:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD5920862
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 02:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558060547;
	bh=MAqJb50WiN3kf4StNzeVevskR8Jy9C+9lKFxbUJl71M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gR+fFv7p9ktPfGzgEYfNVO1Og6awq7PHMHhrQuCtQjbG8708Hzr9SSYm3bDf5xUbE
	 txvmIi98S16FerNbCVP/GF8ctoGeNX7WWzrQ1HpzWApT4wm6ZZRc0DG7cYe/8NZMkD
	 GZxblLp1rfo4i26E0jQRqVvRvYVswU4ZeNDay0S0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfEQCfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 22:35:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfEQCfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 22:35:46 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4AA4204EC;
        Fri, 17 May 2019 02:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558060545;
        bh=MAqJb50WiN3kf4StNzeVevskR8Jy9C+9lKFxbUJl71M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SDYlH75BVrjV8KKH16vbu58ez13GtL5xeIkCFVuwcJsjjdTe6J6GEV47M00zaAPmv
         jr4ARtXDeFUMjV0GRd5890uHKJc1BftnqRHHo3KpmmThm0NSD0yPWA7vHBY5iYMvBv
         VEelHKbpGk4qgIe0kCF184bcw68ELJimcEnZbflo=
Date:   Fri, 17 May 2019 10:35:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Pramod Kumar <pramod.kumar_1@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "Michal.Vokac@ysoft.com" <Michal.Vokac@ysoft.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: Re: [PATCH 2/2] add dts file to enable support for ls1046afrwy board.
Message-ID: <20190517023502.GZ15856@dragon>
References: <20190508135501.17578-1-pramod.kumar_1@nxp.com>
 <20190508135501.17578-3-pramod.kumar_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508135501.17578-3-pramod.kumar_1@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 01:53:10PM +0000, Pramod Kumar wrote:
> ls1046afrwy board is based on nxp ls1046a SoC.
> 
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> Signed-off-by: Pramod Kumar <pramod.kumar_1@nxp.com>

Please have a subject prefix like 'arm64: dts: ...'

Shawn

> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../boot/dts/freescale/fsl-ls1046a-frwy.dts   | 156 ++++++++++++++++++
>  2 files changed, 157 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 13604e558dc1..84ff6995b41e 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -8,6 +8,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1028a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1043a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1043a-rdb.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-frwy.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1046a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls1088a-qds.dtb
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts
> new file mode 100644
> index 000000000000..de0d19c02944
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Device Tree Include file for Freescale Layerscape-1046A family SoC.
> + *
> + * Copyright 2019 NXP.
> + *
> + */
> +
> +/dts-v1/;
> +
> +#include "fsl-ls1046a.dtsi"
> +
> +/ {
> +	model = "LS1046A FRWY Board";
> +	compatible = "fsl,ls1046a-frwy", "fsl,ls1046a";
> +
> +	aliases {
> +		serial0 = &duart0;
> +		serial1 = &duart1;
> +		serial2 = &duart2;
> +		serial3 = &duart3;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	sb_3v3: regulator-sb3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "LT8642SEV-3.3V";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +};
> +
> +&duart0 {
> +	status = "okay";
> +};
> +
> +&duart1 {
> +	status = "okay";
> +};
> +
> +&duart2 {
> +	status = "okay";
> +};
> +
> +&duart3 {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	i2c-mux@77 {
> +		compatible = "nxp,pca9546";
> +		reg = <0x77>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		i2c-mux-never-disable;
> +
> +		i2c@0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;
> +
> +			eeprom@52 {
> +				compatible = "atmel,24c512";
> +				reg = <0x52>;
> +			};
> +
> +			eeprom@53 {
> +				compatible = "atmel,24c512";
> +				reg = <0x53>;
> +			};
> +
> +			power-monitor@40 {
> +				compatible = "ti,ina220";
> +				reg = <0x40>;
> +				shunt-resistor = <1000>;
> +			};
> +
> +			rtc@51 {
> +				compatible = "nxp,pcf2129";
> +				reg = <0x51>;
> +			};
> +
> +			temperature-sensor@4c {
> +				compatible = "nxp,sa56004";
> +				reg = <0x4c>;
> +				vcc-supply = <&sb_3v3>;
> +			};
> +
> +		};
> +	};
> +};
> +
> +&ifc {
> +	#address-cells = <2>;
> +	#size-cells = <1>;
> +	/* NAND Flash */
> +	ranges = <0x0 0x0 0x0 0x7e800000 0x00010000>;
> +	status = "okay";
> +
> +	nand@0,0 {
> +		compatible = "fsl,ifc-nand";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0x0 0x0 0x10000>;
> +	};
> +
> +};
> +
> +#include "fsl-ls1046-post.dtsi"
> +
> +&fman0 {
> +	ethernet@e0000 {
> +		phy-handle = <&qsgmii_phy4>;
> +		phy-connection-type = "qsgmii";
> +	};
> +
> +	ethernet@e8000 {
> +		phy-handle = <&qsgmii_phy2>;
> +		phy-connection-type = "qsgmii";
> +	};
> +
> +	ethernet@ea000 {
> +		phy-handle = <&qsgmii_phy1>;
> +		phy-connection-type = "qsgmii";
> +	};
> +
> +	ethernet@f2000 {
> +		phy-handle = <&qsgmii_phy3>;
> +		phy-connection-type = "qsgmii";
> +	};
> +
> +	mdio@fd000 {
> +		qsgmii_phy1: ethernet-phy@1c {
> +			reg = <0x1c>;
> +		};
> +
> +		qsgmii_phy2: ethernet-phy@1d {
> +			reg = <0x1d>;
> +		};
> +
> +		qsgmii_phy3: ethernet-phy@1e {
> +			reg = <0x1e>;
> +		};
> +
> +		qsgmii_phy4: ethernet-phy@1f {
> +			reg = <0x1f>;
> +		};
> +	};
> +};
> -- 
> 2.17.1
> 
