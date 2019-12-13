Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD26AC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8969D2077B
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfLMKfd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 05:35:33 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:35783 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfLMKfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 05:35:33 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id C3164E0007;
        Fri, 13 Dec 2019 10:35:29 +0000 (UTC)
Date:   Fri, 13 Dec 2019 11:35:28 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Kever Yang <kever.yang@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH] MAINTAINERS: rockchip: Track more files
Message-ID: <20191213113528.2e06e1f4@xps13>
In-Reply-To: <3160577.NKkQCOVCmZ@phil>
References: <20191204090710.11646-1-miquel.raynal@bootlin.com>
        <e4dc0f27-6a26-3b29-11fd-231f686fce91@rock-chips.com>
        <3160577.NKkQCOVCmZ@phil>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

Heiko Stuebner <heiko@sntech.de> wrote on Fri, 13 Dec 2019 11:27:29
+0100:

> Am Montag, 9. Dezember 2019, 09:18:00 CET schrieb Kever Yang:
> > Hi Miquel,
> > 
> > On 2019/12/4 下午5:07, Miquel Raynal wrote:  
> > > The current list misses a lot of drivers not prefixed or suffixed by
> > > "rockchip". For instance, there are plenty drivers called rk808 and
> > > rk805 which are currently not tracked (clk, regulator, pinctrl, RTC,
> > > MFD, includes, bindings). Add them to the list under the Rockchip
> > > entry.
> > >
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >
> > > Hi Heiko,
> > >
> > > You are right we should try to check more often your tree. Also, here
> > > is a patch so that you are Cc'ed for all Rockchip related patches
> > > because the current list is not exhaustive at all (not sure it is
> > > voluntary or not though).
> > >
> > > Cheers,
> > > Miquèl
> > >
> > >   MAINTAINERS | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index cba1095547fd..a9564e6cb872 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -2198,12 +2198,16 @@ L:	linux-rockchip@lists.infradead.org
> > >   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git
> > >   S:	Maintained
> > >   F:	Documentation/devicetree/bindings/i2c/i2c-rk3x.txt
> > > +F:	Documentation/devicetree/bindings/*/*rk80*
> > >   F:	arch/arm/boot/dts/rk3*
> > >   F:	arch/arm/boot/dts/rv1108*
> > >   F:	arch/arm/mach-rockchip/
> > > +F:	include/*/*/rk808.h
> > > +F:	include/*/*/*/rk808.h
> > >   F:	drivers/clk/rockchip/
> > >   F:	drivers/i2c/busses/i2c-rk3x.c
> > >   F:	drivers/*/*rockchip*
> > > +F:	drivers/*/*rk80*
> > >   F:	drivers/*/*/*rockchip*
> > >   F:	sound/soc/rockchip/
> > >   N:	rockchip  
> > For the Rockchip PMIC, is it better to have a NEW MAINTAINER entry like 
> > "ROCKCHIP PMIC DRIVER"
> > which share the same mailing list linux-rockchip@, because there is not 
> > only rk808,
> > but also rk805, rk809, rk817, rk818, and may be more to come.
> > 
> > BTW, we should use 'rk8' instead of 'rk80' to match all the Rockchip PMICs.  
> 
> yep, I agree with Kever on this ... also that new pmic-related entry should
> not really link to a git tree as patches for it will get distributed through
> multiple trees (mfd, regulator, rtc) most of the time.

I think it is important that the maintainer receive all Rockchip
related patches, as he has the bigger picture in mind. Of course it is
possible to add an additional MAINTAINER entry for Rockchip PMIC
drivers specifically.

So in the end, I will s/rk80/rk8/, shall I remove a specific entry from
the 4 added?

> 
> Miquel can you do a v2 please?

Of course, this is planned, I'm just a bit late in my e-mail backlog!

Cheers,
Miquèl
