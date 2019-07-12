Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837B2C742D7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 20:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F43420989
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 20:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfGLUPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 16:15:51 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:47113 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfGLUPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 16:15:50 -0400
X-Originating-IP: 90.89.68.76
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 5BEF640002;
        Fri, 12 Jul 2019 20:15:44 +0000 (UTC)
Date:   Fri, 12 Jul 2019 22:15:43 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>, Torsten Duwe <duwe@lst.de>,
        Harald Geyer <harald@ccbib.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Sean Paul <seanpaul@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 7/7] arm64: dts: allwinner: a64: enable ANX6345 bridge
 on Teres-I
Message-ID: <20190712201543.krhsfjepd3cqndla@flea>
References: <20190607094030.GA12373@lst.de>
 <66707fcc-b48e-02d3-5ed7-6b7e77d53266@samsung.com>
 <20190612152022.c3cfhp4cauhzhfyr@flea>
 <bb2c2c00-b46e-1984-088f-861ac8952331@samsung.com>
 <20190701095842.fvganvycce2cy7jn@flea>
 <CA+E=qVdsYV2Bxk245=Myq=otd7-7WHzUnSJN8_1dciAzvSOG8g@mail.gmail.com>
 <20190709085532.cdqv7whuesrjs64c@flea>
 <CA+E=qVdz4vfU3rtTTKjYdM+4UA+=FWheJfWOMaDtFMnWQ1rHbw@mail.gmail.com>
 <20190710114042.ybgavnxb4hgqrtor@flea>
 <CA+E=qVdFoT137pADfxz3uMwhOqjqrA9+6hBeOfbJxuH-M-3Pjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+E=qVdFoT137pADfxz3uMwhOqjqrA9+6hBeOfbJxuH-M-3Pjw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 03:11:04PM -0700, Vasily Khoruzhick wrote:
> On Wed, Jul 10, 2019 at 4:40 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > > > There's another issue: if we introduce edp-connector we'll have to
> > > > > specify power up delays somewhere (in dts? or in platform driver?), so
> > > > > edp-connector doesn't really solve the issue of multiple panels with
> > > > > same motherboard.
> > > >
> > > > And that's what that compatible is about :)
> > >
> > > Sorry, I fail to see how it would be different from using existing
> > > panels infrastructure and different panels compatibles. I think Rob's
> > > idea was to introduce generic edp-connector.
> >
> > Again, there's no such thing as a generic edp-connector. The spec
> > doesn't define anything related to the power sequence for example.
> >
> > > If we can't make it generic then let's use panel infrastructure.
> >
> > Which uses a device specific compatible. Really, I'm not sure what
> > your objection and / or argument is here.
> >
> > In addition, when that was brought up in the discussion, you rejected
> > it because it was inconvenient:
> > https://patchwork.freedesktop.org/patch/283012/?series=56163&rev=1#comment_535206
>
> It is inconvenient, but I don't understand how having board-specific
> connectors fixes it.

How it would not fix it?

You'll have one connector, without the need to describe each and every
panel in the device tree and rely on the EDID instead, and you'll have
the option to power up the regulator you need.

I really don't understand what's the issue here, so let's take a step
back. What are is the issue , what are your requirements, and how
would you like that to be described ?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
