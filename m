Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0EACA9EC2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62D7221721
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 12:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572265073;
	bh=4kjKjQAdwQg+xIOM1RGhfB1fhC3MB3bGym1xpZl9M4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yo3qDzL6KOqxHBko8T6KGTiqjeUdVUqgwNppmcsuYhoeBbbo8RygIQ7/TfngSEDTf
	 F9usuVu6AEY2MeZgMJINRlK1oeht4WbGxigVPrNF6r2ddt+vFYtVZx2KweWwCeufte
	 1EdLi0ilJX1mHB9DIdw2YOUV2lO0pQpe1ICbnVVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388522AbfJ1MRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 08:17:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728329AbfJ1MRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 08:17:52 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9ED0B2086D;
        Mon, 28 Oct 2019 12:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572265071;
        bh=4kjKjQAdwQg+xIOM1RGhfB1fhC3MB3bGym1xpZl9M4A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FYgnslUuZnLlj9KdLcmMiyHNbPvW79emQLvYDof+rYLD9FbSUFOeZOUyJfQvVpzb4
         M71yGtlHpkJJJ7G8XUbBeqh1KNBHfiaRS3T3H6S05hoaETGTkjrdfHAHW6e8oFB3Se
         xrtmTNL7KSHzVqf50nKwWXbQl0q6PNJ1ba5z2Au4=
Date:   Mon, 28 Oct 2019 20:17:26 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, ping.bai@nxp.com, jun.li@nxp.com,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM64: imx8mm: Change compatible string for sdma
Message-ID: <20191028121725.GJ16985@dragon>
References: <1571992763-31339-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571992763-31339-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 04:39:23PM +0800, Shengjiu Wang wrote:
> SDMA in i.MX8MM should use same configuration as i.MX8MQ
> So need to change compatible string to be "fsl,imx8mq-sdma".
> 
> Fixes: a05ea40eb384 ("arm64: dts: imx: Add i.mx8mm dtsi support")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Updated the subject as below and applied the patch.

  arm64: dts: imx8mm: fix compatible string for sdma

Shawn

> ---
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index 2139c0a9c495..6a54d2a3b19b 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -394,7 +394,7 @@
>  			};
>  
>  			sdma2: dma-controller@302c0000 {
> -				compatible = "fsl,imx8mm-sdma", "fsl,imx7d-sdma";
> +				compatible = "fsl,imx8mm-sdma", "fsl,imx8mq-sdma";
>  				reg = <0x302c0000 0x10000>;
>  				interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clk IMX8MM_CLK_SDMA2_ROOT>,
> @@ -405,7 +405,7 @@
>  			};
>  
>  			sdma3: dma-controller@302b0000 {
> -				compatible = "fsl,imx8mm-sdma", "fsl,imx7d-sdma";
> +				compatible = "fsl,imx8mm-sdma", "fsl,imx8mq-sdma";
>  				reg = <0x302b0000 0x10000>;
>  				interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clk IMX8MM_CLK_SDMA3_ROOT>,
> @@ -741,7 +741,7 @@
>  			};
>  
>  			sdma1: dma-controller@30bd0000 {
> -				compatible = "fsl,imx8mm-sdma", "fsl,imx7d-sdma";
> +				compatible = "fsl,imx8mm-sdma", "fsl,imx8mq-sdma";
>  				reg = <0x30bd0000 0x10000>;
>  				interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clk IMX8MM_CLK_SDMA1_ROOT>,
> -- 
> 2.21.0
> 
