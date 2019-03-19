Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9CEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908822133D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553005934;
	bh=z79PqI2Xm3jJUWYj8ie8fuE2Nwiyrm790VwkqP6oY28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VpyQ6TUTkIpdmMKPOjUlaUPjEs/Ark3i+Kzz+dbLn3tVGHXLtJNbFLNLTL5dzJ+JU
	 i9FKJjq+RA4T0r/s72iJjL1dw43vOHs7GZLJ88m1Lh2QV/Y0F9pqxWVxXUlUrN7gdF
	 sZfZ7YTa8/c90SmpVKheLLHsUtlq2gKoyNvRTHyc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfCSOcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:32:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727018AbfCSOcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:32:12 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 334492085A;
        Tue, 19 Mar 2019 14:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553005931;
        bh=z79PqI2Xm3jJUWYj8ie8fuE2Nwiyrm790VwkqP6oY28=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qc4ZakmafugOe5+ofvx/zIYJUqZvfFEUhb1bgJw5oFt2bdWe9RIyJvMmm9jVPvTMR
         she+Qx3y8CIZMxqiOkyPXYFR+xd9fRxa0E1jX9+bd4Q7EpmSlpcyqJWKreSArXlh+d
         uWK1dFjeAhE3m0gFJIUnmP9bzBdcaHgq5YKrVo6Y=
Date:   Tue, 19 Mar 2019 22:31:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        Anson Huang <anson.huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "spencercw@gmail.com" <spencercw@gmail.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Subject: Re: [PATCH v6 1/4] arm64: dts: imx8mq: Add SDMA nodes
Message-ID: <20190319143139.GA24315@dragon>
References: <20190308120141.3698-1-daniel.baluta@nxp.com>
 <20190308120141.3698-2-daniel.baluta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308120141.3698-2-daniel.baluta@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 12:02:22PM +0000, Daniel Baluta wrote:
> SDMA1 is part of AIPS-3 region and SDMA2 is part
> of AIPS-1 region.
> 
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Reviewed-by tag should go after your SoB, since that's the sequence of
how they come. 

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> [initial submit in i.MX internal tree]
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> [adaptation for linux-next]

I would see these notes in commit log or even just cover letter.

Shawn

> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 9155bd4784eb..9d48450453fb 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -234,6 +234,17 @@
>  				status = "disabled";
>  			};
>  
> +			sdma2: sdma@302c0000 {
> +				compatible = "fsl,imx8mq-sdma","fsl,imx7d-sdma";
> +				reg = <0x302c0000 0x10000>;
> +				interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MQ_CLK_SDMA2_ROOT>,
> +					 <&clk IMX8MQ_CLK_SDMA2_ROOT>;
> +				clock-names = "ipg", "ahb";
> +				#dma-cells = <3>;
> +				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
> +			};
> +
>  			iomuxc: iomuxc@30330000 {
>  				compatible = "fsl,imx8mq-iomuxc";
>  				reg = <0x30330000 0x10000>;
> @@ -575,6 +586,17 @@
>  				status = "disabled";
>  			};
>  
> +			sdma1: sdma@30bd0000 {
> +				compatible = "fsl, imx8mq-sdma","fsl,imx7d-sdma";
> +				reg = <0x30bd0000 0x10000>;
> +				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clk IMX8MQ_CLK_SDMA1_ROOT>,
> +					 <&clk IMX8MQ_CLK_SDMA1_ROOT>;
> +				clock-names = "ipg", "ahb";
> +				#dma-cells = <3>;
> +				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx7d.bin";
> +			};
> +
>  			fec1: ethernet@30be0000 {
>  				compatible = "fsl,imx8mq-fec", "fsl,imx6sx-fec";
>  				reg = <0x30be0000 0x10000>;
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
