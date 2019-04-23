Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F589C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 05:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2192064A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 05:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfDWFU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 01:20:26 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44019 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfDWFUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 01:20:25 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hInqw-0002In-O3; Tue, 23 Apr 2019 07:20:22 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1hInqw-000363-3q; Tue, 23 Apr 2019 07:20:22 +0200
Date:   Tue, 23 Apr 2019 07:20:22 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/2] arm64: dts: imx8mm: Add SAI nodes
Message-ID: <20190423052022.orwkfjy6ftqmjq5p@pengutronix.de>
References: <20190422193542.2853-1-daniel.baluta@nxp.com>
 <20190422193542.2853-2-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190422193542.2853-2-daniel.baluta@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 07:17:46 up 94 days,  9:59, 72 users,  load average: 0.06, 0.05,
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

Hi Daniel,

On 19-04-22 19:35, Daniel Baluta wrote:
> i.MX8MM has 5 SAI instances with the following base
> addresses according to RM.
> 
> SAI1 base address: 3001_0000h
> SAI2 base address: 3002_0000h
> SAI3 base address: 3003_0000h
> SAI5 base address: 3005_0000h
> SAI6 base address: 3006_0000h
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 71 +++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index de3498c2dd44..4d080dc47216 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -171,6 +171,77 @@
>  			#size-cells = <1>;
>  			ranges;
>  
> +			sai1: sai@30010000 {
> +				compatible = "fsl,imx8mm-sai",
> +						"fsl,imx8mq-sai";

Just a nitpick but I would not break this line here. This applies to the
other sai nodes too.

Regards,
  Marco

> +				reg = <0x30010000 0x10000>;
> +				interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MM_CLK_SAI1_IPG>,
> +					 <&clk IMX8MM_CLK_SAI1_ROOT>,
> +					 <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
> +				clock-names = "bus", "mclk1", "mclk2", "mclk3";
> +				dmas = <&sdma2 0 2 0>, <&sdma2 1 2 0>;
> +				dma-names = "rx", "tx";
> +				status = "disabled";
> +			};
> +
> +			sai2: sai@30020000 {
> +				compatible = "fsl,imx8mm-sai",
> +						"fsl,imx8mq-sai";
> +				reg = <0x30020000 0x10000>;
> +				interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MM_CLK_SAI2_IPG>,
> +					<&clk IMX8MM_CLK_SAI2_ROOT>,
> +					<&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
> +				clock-names = "bus", "mclk1", "mclk2", "mclk3";
> +				dmas = <&sdma2 2 2 0>, <&sdma2 3 2 0>;
> +				dma-names = "rx", "tx";
> +				status = "disabled";
> +			};
> +
> +			sai3: sai@30030000 {
> +				#sound-dai-cells = <0>;
> +				compatible = "fsl,imx8mm-sai",
> +						"fsl,imx8mq-sai";
> +				reg = <0x30030000 0x10000>;
> +				interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MM_CLK_SAI3_IPG>,
> +					 <&clk IMX8MM_CLK_SAI3_ROOT>,
> +					 <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
> +				clock-names = "bus", "mclk1", "mclk2", "mclk3";
> +				dmas = <&sdma2 4 2 0>, <&sdma2 5 2 0>;
> +				dma-names = "rx", "tx";
> +				status = "disabled";
> +			};
> +
> +			sai5: sai@30050000 {
> +				compatible = "fsl,imx8mm-sai",
> +						"fsl,imx8mq-sai";
> +				reg = <0x30050000 0x10000>;
> +				interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MM_CLK_SAI5_IPG>,
> +					 <&clk IMX8MM_CLK_SAI5_ROOT>,
> +					 <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
> +				clock-names = "bus", "mclk1", "mclk2", "mclk3";
> +				dmas = <&sdma2 8 2 0>, <&sdma2 9 2 0>;
> +				dma-names = "rx", "tx";
> +				status = "disabled";
> +			};
> +
> +			sai6: sai@30060000 {
> +				compatible = "fsl,imx8mm-sai",
> +						"fsl,imx8mq-sai";
> +				reg = <0x30060000 0x10000>;
> +				interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MM_CLK_SAI6_IPG>,
> +					 <&clk IMX8MM_CLK_SAI6_ROOT>,
> +					 <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
> +				clock-names = "bus", "mclk1", "mclk2", "mclk3";
> +				dmas = <&sdma2 10 2 0>, <&sdma2 11 2 0>;
> +				dma-names = "rx", "tx";
> +				status = "disabled";
> +			};
> +
>  			gpio1: gpio@30200000 {
>  				compatible = "fsl,imx8mm-gpio", "fsl,imx35-gpio";
>  				reg = <0x30200000 0x10000>;
> -- 
> 2.17.1
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
