Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0835DC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 08:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47E62184E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 08:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566205113;
	bh=dvHPVhvUax2+B3bDV3fweqBjG7vvPVh6dCKZsep59Pw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kGSI3VlpWt3CXevBq45G0xcxkHJHbpqyxdcpxl6yfHj6TDi//yzRTSdAT7MiCPQYX
	 TgNVmqZp0Csd+SKihCizRhwyTPAE9jKujNDc9Snve8ZJjpld+QvMnMCpiuW/8qQ5ix
	 RnDsBRQwJJ9vtDMQyBOWxrv3XE1BaKDLAjsSZQGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfHSI6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 04:58:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbfHSI6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 04:58:32 -0400
Received: from X250 (37.80-203-192.nextgentel.com [80.203.192.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B85C42086C;
        Mon, 19 Aug 2019 08:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566205111;
        bh=dvHPVhvUax2+B3bDV3fweqBjG7vvPVh6dCKZsep59Pw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KiLkiCT8nfWpjVu1iC54rmDHnjngi43bXYjsRRKC79q410E2fqlD6BUOcKlmXkQ8k
         hOcHYlDT3r7pjhk3Af/LeKPsdNsFdTLLg4ku+Bs+MnuqV6hkzvO6P0GtrVG6ZlLOM6
         vpc03XVU/OIyr5Nmv9U3xE70ZJudAW4z5er7DAcg=
Date:   Mon, 19 Aug 2019 10:58:17 +0200
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Cosmin Stefan Stoica <cosmin.stoica@nxp.com>,
        Dan Nica <dan.nica@nxp.com>,
        Larisa Ileana Grigore <larisa.grigore@nxp.com>
Subject: Re: [PATCH v2 3/6] arm64: dts: fsl: Add device tree for S32V234-EVB
Message-ID: <20190819085816.GI5999@X250>
References: <20190809112853.15846-1-stefan-gabriel.mirea@nxp.com>
 <20190809112853.15846-4-stefan-gabriel.mirea@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809112853.15846-4-stefan-gabriel.mirea@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 11:29:12AM +0000, Stefan-gabriel Mirea wrote:
> From: Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>
> 
> Add initial version of device tree for S32V234-EVB, including nodes for the
> 4 Cortex-A53 cores, AIPS bus with UART modules, ARM architected timer and
> Generic Interrupt Controller (GIC).
> 
> Keep SoC level separate from board level to let future boards with this SoC
> share common properties, while the dts files will keep board-dependent
> properties.
> 
> Signed-off-by: Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>
> Signed-off-by: Mihaela Martinas <Mihaela.Martinas@freescale.com>
> Signed-off-by: Dan Nica <dan.nica@nxp.com>
> Signed-off-by: Larisa Grigore <Larisa.Grigore@nxp.com>
> Signed-off-by: Phu Luu An <phu.luuan@nxp.com>
> Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   2 +
>  .../boot/dts/freescale/fsl-s32v234-evb.dts    |  24 ++++

The 'fsl-' prefix can be saved here, so that we can distinguish three
families by starting string: imx??? for i.MX, fsl-??? for LayerScape,
and s32??? for S32.

>  .../arm64/boot/dts/freescale/fsl-s32v234.dtsi | 130 ++++++++++++++++++
>  3 files changed, 156 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-s32v234-evb.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-s32v234.dtsi
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index c043aca66572..3af29b58a833 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -26,3 +26,5 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mq-librem5-devkit.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-zii-ultra-rmb3.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8mq-zii-ultra-zest.dtb
>  dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
> +
> +dtb-$(CONFIG_ARCH_S32) += fsl-s32v234-evb.dtb
> diff --git a/arch/arm64/boot/dts/freescale/fsl-s32v234-evb.dts b/arch/arm64/boot/dts/freescale/fsl-s32v234-evb.dts
> new file mode 100644
> index 000000000000..92bf6c5563a3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-s32v234-evb.dts
> @@ -0,0 +1,24 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2015-2016 Freescale Semiconductor, Inc.
> + * Copyright 2016-2017 NXP
> + */
> +
> +/dts-v1/;
> +#include "fsl-s32v234.dtsi"
> +
> +/ {
> +	compatible = "fsl,s32v234-evb", "fsl,s32v234";
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/fsl-s32v234.dtsi b/arch/arm64/boot/dts/freescale/fsl-s32v234.dtsi
> new file mode 100644
> index 000000000000..6d686d3ba997
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-s32v234.dtsi
> @@ -0,0 +1,130 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2015-2016 Freescale Semiconductor, Inc.
> + * Copyright 2016-2018 NXP
> + */
> +
> +/memreserve/ 0x80000000 0x00010000;
> +
> +/ {
> +	model = "Freescale S32V234";

The 'model' is usually used in board level DTS to describe the board.

> +	compatible = "fsl,s32v234";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +	};
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0 0x0>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0x0 0x80000000>;
> +			next-level-cache = <&cluster0_l2_cache>;
> +		};

Please have a newline between nodes.

> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0 0x1>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0x0 0x80000000>;
> +			next-level-cache = <&cluster0_l2_cache>;
> +		};
> +		cpu2: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0 0x100>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0x0 0x80000000>;
> +			next-level-cache = <&cluster1_l2_cache>;
> +		};
> +		cpu3: cpu@101 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0 0x101>;
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0x0 0x80000000>;
> +			next-level-cache = <&cluster1_l2_cache>;
> +		};
> +
> +		cluster0_l2_cache: l2-cache0 {
> +			compatible = "cache";
> +		};
> +
> +		cluster1_l2_cache: l2-cache1 {
> +			compatible = "cache";
> +		};
> +	};
> +
> +	soc {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		compatible = "simple-bus";
> +		interrupt-parent = <&gic>;
> +		ranges;
> +
> +		aips0: aips-bus@40000000 {
> +			compatible = "simple-bus";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			interrupt-parent = <&gic>;
> +			reg = <0x0 0x40000000 0x0 0x7D000>;
> +			ranges;
> +
> +			uart0: serial@40053000 {
> +				compatible = "fsl,s32-linflexuart";
> +				reg = <0x0 0x40053000 0x0 0x1000>;
> +				interrupts = <0 59 1>;

Please use GIC_SPI and IRQ_TYPE_xxx defines to make it more readable.

> +				status = "disabled";
> +			};
> +		};
> +
> +		aips1: aips-bus@40080000 {
> +			compatible = "simple-bus";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			interrupt-parent = <&gic>;
> +			reg = <0x0 0x40080000 0x0 0x70000>;
> +			ranges;
> +
> +			uart1: serial@400bc000 {
> +				compatible = "fsl,s32-linflexuart";
> +				reg = <0x0 0x400bc000 0x0 0x1000>;
> +				interrupts = <0 60 1>;
> +				status = "disabled";
> +			};
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <1 13 0xf08>,
> +			     <1 14 0xf08>,
> +			     <1 11 0xf08>,
> +			     <1 10 0xf08>;
> +		/* clock-frequency might be modified by u-boot, depending on the
> +		 * chip version.
> +		 */
> +		clock-frequency = <10000000>;
> +	};
> +
> +	gic: interrupt-controller@7d001000 {
> +		compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
> +		#interrupt-cells = <3>;
> +		#address-cells = <0>;
> +		interrupt-controller;
> +		reg = <0 0x7d001000 0 0x1000>,
> +		      <0 0x7d002000 0 0x2000>,
> +		      <0 0x7d004000 0 0x2000>,
> +		      <0 0x7d006000 0 0x2000>;
> +		interrupts = <1 9 0xf04>;
> +	};

We usually put these core platform devices prior to 'soc' node.

Shawn

> +};
> -- 
> 2.22.0
> 
