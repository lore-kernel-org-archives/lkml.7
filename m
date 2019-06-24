Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB66CC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 11:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00872133F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 11:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="T7DpsKTa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbfFXLbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 07:31:40 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:33774 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfFXLbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 07:31:39 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 54BBD323;
        Mon, 24 Jun 2019 13:31:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1561375898;
        bh=TTMoZ7L0TvwNHbazuq/zwIiZIs9paL/P68Ui7Cjouyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T7DpsKTaR9/3ZvSzOgeS4b4LBK0i6+ZgRoYkX5bXOyfnMgVGltTTwbeRfO5UvHdJq
         +WxmuSTy/Ntp1eSlzg0Rdq0nSpBDb65EAdSVbztbt2xVD/0emnxYtHgwrKngW9SgVO
         A+JWXhl8xhRUcE54OrD9xsC0Z9pII1FxMorvqcDs=
Date:   Mon, 24 Jun 2019 14:31:19 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     a.hajda@samsung.com, daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Jonas Karlman <jonas@kwiboo.se>,
        Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Subject: Re: [PATCH] MAINTAINERS: Update Maintainers and Reviewers of DRM
 Bridge Drivers
Message-ID: <20190624113119.GD5737@pendragon.ideasonboard.com>
References: <20190624090851.17859-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190624090851.17859-1-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

Thank you for the patch.

On Mon, Jun 24, 2019 at 11:08:51AM +0200, Neil Armstrong wrote:
> Add myself as co-maintainer of DRM Bridge Drivers then add Jonas Karlman
> and Jernej Škrabec as Reviewers of DRM Bridge Drivers.
> 
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Jernej Škrabec <jernej.skrabec@siol.net>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2abf6d28db64..dd8dacc61e79 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5253,7 +5253,10 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
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

-- 
Regards,

Laurent Pinchart
