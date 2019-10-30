Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA0DCA9EC0
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 09:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF8E205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 09:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfJ3JPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 05:15:31 -0400
Received: from gloria.sntech.de ([185.11.138.130]:54468 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfJ3JPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 05:15:31 -0400
Received: from [91.217.168.176] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iPk42-00079b-Tm; Wed, 30 Oct 2019 10:14:50 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     Cheng-Yi Chiang <cychiang@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Douglas Anderson <dianders@chromium.org>, dgreid@chromium.org,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        ALSA development <alsa-devel@alsa-project.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v9 5/6] ARM: dts: rockchip: Add HDMI support to rk3288-veyron-analog-audio
Date:   Wed, 30 Oct 2019 10:14:49 +0100
Message-ID: <9095671.y4VLy4llMG@phil>
In-Reply-To: <CA+Px+wXAo5EPjudneS+aFEAfBRAQR1Xp6goutdMdYTPeKcfTTA@mail.gmail.com>
References: <20191028071930.145899-1-cychiang@chromium.org> <20191028071930.145899-6-cychiang@chromium.org> <CA+Px+wXAo5EPjudneS+aFEAfBRAQR1Xp6goutdMdYTPeKcfTTA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Mittwoch, 30. Oktober 2019, 10:09:46 CET schrieb Tzung-Bi Shih:
> This series has 6 patches.  We noticed you have merged the first 4
> patches (includes the DT binding one:
> https://mailman.alsa-project.org/pipermail/alsa-devel/2019-October/157668.html).
> 
> There are 2 DTS patches are still on the list:
> - [PATCH v9 5/6] ARM: dts: rockchip: Add HDMI support to
> rk3288-veyron-analog-audio
> https://mailman.alsa-project.org/pipermail/alsa-devel/2019-October/157499.html
> - [PATCH v9 6/6] ARM: dts: rockchip: Add HDMI audio support to
> rk3288-veyron-mickey.dts
> https://mailman.alsa-project.org/pipermail/alsa-devel/2019-October/157500.html
> 
> Are you waiting for other maintainers' acknowledgement?  Or do we need
> to resend them with maybe some modifications?

nope all good like it is, ideally driver-changes (including the binding)
and the devicetree-changes itself go through my tree in this case, as
otherwise we would often run into conflicts if dts change go through
vastly different maintainer trees.

Of course dts changes can only get applied after the driver side is happy,
so I'll be picking up these 2 changes (hopefully shortly)


Heiko



