Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B26C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7CBA218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Gnla2HU3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfLRND4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 08:03:56 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:35372 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfLRND4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 08:03:56 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2691FB23;
        Wed, 18 Dec 2019 14:03:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1576674234;
        bh=kyFycWv/ep3sHlhQaqKtpvighq+LaycJHVfyeOlcXww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gnla2HU3Ub2gF4AYSAgQ+mL+s9ruk/qmL+BnCX5rSEDX5HJojek9/hdknZIEJj/j+
         Ue5NaibnYQm7ik1aa7tVB9iubMhkhSj9s4tlNjESU005Q55iSobpRmKYS1O+cDGrZ+
         ZoYoAc6/MJUCcQMNi90hpnIe+HePzFtU6B1T9d1g=
Date:   Wed, 18 Dec 2019 15:03:43 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel@lists.freedesktop.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/bridge: panel: Fix typo in drm_panel_bridge_add docs
Message-ID: <20191218130343.GB4863@pendragon.ideasonboard.com>
References: <20191218121223.30181-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191218121223.30181-1-enric.balletbo@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

Thank you for the patch.

On Wed, Dec 18, 2019 at 01:12:23PM +0100, Enric Balletbo i Serra wrote:
> Fix the 'manged' typo with 'managed' in the drm_panel_bridge_add
> kernel-doc documentation.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
>  drivers/gpu/drm/bridge/panel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
> index f4e293e7cf64..fcda954bbfec 100644
> --- a/drivers/gpu/drm/bridge/panel.c
> +++ b/drivers/gpu/drm/bridge/panel.c
> @@ -151,7 +151,7 @@ static const struct drm_bridge_funcs panel_bridge_bridge_funcs = {
>   * known type. Calling this function with a panel whose connector type is
>   * DRM_MODE_CONNECTOR_Unknown will return NULL.
>   *
> - * See devm_drm_panel_bridge_add() for an automatically manged version of this
> + * See devm_drm_panel_bridge_add() for an automatically managed version of this
>   * function.
>   */
>  struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel)

-- 
Regards,

Laurent Pinchart
