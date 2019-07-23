Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80510C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 06:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A362239E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 06:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563864776;
	bh=FAOKGTXAqmTCTPHbC3FYpJeKkcCGxWfoslYvZVTbRgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fccOsS6J1oJLchOMoQT1CYkAIBDCHezDLFaCKXWgL/QgNRGxI5xbisEJ1yWSGPe8Q
	 +meITTh9Capr7RgvMX7Jw0Jt9uXh0dP1c3DX5/21WFKuJq/PTlygo8Hvk1uNEaor19
	 4is76LoG3KvwOVO8CmCSswBtGSCW3rA25S5uuGqg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732401AbfGWGwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 02:52:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:41348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729771AbfGWGwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 02:52:54 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49DB2218D4;
        Tue, 23 Jul 2019 06:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563864773;
        bh=FAOKGTXAqmTCTPHbC3FYpJeKkcCGxWfoslYvZVTbRgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M8L5etTusdbpoWIQPPPDbH8NN7yRq6ckGpkreLkSnCV+5DYC8qiCVkywjMDfmRvKb
         c80IM5HsDtneskCDipwGB+6MTCdJyZ0ZwKN+7rTdZ/EvZdI7Nbti3bGI2mL5T7rdY5
         cWzcRgppJZUuzgEpDnxZQXnoFa4h+mqvxBQor8VM=
Date:   Tue, 23 Jul 2019 14:52:19 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Pramod Kumar <pramod.kumar_1@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "Michal.Vokac@ysoft.com" <Michal.Vokac@ysoft.com>,
        Leo Li <leoyang.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: nxp: add ls1046a-frwy board support
Message-ID: <20190723065217.GF15632@dragon>
References: <1563284586-29928-1-git-send-email-pramod.kumar_1@nxp.com>
 <1563284586-29928-3-git-send-email-pramod.kumar_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563284586-29928-3-git-send-email-pramod.kumar_1@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 01:43:31PM +0000, Pramod Kumar wrote:
> ls1046afrwy board is based on nxp ls1046a SoC.
> Board support's 4GB ddr memory, i2c, microSD card,
> serial console,qspi nor flash,ifc nand flash,qsgmii network interface,
> usb 3.0 and serdes interface to support two x1gen3 pcie interface.
> 
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> Signed-off-by: Pramod Kumar <pramod.kumar_1@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile             |   1 +
>  arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts | 156 +++++++++++++++++++++
>  2 files changed, 157 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 0bd122f..1211531 100644
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
> index 0000000..cda4998
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
> +
> +		i2c@0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0>;
> +
> +			power-monitor@40 {
> +				compatible = "ti,ina220";
> +				reg = <0x40>;
> +				shunt-resistor = <1000>;
> +			};
> +
> +

One newline is good enough.  I fixed it up and applied the patch.

Shawn

> +			temperature-sensor@4c {
> +				compatible = "nxp,sa56004";
> +				reg = <0x4c>;
> +				vcc-supply = <&sb_3v3>;
> +			};
> +
> +			rtc@51 {
> +				compatible = "nxp,pcf2129";
> +				reg = <0x51>;
> +			};
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
> 2.7.4
> 
