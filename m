Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781C0C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35DF72082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 16:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="RKLkr5ZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfEPQZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 12:25:58 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:40332 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfEPQZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 12:25:58 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B0A042FD;
        Thu, 16 May 2019 18:25:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1558023955;
        bh=OeMvK4hxpeHY0MVypA/a1HjA/ZZfVlDkOTjFiew+YOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RKLkr5ZExVqS/O7bEpCPtl/7UIg8ZdC4ZJwTdaIQQTQ5iJfZo/E7zoivEpXPnhfl2
         KOXq7uSR36agQKxpbKPo6JXTG7z0zRPUKVwpIxpenOXyHtmi7N4Su3s2wT+lG/cfgV
         6pIGi2zE49bIGHYFyEAO9B63GX3NT/6/RrxSpO+o=
Date:   Thu, 16 May 2019 19:25:39 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Cc:     architt@codeaurora.org, a.hajda@samsung.com, airlied@linux.ie,
        jrdr.linux@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge: Remove duplicate header
Message-ID: <20190516162539.GM14820@pendragon.ideasonboard.com>
References: <5cdd8109.1c69fb81.6e003.b84b@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5cdd8109.1c69fb81.6e003.b84b@mx.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sabyasachi,

Thank you for the patch.

On Thu, May 16, 2019 at 08:55:56PM +0530, Sabyasachi Gupta wrote:
> Remove duplicate header which is included twice
> 
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> v2: rebased the code against drm -next and arranged the headers alphabetically
> 
>  drivers/gpu/drm/bridge/panel.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
> index 38eeaf8..000ba7c 100644
> --- a/drivers/gpu/drm/bridge/panel.c
> +++ b/drivers/gpu/drm/bridge/panel.c
> @@ -9,13 +9,12 @@
>   */
>  
>  #include <drm/drmP.h>
> -#include <drm/drm_panel.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_connector.h>
>  #include <drm/drm_encoder.h>
>  #include <drm/drm_modeset_helper_vtables.h>
> -#include <drm/drm_probe_helper.h>
>  #include <drm/drm_panel.h>
> +#include <drm/drm_probe_helper.h>
>  
>  struct panel_bridge {
>  	struct drm_bridge bridge;

-- 
Regards,

Laurent Pinchart
