Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F81CA9ED2
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 07:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20E8222C5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 07:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572852819;
	bh=+D8VoXTzQPyAV6DM35IIJdbQigog+kzxRKbryuCUPKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Y6/kHJAA5SZRQlpVUi7oxgBEV5EI+/1e/HbtA8FDY/U2G+PQB8xQu75IYtNJdSwci
	 yHXnw+JOSWeyyayxV3/901XxuQS/gSWQsM8nCmUrDJQNARCXj4JSDP6IcA44F7H3u5
	 D7Dd0zZBpNImyJLxmA22hM7nn1BRobVD9Nq/Z7Yo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfKDHdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 02:33:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:48904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfKDHdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 02:33:37 -0500
Received: from dragon (li1038-30.members.linode.com [45.33.96.30])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03CF621D71;
        Mon,  4 Nov 2019 07:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572852816;
        bh=+D8VoXTzQPyAV6DM35IIJdbQigog+kzxRKbryuCUPKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qBz+rtNtyUb+3kL84/rMzmNNB/C/fv9RdHhxwqzqbUCCQUYNYG1IKtem/MIrdarGF
         sFXbnaoOTVPDixbPvGuJfBqdMPWSwrDx5kXIJ5q+vgEwcbojbW8iPX286X096/We8Y
         CB+/ipxSOcU3qhuuJiKzzJu8xBTzDTbObW+uhmow=
Date:   Mon, 4 Nov 2019 15:33:11 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 08/11] ARM: dts: imx6ul-kontron-n6x1x-s: Remove an
 obsolete comment and fix indentation
Message-ID: <20191104073310.GS24620@dragon>
References: <20191031142112.12431-1-frieder.schrempf@kontron.de>
 <20191031142112.12431-9-frieder.schrempf@kontron.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031142112.12431-9-frieder.schrempf@kontron.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 02:24:24PM +0000, Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> The ECSPI1 is not used for a FRAM chip, so remove the comment.
> While at it, also change some whitespaces to tabs to comply with the
> indentation style of the rest of the file.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
> Fixes: 1ea4b76cdfde ("ARM: dts: imx6ul-kontron-n6310: Add Kontron i.MX6UL N6310 SoM and boards")

It's not a bug fix.

Shawn

> ---
>  arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi b/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi
> index d3eb21aa9014..e18a8bd239be 100644
> --- a/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi
> +++ b/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi
> @@ -256,7 +256,6 @@
>  		>;
>  	};
>  
> -	/* FRAM */
>  	pinctrl_ecspi1: ecspi1grp {
>  		fsl,pins = <
>  			MX6UL_PAD_CSI_DATA07__ECSPI1_MISO	0x100b1
> @@ -281,8 +280,8 @@
>  
>  	pinctrl_enet2_mdio: enet2mdiogrp {
>  		fsl,pins = <
> -			MX6UL_PAD_GPIO1_IO07__ENET2_MDC         0x1b0b0
> -			MX6UL_PAD_GPIO1_IO06__ENET2_MDIO        0x1b0b0
> +			MX6UL_PAD_GPIO1_IO07__ENET2_MDC		0x1b0b0
> +			MX6UL_PAD_GPIO1_IO06__ENET2_MDIO	0x1b0b0
>  		>;
>  	};
>  
> @@ -295,10 +294,10 @@
>  
>  	pinctrl_gpio: gpiogrp {
>  		fsl,pins = <
> -			MX6UL_PAD_SNVS_TAMPER5__GPIO5_IO05	0x1b0b0 /* DOUT1 */
> -			MX6UL_PAD_SNVS_TAMPER4__GPIO5_IO04	0x1b0b0 /* DIN1 */
> -			MX6UL_PAD_SNVS_TAMPER1__GPIO5_IO01	0x1b0b0 /* DOUT2 */
> -			MX6UL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x1b0b0 /* DIN2 */
> +			MX6UL_PAD_SNVS_TAMPER5__GPIO5_IO05	0x1b0b0	/* DOUT1 */
> +			MX6UL_PAD_SNVS_TAMPER4__GPIO5_IO04	0x1b0b0	/* DIN1 */
> +			MX6UL_PAD_SNVS_TAMPER1__GPIO5_IO01	0x1b0b0	/* DOUT2 */
> +			MX6UL_PAD_SNVS_TAMPER0__GPIO5_IO00	0x1b0b0	/* DIN2 */
>  		>;
>  	};
>  
> -- 
> 2.17.1
