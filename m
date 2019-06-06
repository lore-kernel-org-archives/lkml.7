Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42012C28EB4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BADA20693
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 17:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="KWChOf+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbfFFRBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 13:01:08 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:45114 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbfFFRBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 13:01:07 -0400
Received: from pendragon.ideasonboard.com (unknown [IPv6:2a02:a03f:44f0:8500:ca05:8177:199c:fed4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2AD6A33B;
        Thu,  6 Jun 2019 19:01:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1559840466;
        bh=MF218gquzWXC4u+to0JZZATVETWWKvUN/hjgtdzhRHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KWChOf+jAdJEpUYNt3YTObfW+jdZN2XRVZ9iFVcj7KROMxw2+zg4flsuAQ1aU824z
         wjJdJifzSaxyyctcEACpA5AAHcrVbQgO/ApyWcBefBxXs9Whe78SA74Qr/ceH/IGhA
         j0LyGRKn8ssxNtqzQCVgjQSnxTYkPTVTEFR9IFQ4=
Date:   Thu, 6 Jun 2019 20:00:52 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc:     kieran.bingham+renesas@ideasonboard.com, airlied@linux.ie,
        daniel@ffwll.ch, koji.matsuoka.xm@renesas.com, muroya@ksk.co.jp,
        VenkataRajesh.Kalakodima@in.bosch.com,
        Harsha.ManjulaMallikarjun@in.bosch.com,
        linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/20] clk: renesas: r8a77995: Add CMM clocks
Message-ID: <20190606170052.GO12825@pendragon.ideasonboard.com>
References: <20190606142220.1392-1-jacopo+renesas@jmondi.org>
 <20190606142220.1392-9-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190606142220.1392-9-jacopo+renesas@jmondi.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

Thank you for the patch.

On Thu, Jun 06, 2019 at 04:22:08PM +0200, Jacopo Mondi wrote:
> Add clock definitions for CMM units on Renesas R-Car Gen3 D3.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/clk/renesas/r8a77995-cpg-mssr.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/renesas/r8a77995-cpg-mssr.c b/drivers/clk/renesas/r8a77995-cpg-mssr.c
> index eee3874865a9..acd5fabb785a 100644
> --- a/drivers/clk/renesas/r8a77995-cpg-mssr.c
> +++ b/drivers/clk/renesas/r8a77995-cpg-mssr.c
> @@ -146,6 +146,8 @@ static const struct mssr_mod_clk r8a77995_mod_clks[] __initconst = {
>  	DEF_MOD("vspbs",		 627,	R8A77995_CLK_S0D1),
>  	DEF_MOD("ehci0",		 703,	R8A77995_CLK_S3D2),
>  	DEF_MOD("hsusb",		 704,	R8A77995_CLK_S3D2),
> +	DEF_MOD("cmm1",			 710,	R8A77995_CLK_S1D1),
> +	DEF_MOD("cmm0",			 711,	R8A77995_CLK_S1D1),
>  	DEF_MOD("du1",			 723,	R8A77995_CLK_S1D1),
>  	DEF_MOD("du0",			 724,	R8A77995_CLK_S1D1),
>  	DEF_MOD("lvds",			 727,	R8A77995_CLK_S2D1),

-- 
Regards,

Laurent Pinchart
