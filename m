Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE7FC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 14:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290622086D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 14:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfF2OJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 10:09:43 -0400
Received: from gloria.sntech.de ([185.11.138.130]:54212 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbfF2OJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 10:09:43 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hhE2n-00029i-Fh; Sat, 29 Jun 2019 16:09:33 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Enric =?ISO-8859-1?Q?Balletb=F2?= <enric.balletbo@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 0/7] drm/panel: simple: Add mode support to devicetree
Date:   Sat, 29 Jun 2019 16:09:32 +0200
Message-ID: <2169143.hEFa8b2HQR@diego>
In-Reply-To: <20190628171342.GA2238@ravnborg.org>
References: <20190401171724.215780-1-dianders@chromium.org> <CAD=FV=Vi2C7s2oWBDD0n+HK=_SuBYhRM9saMK-y6Qa0+k-g17w@mail.gmail.com> <20190628171342.GA2238@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

Am Freitag, 28. Juni 2019, 19:13:42 CEST schrieb Sam Ravnborg:
> Hi Doug.
> 
> > Sam: Oh!  I hadn't noticed that you've been added as a panel
> > maintainer in commit ef0db94f94a0 ("MAINTAINERS: Add Sam as reviewer
> > for drm/panel").  Does that mean you are able to provide some advice
> > for how to land this series?
> Reviewer only, not maintainer....
> 
> It is on my TODO list for the weekend to go through the patch set in
> details and provide feedback. I have read them before, but I miss to do
> a more detailed read through.
> 
> But I cannot apply this unless Thierry or one of the DRM maintainers
> ack it.
> We simply need someone with a better general knowledge of DRM to ack it
> than I have.

So Thierry was able to look at the patches yesterday it seems and has Acked
all the relevant ones. As a drm-misc-contributor I could also apply them
myself, but now don't want to preempt any additional comments you might
have ;-) . So I guess my question would be if you still want to do a review
or if I should apply them.


In any case, I'd like to take the actual dts patches (patches 3+6+7 if
I'm not mistaken) through my tree up to arm-soc after the fact, to
prevent conflicts.

Thanks
Heiko


