Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF42C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71AE1208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbfEUQe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 12:34:28 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:36109 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbfEUQe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 12:34:28 -0400
X-Originating-IP: 90.66.53.80
Received: from localhost (lfbn-1-3034-80.w90-66.abo.wanadoo.fr [90.66.53.80])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 47052E000E;
        Tue, 21 May 2019 16:34:20 +0000 (UTC)
Date:   Tue, 21 May 2019 18:34:20 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] video: fbdev: atmel_lcdfb: add COMPILE_TEST support
Message-ID: <20190521163420.GI3274@piout.net>
References: <CGME20190521105217eucas1p19796d2969c1a568fecb0750818226241@eucas1p1.samsung.com>
 <f9d56fc1-3e02-9716-b764-82e9600e5919@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9d56fc1-3e02-9716-b764-82e9600e5919@samsung.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/2019 12:52:17+0200, Bartlomiej Zolnierkiewicz wrote:
> Add COMPILE_TEST support to atmel_lcdfb driver for better compile
> testing coverage.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
> v2: add missing HAVE_CLK && HAS IOMEM dependencies
> 
>  drivers/video/fbdev/Kconfig |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: b/drivers/video/fbdev/Kconfig
> ===================================================================
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -856,7 +856,8 @@ config FB_S1D13XXX
>  
>  config FB_ATMEL
>  	tristate "AT91 LCD Controller support"
> -	depends on FB && OF && HAVE_FB_ATMEL
> +	depends on FB && OF && HAVE_CLK && HAS_IOMEM
> +	depends on HAVE_FB_ATMEL || COMPILE_TEST
>  	select FB_BACKLIGHT
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
