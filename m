Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81E0C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7864520830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 14:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfDCOm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 10:42:57 -0400
Received: from mailoutvs11.siol.net ([185.57.226.202]:41349 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726151AbfDCOm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 10:42:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 9DD64522607;
        Wed,  3 Apr 2019 16:42:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 2mcf2bfoh02e; Wed,  3 Apr 2019 16:42:48 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 4FB225226A7;
        Wed,  3 Apr 2019 16:42:48 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe-86-58-52-202.static.triera.net [86.58.52.202])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id D0198522607;
        Wed,  3 Apr 2019 16:42:47 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] clk: sunxi-ng: h6: Allow video & vpu clocks to change parent rate
Date:   Wed, 03 Apr 2019 16:42:47 +0200
Message-ID: <2186906.YMnZ6ufn7o@jernej-laptop>
In-Reply-To: <CAGb2v67dDAun7rnvOEFzGiqY-xpxRm=oe99ktq_+MORxp0Wteg@mail.gmail.com>
References: <20190402210623.14988-1-jernej.skrabec@siol.net> <20190403075430.4j7sw5vxqop6ptkj@flea> <CAGb2v67dDAun7rnvOEFzGiqY-xpxRm=oe99ktq_+MORxp0Wteg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 03. april 2019 ob 15:22:52 CEST je Chen-Yu Tsai napisal(a):
> On Wed, Apr 3, 2019 at 3:54 PM Maxime Ripard <maxime.ripard@bootlin.com> 
wrote:
> > On Tue, Apr 02, 2019 at 11:06:23PM +0200, Jernej Skrabec wrote:
> > > Video related clocks need to set rate as close as possible to the
> > > requested one, so they should be able to change parent clock rate.
> > > 
> > > VPU clock sometimes has to be set to higher than default parent clock
> > > rate. This is requ
> 
> The commit log looks unfinished. Can you and Jernej fix this up?

Ah, sorry. I will send v2 with this commit message fixed and additional patch 
as requested by Maxime.

Best regards,
Jernej

> 
> > > Add CLK_SET_RATE_PARENT flag to tcon-lcd0, tcon-tv0 and ve.
> > > 
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > 
> > Applied, thanks!
> > Maxime
> > 
> > --
> > Maxime Ripard, Bootlin
> > Embedded Linux and Kernel engineering
> > https://bootlin.com




