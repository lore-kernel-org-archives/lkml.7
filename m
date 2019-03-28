Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80384C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122C82075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="jngjUmHG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfC1Gvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 02:51:47 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:43578 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfC1Gvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 02:51:46 -0400
Received: from pendragon.ideasonboard.com (unknown [38.98.37.142])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 51EAA54D;
        Thu, 28 Mar 2019 07:51:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1553755904;
        bh=01Sm2NYVRZqBwsmUN89AZkJo/enatg0otbOaER6JuJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jngjUmHGi+xwTbv+BOOoAdOR6f9VOQqtP8xhh8GKFU/lyHkaebYoINPZtjhMZlXhT
         aqK036CB+YQzfqWQ1N+C9H5NAttQBydpbzWqxp0RmdVDhjEII3XS5vYe/aXJYNx62O
         wGzsuqDG5T/FUiTOc3aHTxE+2NsqP7KWCA9A5ePI=
Date:   Thu, 28 Mar 2019 08:51:24 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     jagdsh.linux@gmail.com
Cc:     a.hajda@samsung.com, airlied@linux.ie, daniel@ffwll.ch,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH] gpu:drm: Remove duplicate headers
Message-ID: <20190328065124.GB4846@pendragon.ideasonboard.com>
References: <1553721116-37832-1-git-send-email-jagdsh.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1553721116-37832-1-git-send-email-jagdsh.linux@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagadeesh,

Thank you for the patch.

On Thu, Mar 28, 2019 at 02:41:56AM +0530, jagdsh.linux@gmail.com wrote:
> From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
> 
> Remove duplicate headers which are included twice.

Could you, while at it, also sort the existing #include statements
alphabetically ? This should help avoiding similar issues in the future.

> Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
> ---
>  drivers/gpu/drm/bridge/panel.c       | 1 -
>  drivers/gpu/drm/i915/intel_display.c | 7 -------
>  2 files changed, 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
> index 38eeaf8..eb9567d 100644
> --- a/drivers/gpu/drm/bridge/panel.c
> +++ b/drivers/gpu/drm/bridge/panel.c
> @@ -15,7 +15,6 @@
>  #include <drm/drm_encoder.h>
>  #include <drm/drm_modeset_helper_vtables.h>
>  #include <drm/drm_probe_helper.h>
> -#include <drm/drm_panel.h>
>  
>  struct panel_bridge {
>  	struct drm_bridge bridge;
> diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
> index ccb6163..1166342 100644
> --- a/drivers/gpu/drm/i915/intel_display.c
> +++ b/drivers/gpu/drm/i915/intel_display.c
> @@ -51,14 +51,7 @@
>  #include "intel_dsi.h"
>  #include "intel_frontbuffer.h"
>  
> -#include "intel_drv.h"
> -#include "intel_dsi.h"
> -#include "intel_frontbuffer.h"
> -
> -#include "i915_drv.h"
> -#include "i915_gem_clflush.h"
>  #include "i915_reset.h"
> -#include "i915_trace.h"
>  
>  /* Primary plane formats for gen <= 3 */
>  static const u32 i8xx_primary_formats[] = {

-- 
Regards,

Laurent Pinchart
