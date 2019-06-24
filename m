Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7806AC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 508C4205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 15:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbfFXPFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 11:05:45 -0400
Received: from mailoutvs50.siol.net ([185.57.226.241]:44931 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725562AbfFXPFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 11:05:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 07E62522ABF;
        Mon, 24 Jun 2019 17:05:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id xoqTPOpf7QY5; Mon, 24 Jun 2019 17:05:40 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 98D1F522F0B;
        Mon, 24 Jun 2019 17:05:40 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe-86-58-52-202.static.triera.net [86.58.52.202])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id CD736522ABF;
        Mon, 24 Jun 2019 17:05:37 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Jonas Karlman <jonas@kwiboo.se>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "zhengyang@rock-chips.com" <zhengyang@rock-chips.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "wens@csie.org" <wens@csie.org>,
        "hjc@rock-chips.com" <hjc@rock-chips.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] drm/sun4i: Enable DRM InfoFrame support on H6
Date:   Mon, 24 Jun 2019 17:05:37 +0200
Message-ID: <6819050.kFKQ8T6p8H@jernej-laptop>
In-Reply-To: <baf95e6b-bfcf-27e7-1a00-ca877ae6f82d@samsung.com>
References: <VI1PR03MB420621617DDEAB3596700DE0AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com> <VI1PR03MB4206740285A775280063E303AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com> <baf95e6b-bfcf-27e7-1a00-ca877ae6f82d@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 24. junij 2019 ob 17:03:31 CEST je Andrzej Hajda napisal(a):
> On 26.05.2019 23:20, Jonas Karlman wrote:
> > This patch enables Dynamic Range and Mastering InfoFrame on H6.
> > 
> > Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> > Cc: Jernej Skrabec <jernej.skrabec@siol.net>
> > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > ---
> > 
> >  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c | 2 ++
> >  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h | 1 +
> >  2 files changed, 3 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> > b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c index 39d8509d96a0..b80164dd8ad8
> > 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
> > @@ -189,6 +189,7 @@ static int sun8i_dw_hdmi_bind(struct device *dev,
> > struct device *master,> 
> >  	sun8i_hdmi_phy_init(hdmi->phy);
> >  	
> >  	plat_data->mode_valid = hdmi->quirks->mode_valid;
> > 
> > +	plat_data->drm_infoframe = hdmi->quirks->drm_infoframe;
> > 
> >  	sun8i_hdmi_phy_set_ops(hdmi->phy, plat_data);
> >  	
> >  	platform_set_drvdata(pdev, hdmi);
> > 
> > @@ -255,6 +256,7 @@ static const struct sun8i_dw_hdmi_quirks
> > sun8i_a83t_quirks = {> 
> >  static const struct sun8i_dw_hdmi_quirks sun50i_h6_quirks = {
> >  
> >  	.mode_valid = sun8i_dw_hdmi_mode_valid_h6,
> > 
> > +	.drm_infoframe = true,
> > 
> >  };
> >  
> >  static const struct of_device_id sun8i_dw_hdmi_dt_ids[] = {
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> > b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h index 720c5aa8adc1..2a0ec08ee236
> > 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> > +++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h
> > @@ -178,6 +178,7 @@ struct sun8i_dw_hdmi_quirks {
> > 
> >  	enum drm_mode_status (*mode_valid)(struct drm_connector 
*connector,
> >  	
> >  					   const struct 
drm_display_mode *mode);
> >  	
> >  	unsigned int set_rate : 1;
> > 
> > +	unsigned int drm_infoframe : 1;
> 
> Again, drm_infoframe suggests it contains inforframe, but in fact it
> just informs infoframe can be used, so again my suggestion
> use_drm_infoframe.
> 
> Moreover bool type seems more appropriate here.

checkpatch will give warning if bool is used.

Best regards,
Jernej

> 
> Beside this:
> 
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> 
>  --
> Regards
> Andrzej
> 
> >  };
> >  
> >  struct sun8i_dw_hdmi {




