Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90549ECE58F
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 13:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5C32064B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 13:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bt7WIdiU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbfJONEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 09:04:53 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:55192 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbfJONEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 09:04:53 -0400
Received: from [192.168.0.20] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1A42B324;
        Tue, 15 Oct 2019 15:04:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1571144691;
        bh=ImVQfwXpK2+yZayUnOEJztLA7Et2bLnw2dxEra8Ts1A=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bt7WIdiURvECjFCmmgBPoCT2Wju/m6oOj35+k2aHqB6gcElOeetbp6UEEPc6WPddx
         ASxW1PdiJCOXdFFX5VViPY5m5DlI1fiJq1xhgos+z+q9/Oe5V8vL0PSl0Q35W+/b0y
         F4CuWUB4+S49Q36Pn4Gjs9O/5vr3LGXjBwFZj2Rs=
Reply-To: kieran.bingham+renesas@ideasonboard.com
Subject: Re: [PATCH v5 8/8] drm: rcar-du: kms: Expand comment in vsps parsing
 routine
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        laurent.pinchart@ideasonboard.com, geert@linux-m68k.org,
        horms@verge.net.au, uli+renesas@fpond.eu,
        VenkataRajesh.Kalakodima@in.bosch.com
Cc:     airlied@linux.ie, daniel@ffwll.ch, koji.matsuoka.xm@renesas.com,
        muroya@ksk.co.jp, Harsha.ManjulaMallikarjun@in.bosch.com,
        ezequiel@collabora.com, seanpaul@chromium.org,
        linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20191015104621.62514-1-jacopo+renesas@jmondi.org>
 <20191015104621.62514-9-jacopo+renesas@jmondi.org>
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Organization: Ideas on Board
Message-ID: <76efb926-7315-cd29-0a49-9284bc1bd5e6@ideasonboard.com>
Date:   Tue, 15 Oct 2019 14:04:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191015104621.62514-9-jacopo+renesas@jmondi.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On 15/10/2019 11:46, Jacopo Mondi wrote:
> Expand comment in the 'vsps' parsing routine to specify the LIF
> channel index defaults to 0 in case the second cell of the property
> is not specified to remain compatible with older DT bindings.

Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  drivers/gpu/drm/rcar-du/rcar_du_kms.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> index 7c9fb5860e54..186422ac552b 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> @@ -587,7 +587,11 @@ static int rcar_du_vsps_init(struct rcar_du_device *rcdu)
>  
>  		vsps[j].crtcs_mask |= BIT(i);
>  
> -		/* Store the VSP pointer and pipe index in the CRTC. */
> +		/*
> +		 * Store the VSP pointer and pipe index in the CRTC. If the
> +		 * second cell of the 'vsps' specifier isn't present, default
> +		 * to 0 to remain compatible with older DT bindings.
> +		 */
>  		rcdu->crtcs[i].vsp = &rcdu->vsps[j];
>  		rcdu->crtcs[i].vsp_pipe = cells >= 1 ? args.args[0] : 0;
>  	}
> 

