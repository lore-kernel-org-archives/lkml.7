Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33E7C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 22:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8226F2133D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 22:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Fx3bSAQA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbfEQWHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 18:07:07 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:54300 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbfEQWHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 18:07:06 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C9DE12F3;
        Sat, 18 May 2019 00:07:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1558130824;
        bh=MnCz2Ojjo7iLxTB+zccLU/er2kvrni3WBKp6QNyIvFo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fx3bSAQAn0WyG3KGbSJnXAVTpccFNfK9JaLK2xaLofZ2rojxQ79vyrJyHAJu0pDSm
         x/OE0HK9I83JblwQoOa9wkClnGMCLES3WmVtBm8cToe4RTFQq+apqAD56t8FZSYvMO
         4cUJVTk+m5zGuzBs2z1rcdt93LoKhpNXuC6M5Zo0=
Date:   Sat, 18 May 2019 01:06:47 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     linux-renesas-soc@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS FOR RENESAS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm: rcar-du: writeback: include interface header
Message-ID: <20190517220647.GA21057@pendragon.ideasonboard.com>
References: <20190517212050.3561-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190517212050.3561-1-kieran.bingham+renesas@ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thank you for the patch.

On Fri, May 17, 2019 at 10:20:49PM +0100, Kieran Bingham wrote:
> The new writeback feature is exports functions so that they can
> integrate into the rcar_du_kms module.
> 
> The interface functions are defined in the rcar_du_writeback header, but
> it is not included in the object file itself leading to compiler
> warnings for missing prototypes.
> 
> Include the header as appropriate.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

And applied to my tree.

> ---
>  drivers/gpu/drm/rcar-du/rcar_du_writeback.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_writeback.c b/drivers/gpu/drm/rcar-du/rcar_du_writeback.c
> index 989a0be94131..ae07290bba6a 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_writeback.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_writeback.c
> @@ -14,6 +14,7 @@
>  #include "rcar_du_crtc.h"
>  #include "rcar_du_drv.h"
>  #include "rcar_du_kms.h"
> +#include "rcar_du_writeback.h"
>  
>  /**
>   * struct rcar_du_wb_conn_state - Driver-specific writeback connector state

-- 
Regards,

Laurent Pinchart
