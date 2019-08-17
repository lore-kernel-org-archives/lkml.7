Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057C2C3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 14:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D689B21744
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 14:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbfHQOzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 10:55:22 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:53422 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfHQOzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 10:55:21 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id A89712001F;
        Sat, 17 Aug 2019 16:55:17 +0200 (CEST)
Date:   Sat, 17 Aug 2019 16:55:16 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Colin King <colin.king@canonical.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH][drm-next] drm/panel: remove redundant assignment to val
Message-ID: <20190817145516.GA11584@ravnborg.org>
References: <20190817122124.29650-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190817122124.29650-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=DfNHnWVPAAAA:8
        a=SIPzu5pdF0Keq8NkGp0A:9 a=CjuIK1q_8ugA:10 a=rjTVMONInIDnV1a_A2c_:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2019 at 01:21:24PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable val is initialized to a value in a for-loop that is
> never read and hence it is redundant. Remove it.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks. Applied and pushed to drm-misc-next.

	Sam

> ---
>  drivers/gpu/drm/panel/panel-tpo-td043mtea1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c b/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c
> index 3b4f30c0fdae..84370562910f 100644
> --- a/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c
> +++ b/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c
> @@ -116,7 +116,7 @@ static void td043mtea1_write_gamma(struct td043mtea1_panel *lcd)
>  	td043mtea1_write(lcd, 0x13, val);
>  
>  	/* gamma bits [7:0] */
> -	for (val = i = 0; i < 12; i++)
> +	for (i = 0; i < 12; i++)
>  		td043mtea1_write(lcd, 0x14 + i, gamma[i] & 0xff);
>  }
>  
> -- 
> 2.20.1
