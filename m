Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DD3C33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3900620692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbgAHQq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:46:27 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:53116 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbgAHQq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:46:26 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id A108220034;
        Wed,  8 Jan 2020 17:46:19 +0100 (CET)
Date:   Wed, 8 Jan 2020 17:46:18 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Emil Velikov <emil.velikov@collabora.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/drm_panel: fix export of drm_panel_of_backlight, try
 #3
Message-ID: <20200108164618.GA28588@ravnborg.org>
References: <20200107203231.920256-1-arnd@arndb.de>
 <87zheyqnla.fsf@intel.com>
 <20200108100831.GA23308@ravnborg.org>
 <CAK8P3a1FKOV=1No7Q0g1vF_NQmVHK+g0VOqzPL499Pxbbt1aPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1FKOV=1No7Q0g1vF_NQmVHK+g0VOqzPL499Pxbbt1aPQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=A96CT9EkDcBwBZB6U8IA:9 a=CjuIK1q_8ugA:10 a=Z5ABNNGmrOfJ6cZ5bIyy:22
        a=bWyr8ysk75zN3GCy5bjg:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd.

> > > All of this is just another hack until the backlight config usage is
> > > fixed for good. Do we really want to make this the example to copy paste
> > > wherever we hit the issue next?
> > >
> > > I'm not naking, but I'm not acking either.
> >
> > I will try to take a look at your old BACKLIGHT_CLASS_DEVICE patch this
> > weekend. I think we need that one fixed - and then we can have this mess
> > with "drm_panel_of_backlight" fixed in the right way.
> 
> I had also attempted to fix the larger mess around 'select' statements in DRM/FB
> around BACKLIGHT_CLASS_DEVICE  several times in the past, and even at
> some point sent a patch that was acked but never merged and later broke because
> of other changes.

Any chance you have the patch around or can dig up a pointer?
My google foo did not turn up anything.

	Sam
