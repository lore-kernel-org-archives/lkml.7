Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DA1C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 21:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0115520B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 21:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfJJVm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 17:42:26 -0400
Received: from gloria.sntech.de ([185.11.138.130]:34002 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbfJJVm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 17:42:26 -0400
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iIgCU-0007G3-KC; Thu, 10 Oct 2019 23:42:22 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Sean Paul <seanpaul@chromium.org>, devicetree@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: Fix override mode for rk3399-kevin panel
Date:   Thu, 10 Oct 2019 23:42:21 +0200
Message-ID: <29647267.xx61tplHq2@phil>
In-Reply-To: <20191008124949.1.I674acd441997dd0690c86c9003743aacda1cf5dd@changeid>
References: <20191008124949.1.I674acd441997dd0690c86c9003743aacda1cf5dd@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 8. Oktober 2019, 21:49:54 CEST schrieb Douglas Anderson:
> When I re-posted Sean's original commit to add the override mode for
> the kevin panel, for some reason I didn't notice that the pixel clock
> wasn't quite right.  Looking at /sys/kernel/debug/clk/clk_summary on
> downstream kernels it can be seen that the VOP clock is supposed to be
> 266,666,667 Hz achieved by dividing the 800 MHz PLL by 3.
> 
> Looking at history, it seems that even Sean's first patch [1] had this
> funny clock rate.  I'm not sure where it came from since the commit
> message specifically mentioned 26666 kHz and the Chrome OS tree [2]
> can be seen to request 266667 kHz.
> 
> In any case, let's fix it up.  This together with my patch [3] to do
> the proper rounding when setting the clock rate makes the VOP clock
> more proper as seen in /sys/kernel/debug/clk/clk_summary.
> 
> [1] https://lore.kernel.org/r/20180206165626.37692-4-seanpaul@chromium.org
> [2] https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-4.4/drivers/gpu/drm/panel/panel-simple.c#1172
> [3] https://lkml.kernel.org/r/20191003114726.v2.1.Ib233b3e706cf6317858384264d5b0ed35657456e@changeid
> 
> Fixes: 84ebd2da6d04 ("arm64: dts: rockchip: Specify override mode for kevin panel")
> Cc: Sean Paul <seanpaul@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

applied as fix for 5.4

Thanks
Heiko


