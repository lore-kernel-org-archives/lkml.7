Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A57C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C552064A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="Q+xzq109"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfF1OnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 10:43:06 -0400
Received: from node.akkea.ca ([192.155.83.177]:50224 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbfF1OnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 10:43:05 -0400
Received: by node.akkea.ca (Postfix, from userid 33)
        id 7298A4E204B; Fri, 28 Jun 2019 14:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1561732985; bh=1J+88cDkQYmjFNN7dYPO1sEt46KjdzHoKASn60xcMgM=;
        h=To:Subject:Date:From:Cc:In-Reply-To:References;
        b=Q+xzq109+3E6O8FugUx4bb9RjMArxdxHonnZRqtFmv3kNDPin90nQEGywk4aV5765
         YMAoWl/uplP0dMGX6vlCtGu+6R4S3CMslXFqgdNBxm438OHnmLmSX8HlBp9TnE2kBm
         AzAWgfCOBvNx9sCOwTEPw/QCvM76E3MCPuxtFTHk=
To:     =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mq: Add MIPI D-PHY
X-PHP-Originating-Script: 1000:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 28 Jun 2019 08:43:05 -0600
From:   Angus Ainslie <angus@akkea.ca>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pavel Machek <pavel@ucw.cz>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Carlo Caione <ccaione@baylibre.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <613eef8ee6fd427a2fb5eb91865e71f3ee6bded6.1561451144.git.agx@sigxcpu.org>
References: <cover.1561451144.git.agx@sigxcpu.org>
 <613eef8ee6fd427a2fb5eb91865e71f3ee6bded6.1561451144.git.agx@sigxcpu.org>
Message-ID: <dd48a5d849c8ddffa3c980a22777833f@www.akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-06-25 02:27, Guido Günther wrote:
> Add a node for the Mixel MIPI D-PHY, "disabled" by default.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>

Acked-by: Angus Ainslie (Purism) <angus@akkea.ca>

> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index d09b808eff87..891ee7578c2d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -728,6 +728,19 @@
>  				status = "disabled";
>  			};
> 
> +			dphy: dphy@30a00300 {
> +				compatible = "fsl,imx8mq-mipi-dphy";
> +				reg = <0x30a00300 0x100>;
> +				clocks = <&clk IMX8MQ_CLK_DSI_PHY_REF>;
> +				clock-names = "phy_ref";
> +				assigned-clocks = <&clk IMX8MQ_CLK_DSI_PHY_REF>;
> +				assigned-clock-parents = <&clk IMX8MQ_VIDEO_PLL1_OUT>;
> +				assigned-clock-rates = <24000000>;
> +				#phy-cells = <0>;
> +				power-domains = <&pgc_mipi>;
> +				status = "disabled";
> +			};
> +
>  			i2c1: i2c@30a20000 {
>  				compatible = "fsl,imx8mq-i2c", "fsl,imx21-i2c";
>  				reg = <0x30a20000 0x10000>;

