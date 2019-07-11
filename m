Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC8DC742A1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 21:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC83208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 21:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbfGKV1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 17:27:52 -0400
Received: from gloria.sntech.de ([185.11.138.130]:36148 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbfGKV1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 17:27:52 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hlgbR-0006mP-RG; Thu, 11 Jul 2019 23:27:45 +0200
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
Subject: Re: [PATCH v5 6/7] ARM: dts: rockchip: Specify rk3288-veyron-chromebook's display timings
Date:   Thu, 11 Jul 2019 23:27:44 +0200
Message-ID: <4744731.Gbjux09qzx@diego>
In-Reply-To: <20190401171724.215780-7-dianders@chromium.org>
References: <20190401171724.215780-1-dianders@chromium.org> <20190401171724.215780-7-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 1. April 2019, 19:17:23 CEST schrieb Douglas Anderson:
> Let's document the display timings that most veyron chromebooks (like
> jaq, jerry, mighty, speedy) have been using out in the field.  This
> uses the standard blankings but a slightly slower clock rate, thus
> getting a refresh rate 58.3 Hz.
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
> NOTE: minnie uses a different panel will be fixed up in a future
> patch, so for now we'll just delete the panel timings there.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

applied for 5.3

Thanks
Heiko


