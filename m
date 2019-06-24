Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E80AC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DBFA20657
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 09:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfFXJKU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 05:10:20 -0400
Received: from mailoutvs13.siol.net ([185.57.226.204]:46955 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728019AbfFXJKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 05:10:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id E339B520170;
        Mon, 24 Jun 2019 11:10:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id aD-Bj9AwZRuz; Mon, 24 Jun 2019 11:10:16 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 92D82521D65;
        Mon, 24 Jun 2019 11:10:16 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe-86-58-52-202.static.triera.net [86.58.52.202])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Zimbra) with ESMTPA id 8CD3D520170;
        Mon, 24 Jun 2019 11:10:15 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     laurent.pinchart@ideasonboard.com, a.hajda@samsung.com,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH] MAINTAINERS: Update Maintainers and Reviewers of DRM Bridge Drivers
Date:   Mon, 24 Jun 2019 11:10:15 +0200
Message-ID: <6271310.B3xluj770B@jernej-laptop>
In-Reply-To: <20190624090851.17859-1-narmstrong@baylibre.com>
References: <20190624090851.17859-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 24. junij 2019 ob 11:08:51 CEST je Neil Armstrong napisal(a):
> Add myself as co-maintainer of DRM Bridge Drivers then add Jonas Karlman
> and Jernej Škrabec as Reviewers of DRM Bridge Drivers.
> 
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Jernej Škrabec <jernej.skrabec@siol.net>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>

Thanks!

Best regards,
Jernej

> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2abf6d28db64..dd8dacc61e79 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5253,7 +5253,10 @@ T:	git git://anongit.freedesktop.org/drm/drm-
misc
> 
>  DRM DRIVERS FOR BRIDGE CHIPS
>  M:	Andrzej Hajda <a.hajda@samsung.com>
> +M:	Neil Armstrong <narmstrong@baylibre.com>
>  R:	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> +R:	Jonas Karlman <jonas@kwiboo.se>
> +R:	Jernej Skrabec <jernej.skrabec@siol.net>
>  S:	Maintained
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
>  F:	drivers/gpu/drm/bridge/




