Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1D7C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 19:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD61021882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 19:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfGCT6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 15:58:04 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:35269 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbfGCT6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 15:58:04 -0400
X-Originating-IP: 90.89.68.76
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 742B8240004;
        Wed,  3 Jul 2019 19:57:58 +0000 (UTC)
Date:   Wed, 3 Jul 2019 17:30:56 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Subject: Re: [PATCH 01/25] arm64: dts: allwinner: Switch A64 dts(i) to use
 SPDX identifier
Message-ID: <20190703153056.jhks4yb4ag56rrx5@flea>
References: <20190703124609.21435-1-jagan@amarulasolutions.com>
 <20190703124609.21435-2-jagan@amarulasolutions.com>
 <20190703132838.nhewz5wzsijl65s5@flea>
 <CAMty3ZDyx_RSkU=OndsvzS5reOzab0DBkrarSeHt+-gtsdyKuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMty3ZDyx_RSkU=OndsvzS5reOzab0DBkrarSeHt+-gtsdyKuQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 07:52:27PM +0530, Jagan Teki wrote:
> On Wed, Jul 3, 2019 at 6:58 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Wed, Jul 03, 2019 at 06:15:45PM +0530, Jagan Teki wrote:
> > > Adopt the SPDX license identifier headers to ease license
> > > compliance management on Allwinner A64 dts(i) files.
> > >
> > > While the text specifies "of the GPL or the X11 license"
> > > but the actual license text matches the MIT license as
> > > specified at [0]
> > >
> > > [0] https://spdx.org/licenses/MIT.html
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > >  .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 39 +------------------
> > >  .../dts/allwinner/sun50i-a64-nanopi-a64.dts   | 39 +------------------
> > >  .../dts/allwinner/sun50i-a64-olinuxino.dts    | 39 +------------------
> > >  .../dts/allwinner/sun50i-a64-orangepi-win.dts | 39 +------------------
> > >  .../dts/allwinner/sun50i-a64-pine64-plus.dts  | 39 +------------------
> > >  .../boot/dts/allwinner/sun50i-a64-pine64.dts  | 39 +------------------
> > >  .../allwinner/sun50i-a64-sopine-baseboard.dts | 39 +------------------
> > >  .../boot/dts/allwinner/sun50i-a64-sopine.dtsi | 39 +------------------
> > >  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 39 +------------------
> > >  9 files changed, 9 insertions(+), 342 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> > > index 208373efee49..efdd84c362b0 100644
> > > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> > > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> > > @@ -1,43 +1,6 @@
> > > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> >
> > You say that this is a GPL2 only license
> >
> > >  /*
> > >   * Copyright (c) 2016 ARM Ltd.
> > > - *
> > > - * This file is dual-licensed: you can use it either under the terms
> > > - * of the GPL or the X11 license, at your option. Note that this dual
> > > - * licensing only applies to this file, and not this project as a
> > > - * whole.
> > > - *
> > > - *  a) This library is free software; you can redistribute it and/or
> > > - *     modify it under the terms of the GNU General Public License as
> > > - *     published by the Free Software Foundation; either version 2 of the
> > > - *     License, or (at your option) any later version.
> >
> > While this is GPL2 or later.
>
> Yes, this is where I was confused with compared to existing
> architectures. It seems like it is a call from author of the file or
> make GPL-2.0 for generic purpose [1], not really sure.

What are you confused about? This is GPL2 or later, and it shouldn't
really be changed (unless we have the consent of all the contributors
of all the DTs, but that's a can of worm I don't want to reopen).

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
