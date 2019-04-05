Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1698C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 07:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5F521850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 07:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbfDEHID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 03:08:03 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:46315 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbfDEHIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 03:08:02 -0400
Received: from [192.168.178.52] ([109.104.35.214]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M5wc7-1hIbOz3WJP-007R3U; Fri, 05 Apr 2019 09:07:38 +0200
Subject: Re: [PATCH] dmaengine: bcm2835: Drop duplicate capability setting.
To:     Michal Suchanek <msuchanek@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, dmaengine@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
References: <20190404172503.12155-1-msuchanek@suse.de>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <c03b8f37-6ca7-e259-282a-29e81b81e630@i2se.com>
Date:   Fri, 5 Apr 2019 09:07:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404172503.12155-1-msuchanek@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:IpRkaff885X3fz6PVK67RFyX3GHksklib9rVVsIuIfWA0sG5wkC
 JVjD63eLomWOxdN2C+O3ZfdINYcX9VsjK8+5lN4S132qRY/ov7HxNMttoFIogR3yni8O6p/
 29LVsHiJ7/cazD8eDVaZqqfhpgBWQ2GTcfofrpMKJAOtkpLWZLsX42q/WnlJriT3Fo9ybCC
 X5Op0klhwHJCJgT/8Y+zw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TlgmQtCQNJc=:lVVWkcyMFwgoTFNZhUSZYx
 GZMZUS90/s430Et6z3HAi5cWTxW2pS0t4uLgYBrbDRpBZG1cYDyPZzZub+1eZ4feCXHNeRXsd
 Y0F+mZHy/Iqbez8m1FIBoYIpoqlP5/2nLRHkVxctjpulOt8DXN6h4tiSZv1+Nk69slZBh8X7G
 TqQmzVMgNK1eyymmk//UQnvLhuzWTrkkf+EWFfOSRWFFkEnHkBsIohGju/Vt/JCjQKhTpMhTi
 xw4xdsFqezVQpjZeVCzleoO/7yFjswok9R6CGvTFSyfilWTPKA1+4HTy/D4IhqbdtOlrHjVra
 HuiPaVQtuWFut12nOMzFjJq9AeoerhSP4IhltZJPlOxS27CLXFsprI03zw0GXJOj5GwlWF+Hh
 NjcsOTFDOeEzCewf5Y7Ea2EVpOcJvOeFtJI94M/Hx2YmnNv1lmpuhtcR5UsQX87M+ij+ZPyJE
 2N34BWs2RbMhTV/TtLiE1KOllq176a5j+VzlRAO8WOz1WWuVLMzcdo8u4DnBGCgBSwh1fOg1t
 7p/1pZiCiIjhbugp1zOu4zScGPudI5+lVe7+ktqo94VH9HydpFTJ7jZf7FwJk0oMBI6BpR4Tl
 N092XLTH0baV2gPfOWksj182lzVgk2qLHeO3MB6WmQWcGEvF4rNRbXSrOKbw7EmJ/7w9jxLoj
 JHx+EN56crWp63bYo+bux7CV5TNvbh1iNl3VuqvgzEuhsj+P9qtuYGNRlFyQcWdMLgf+uGWAF
 bZwRZih4QwEE4hYGm7s3TX+5gc/WLZOY+smUN/lPE8vHGfG38gDTwpEUBo4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 04.04.19 um 19:25 schrieb Michal Suchanek:
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

Except of the point there is no commit log:

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

> ---
>  drivers/dma/bcm2835-dma.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
> index ec8a291d62ba..e38b19dd2895 100644
> --- a/drivers/dma/bcm2835-dma.c
> +++ b/drivers/dma/bcm2835-dma.c
> @@ -891,7 +891,6 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
>  	dma_cap_set(DMA_SLAVE, od->ddev.cap_mask);
>  	dma_cap_set(DMA_PRIVATE, od->ddev.cap_mask);
>  	dma_cap_set(DMA_CYCLIC, od->ddev.cap_mask);
> -	dma_cap_set(DMA_SLAVE, od->ddev.cap_mask);
>  	dma_cap_set(DMA_MEMCPY, od->ddev.cap_mask);
>  	od->ddev.device_alloc_chan_resources = bcm2835_dma_alloc_chan_resources;
>  	od->ddev.device_free_chan_resources = bcm2835_dma_free_chan_resources;

