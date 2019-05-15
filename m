Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A09C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAD3520818
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfEOUEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 16:04:40 -0400
Received: from gloria.sntech.de ([185.11.138.130]:44950 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfEOUEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 16:04:40 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hR08h-0000bv-3f; Wed, 15 May 2019 22:04:35 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Sandy Huang <hjc@rock-chips.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-rockchip@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>, mka@chromium.org,
        Sean Paul <seanpaul@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 2/2] drm/rockchip: dw_hdmi: Handle suspend/resume
Date:   Wed, 15 May 2019 22:04:34 +0200
Message-ID: <16767939.RRcxLiLXmc@diego>
In-Reply-To: <20190502223808.185180-2-dianders@chromium.org>
References: <20190502223808.185180-1-dianders@chromium.org> <20190502223808.185180-2-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 3. Mai 2019, 00:38:08 CEST schrieb Douglas Anderson:
> On Rockchip rk3288-based Chromebooks when you do a suspend/resume
> cycle:
> 
> 1. You lose the ability to detect an HDMI device being plugged in.
> 
> 2. If you're using the i2c bus built in to dw_hdmi then it stops
> working.
> 
> Let's call the core dw-hdmi's suspend/resume functions to restore
> things.
> 
> NOTE: in downstream Chrome OS (based on kernel 3.14) we used the
> "late/early" versions of suspend/resume because we found that the VOP
> was sometimes resuming before dw_hdmi and then calling into us before
> we were fully resumed.  For now I have gone back to the normal
> suspend/resume because I can't reproduce the problems.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



