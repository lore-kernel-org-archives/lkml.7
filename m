Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5A2C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D56D20873
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 06:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554965372;
	bh=x62eGBrfw+iL1bwm5EGgIzjl3nWyxfHv6yyIEXIHn7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LmYBAYSjsCqgFTJuLNetaPwmz/dvxzZD4AATT35V7tcTWj5jEZVvFQvF7/v4PcnsC
	 FeuodNpHFBx9FTmsEenPvfY810Q1pygnBTSoJvZMlZhIdY7zv24RBpfcZgwiIF9iXL
	 hSj/s0ylQYYTLY/sCxwtgZnU9LXg+tNzghBT51ow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbfDKGta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 02:49:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbfDKGt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 02:49:28 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3913321841;
        Thu, 11 Apr 2019 06:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554965367;
        bh=x62eGBrfw+iL1bwm5EGgIzjl3nWyxfHv6yyIEXIHn7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BXaLmZ/3OqIfWaOq2VHHNdmz0hUUVszXbPLwZNQnSiLV6ZSr8IYy1kUkEuLAl1Qua
         AMFhs2zG2T5rOJlYEGGbs27njCxyF95ca6WbM80uXxFJniWfSHV5g6hKU5VfuUDtE6
         BiDcFKF9GIufbk27UP6cY0VgxgL5nDG8iuPHrel8=
Date:   Thu, 11 Apr 2019 14:49:08 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>, Teo Hall <teo.hall@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8qxp: Add lpuart1/lpuart2/lpuart3 nodes
Message-ID: <20190411064907.GZ26817@dragon>
References: <20190330170725.24360-1-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190330170725.24360-1-daniel.baluta@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 05:07:44PM +0000, Daniel Baluta wrote:
> lpuart nodes are part of the ADMA subsystem. See Audio DMA
> memory map in iMX8 QXP RM [1]
> 
> This patch is based on the dtsi file initially submitted by
> Teo Hall in i.MX NXP internal tree.
> 
> [1] https://www.nxp.com/docs/en/reference-manual/IMX8DQXPRM.pdf
> 
> Signed-off-by: Teo Hall <teo.hall@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> index 0cb939861a60..1adfe15c2ea5 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -193,6 +193,39 @@
>  			status = "disabled";
>  		};
>  
> +		adma_lpuart1: serial@5a070000 {
> +			compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
> +			reg = <0x5a070000 0x1000>;
> +			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-parent = <&gic>;
> +			clocks = <&adma_lpcg IMX_ADMA_LPCG_UART1_BAUD_CLK>;
> +			clock-names = "ipg";
> +			power-domains = <&pd IMX_SC_R_UART_1>;
> +			status = "disabled";
> +		};
> +
> +		adma_lpuart2: serial@5a080000 {
> +			compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
> +			reg = <0x5a080000 0x1000>;
> +			interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-parent = <&gic>;
> +			clocks = <&adma_lpcg IMX_ADMA_LPCG_UART2_BAUD_CLK>;
> +			clock-names = "ipg";
> +			power-domains = <&pd IMX_SC_R_UART_2>;
> +			status = "disabled";
> +		}

Missing semicolon.

> +
> +		adma_lpuart3: serial@5a090000 {
> +			compatible = "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
> +			reg = <0x5a090000 0x1000>;
> +			interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-parent = <&gic>;
> +			clocks = <&adma_lpcg IMX_ADMA_LPCG_UART3_BAUD_CLK>;
> +			clock-names = "ipg";
> +			power-domains = <&pd IMX_SC_R_UART_3>;
> +			status = "disabled";
> +		}

Ditto.

I fixed them up when applying.

Shawn

> +
>  		adma_i2c0: i2c@5a800000 {
>  			compatible = "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
>  			reg = <0x5a800000 0x4000>;
> -- 
> 2.17.1
> 
