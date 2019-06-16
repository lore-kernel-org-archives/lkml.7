Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753C9C31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 15:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6BE2063F
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 15:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfFPPl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 11:41:57 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50203 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfFPPl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 11:41:56 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 82D3D801F5; Sun, 16 Jun 2019 17:41:43 +0200 (CEST)
Date:   Sun, 16 Jun 2019 17:41:43 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] Revert "ARM: dts: rockchip: set PWM delay backlight
 settings for Minnie"
Message-ID: <20190616154143.GA28583@atrey.karlin.mff.cuni.cz>
References: <20190614224533.169881-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614224533.169881-1-mka@chromium.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This reverts commit 288ceb85b505c19abe1895df068dda5ed20cf482.
> 
> According to the commit message the AUO B101EAN01 panel on minnie
> requires a PWM delay of 200 ms, however this is not what the
> datasheet says. The datasheet mentions a *max* delay of 200 ms
> for T2 ("delay from LCDVDD to black video generation") and T3
> ("delay from LCDVDD to HPD high"), which aren't related to the
> PWM. The backlight power sequence does not specify min/max
> constraints for T15 (time from PWM on to BL enable) or T16
> (time from BL disable to PWM off).
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Enric, if you think I misinterpreted the datasheet please holler!

Was this tested? Was previous patch tested?

Does patch being reverted actually break anything? If so, cc stable?

								Pavel
								
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
