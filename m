Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D210FC10F14
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 02:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D2CA20870
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 02:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555901091;
	bh=Lp5yB1RqPwIiHfOjg9pBZxrGgXX/vcg+GJrVdHavxRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s/YRCykDUw1UDm4gEtBwY8t79Trp8gSvYAY+Mb6OSLUbFCrIKJx0kp/8xXNAma7Uo
	 e7l2CYlh3qkPV7N/rO99ELNJa7yofzNsCnOyAUHaa7BrpkHnRw8AJvBkXlFJDw9Z/y
	 YYHoVLkRnKRHy+qrMygKy2xzHI3YAIgKVfoMcG+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfDVCou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 22:44:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbfDVCou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 22:44:50 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E15D2075A;
        Mon, 22 Apr 2019 02:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555901088;
        bh=Lp5yB1RqPwIiHfOjg9pBZxrGgXX/vcg+GJrVdHavxRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GxEc+//RWXYf3eMK/vSzaky9ViQKL36HyshGF1o6Qq4cVflUDVVjMprxCOyFVsZ5r
         nbuV6MOpaXV7/CQrsYcmMGmMWXacdmk8iVYO3YX/mfj32Zgv9fxfpFd1+VDTB6FTua
         GXw5w3wuyeye6IOmOBceSk1hbopUuywgcBxVJqLY=
Date:   Mon, 22 Apr 2019 10:44:29 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mm: Add SAI nodes
Message-ID: <20190422024427.GU19962@dragon>
References: <20190419202024.27314-1-daniel.baluta@nxp.com>
 <20190419202024.27314-2-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190419202024.27314-2-daniel.baluta@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 08:20:39PM +0000, Daniel Baluta wrote:
> i.MX8MM has 5 SAI instances with the following base
> addresses according to RM.
> 
> SAI1 base address: 3001_0000h
> SAI2 base address: 3002_0000h
> SAI3 base address: 3003_0000h
> SAI5 base address: 3005_0000h
> SAI6 base address: 3006_0000h
> 
> Signed-off-by: Bai Ping <ping.bai@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 68 +++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index de3498c2dd44..e9a0b2b6063a 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -171,6 +171,74 @@
>  			#size-cells = <1>;
>  			ranges;
>  
> +			sai1: sai@30010000 {
> +				compatible = "fsl,imx8mq-sai",

Should be "fsl,imx8mm-sai"?

Shawn

> +					     "fsl,imx6sx-sai";
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
> +				compatible = "fsl,imx8mq-sai",
> +					     "fsl,imx6sx-sai";
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
> +				compatible = "fsl,imx8mm-sai", "fsl,imx8mq-sai", "fsl,imx6sx-sai";
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
> +				compatible = "fsl,imx8mq-sai", "fsl,imx6sx-sai";
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
> +				compatible = "fsl,imx8mq-sai", "fsl,imx6sx-sai";
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
