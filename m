Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CF9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 19:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99CF218A3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 19:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbfC2TUH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 15:20:07 -0400
Received: from gloria.sntech.de ([185.11.138.130]:40080 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729483AbfC2TUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 15:20:07 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1h9x2n-0000Qb-6h; Fri, 29 Mar 2019 20:20:01 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Enric =?ISO-8859-1?Q?Balletb=F2?= <enric.balletbo@collabora.com>,
        Rob Herring <robh+dt@kernel.org>, mka@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 6/7] ARM: dts: rockchip: Specify rk3288-veyron-jerry's display timings
Date:   Fri, 29 Mar 2019 20:20:00 +0100
Message-ID: <7960623.ZFqGeXkhir@diego>
In-Reply-To: <20190328171710.31949-7-dianders@chromium.org>
References: <20190328171710.31949-1-dianders@chromium.org> <20190328171710.31949-7-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 28. März 2019, 18:17:09 CET schrieb Douglas Anderson:
> Let's document the display timings that jerry has been using out in
> the field.  This uses the standard blankings but a slightly slower
> clock rate, thus getting a refresh rate 58.3 Hz.
> 
> NOTE: this won't really do anything except cause DRM to properly
> report the refresh rate since vop_crtc_mode_fixup() was rounding the
> pixel clock to 74.25 MHz anyway.  Apparently the adjusted rate isn't
> exposed to userspace so it's important that the rate we're trying to
> achieve is mostly right.
> 
> For the downstream kernel change related to this see See
> https://crrev.com/c/324558.
> 
> NOTE: minnie will be fixed up in a future patch, so for now we'll just
> delete the panel timings there.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> Changes in v4:
> - rk3288-veyron-jerry patch new for v4.
> 
> Changes in v3: None
> Changes in v2: None
> 
>  arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi | 14 ++++++++++++++

hmm, the commit message explicitly mentions jerry, but this is the
general panel definition for most veyron-chromebooks (jerry, pinky, jaq,...)?

It does work on both pinky and jerry for me, so I guess just the commit
message needs a bit adapting?


Heiko


