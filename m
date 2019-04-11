Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9410FC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C5C20663
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfDKT1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 15:27:18 -0400
Received: from gloria.sntech.de ([185.11.138.130]:32924 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726577AbfDKT1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 15:27:18 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hEfLu-0001JR-Kb; Thu, 11 Apr 2019 21:27:14 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Caesar Wang <caesar.wang@rock-chips.com>,
        linux-rockchip@lists.infradead.org, mka@chromium.org,
        ryandcase@chromium.org, Elaine Zhang <zhangqing@rock-chips.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] clk: rockchip: Make rkpwm a critical clock on rk3288
Date:   Thu, 11 Apr 2019 21:27:13 +0200
Message-ID: <4051007.xZozYk3gQ9@diego>
In-Reply-To: <20190409204707.150347-3-dianders@chromium.org>
References: <20190409204707.150347-1-dianders@chromium.org> <20190409204707.150347-3-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 9. April 2019, 22:47:06 CEST schrieb Douglas Anderson:
> Most rk3288-based boards are derived from the EVB and thus use a PWM
> regulator for the logic rail.  However, most rk3288-based boards don't
> specify the PWM regulator in their device tree.  We'll deal with that
> by making it critical.
> 
> NOTE: it's important to make it critical and not just IGNORE_UNUSED
> because all PWMs in the system share the same clock.  We don't want
> another PWM user to turn the clock on and off and kill the logic rail.
> 
> This change is in preparation for actually having the PWMs in the
> rk3288 device tree actually point to the proper PWM clock.  Up until
> now they've all pointed to the clock for the old IP block and they've
> all worked due to the fact that rkpwm was IGNORE_UNUSED and that the
> clock rates for both clocks were the same.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

applied for 5.2
I've added a comment line describing the pwm-reg reason.


Heiko


