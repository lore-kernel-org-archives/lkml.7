Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8D3C76195
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CFF2229C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 07:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563781640;
	bh=vEMJsRu+hSQRQqRPW0cmugNwU1SYjS9MxSsBCPTWbnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LMCnImTvoyLQVVEgYUPiBXCajIUs9sJ/ebzTuAN6+eA4oB2TxKqnWgCq3tZHkGZBO
	 a6RJPaAJtFQ0WAyPx9wNsi+Wrlzml/HP/hACagYjIFPB+QAecOGeOnKiUf86mIf4f/
	 zpxtzck46D2JBdlfhOq3xW+x0Y15paB5S0UAsn7k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfGVHrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 03:47:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbfGVHrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 03:47:18 -0400
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36766206DD;
        Mon, 22 Jul 2019 07:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563781637;
        bh=vEMJsRu+hSQRQqRPW0cmugNwU1SYjS9MxSsBCPTWbnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xotim+n+wM0Hu89/V2xWYrX8FUQG201U2Q81aMxSaDsHlXDAQjS61nF+13n6fgG9C
         vTc4UudTpeZEyo7FgRZoOvzI3JdwUB7KuveEJj6kKWRN7cUaGJ6oVUjjmUZENigSDc
         bj31bj8Ili5ODSDRuZnGlw5Vv65YEDW9FXrzD3Cc=
Date:   Mon, 22 Jul 2019 15:46:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Fancy Fang <chen.fang@nxp.com>
Cc:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Jacky Bai <ping.bai@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] clk: imx8mm: rename lcdif pixel clock
Message-ID: <20190722074648.GF3738@dragon>
References: <20190709071942.18109-1-chen.fang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709071942.18109-1-chen.fang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 07:17:56AM +0000, Fancy Fang wrote:
> Rename 'lcdif' pixel clock related names to 'disp' names, since:
> 
> First, the lcdif pixel clock is not supplied to LCDIF controller
> directly, but to some LPCG clock in display mix. So rename it to
> 'disp' pixel clock is more accurate.
> 
> Second, in the imx8mn CCM specification which is designed after
> imx8mm, this same pixel root clock name has been modified from
> 'LCDIF_PIXEL_CLK_ROOT' to 'DISPLAY_PIXEL_CLK_ROOT'.

We should simply name the clock after i.MX8MM reference manual.  What is
the clock name in there?

Shawn

> 
> Signed-off-by: Fancy Fang <chen.fang@nxp.com>
> ---
>  drivers/clk/imx/clk-imx8mm.c             | 4 ++--
>  include/dt-bindings/clock/imx8mm-clock.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
> index 6b8e75df994d..42f1227a4952 100644
> --- a/drivers/clk/imx/clk-imx8mm.c
> +++ b/drivers/clk/imx/clk-imx8mm.c
> @@ -210,7 +210,7 @@ static const char *imx8mm_pcie1_aux_sels[] = {"osc_24m", "sys_pll2_200m", "sys_p
>  static const char *imx8mm_dc_pixel_sels[] = {"osc_24m", "video_pll1_out", "audio_pll2_out", "audio_pll1_out",
>  					     "sys_pll1_800m", "sys_pll2_1000m", "sys_pll3_out", "clk_ext4", };
>  
> -static const char *imx8mm_lcdif_pixel_sels[] = {"osc_24m", "video_pll1_out", "audio_pll2_out", "audio_pll1_out",
> +static const char *imx8mm_disp_pixel_sels[] = {"osc_24m", "video_pll1_out", "audio_pll2_out", "audio_pll1_out",
>  						"sys_pll1_800m", "sys_pll2_1000m", "sys_pll3_out", "clk_ext4", };
>  
>  static const char *imx8mm_sai1_sels[] = {"osc_24m", "audio_pll1_out", "audio_pll2_out", "video_pll1_out",
> @@ -535,7 +535,7 @@ static int __init imx8mm_clocks_init(struct device_node *ccm_node)
>  	clks[IMX8MM_CLK_PCIE1_PHY] = imx8m_clk_composite("pcie1_phy", imx8mm_pcie1_phy_sels, base + 0xa380);
>  	clks[IMX8MM_CLK_PCIE1_AUX] = imx8m_clk_composite("pcie1_aux", imx8mm_pcie1_aux_sels, base + 0xa400);
>  	clks[IMX8MM_CLK_DC_PIXEL] = imx8m_clk_composite("dc_pixel", imx8mm_dc_pixel_sels, base + 0xa480);
> -	clks[IMX8MM_CLK_LCDIF_PIXEL] = imx8m_clk_composite("lcdif_pixel", imx8mm_lcdif_pixel_sels, base + 0xa500);
> +	clks[IMX8MM_CLK_DISP_PIXEL] = imx8m_clk_composite("disp_pixel", imx8mm_disp_pixel_sels, base + 0xa500);
>  	clks[IMX8MM_CLK_SAI1] = imx8m_clk_composite("sai1", imx8mm_sai1_sels, base + 0xa580);
>  	clks[IMX8MM_CLK_SAI2] = imx8m_clk_composite("sai2", imx8mm_sai2_sels, base + 0xa600);
>  	clks[IMX8MM_CLK_SAI3] = imx8m_clk_composite("sai3", imx8mm_sai3_sels, base + 0xa680);
> diff --git a/include/dt-bindings/clock/imx8mm-clock.h b/include/dt-bindings/clock/imx8mm-clock.h
> index 07e6c686f3ef..91ef77efebd9 100644
> --- a/include/dt-bindings/clock/imx8mm-clock.h
> +++ b/include/dt-bindings/clock/imx8mm-clock.h
> @@ -119,7 +119,7 @@
>  #define IMX8MM_CLK_PCIE1_PHY			104
>  #define IMX8MM_CLK_PCIE1_AUX			105
>  #define IMX8MM_CLK_DC_PIXEL			106
> -#define IMX8MM_CLK_LCDIF_PIXEL			107
> +#define IMX8MM_CLK_DISP_PIXEL			107
>  #define IMX8MM_CLK_SAI1				108
>  #define IMX8MM_CLK_SAI2				109
>  #define IMX8MM_CLK_SAI3				110
> -- 
> 2.17.1
> 
