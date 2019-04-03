Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FD8C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF54320882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfDCSc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:32:29 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:53815 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfDCSc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 14:32:29 -0400
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id AA68D20005;
        Wed,  3 Apr 2019 18:32:26 +0000 (UTC)
Date:   Wed, 3 Apr 2019 20:32:24 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Joe Perches <joe@perches.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] ARM: dts: sama5d{2,4}: use SPDX-License-Identifier
Message-ID: <20190403183224.GT22216@piout.net>
References: <20190403162206.15794-1-alexandre.belloni@bootlin.com>
 <8e1f0d1c009e95bc378c8834ac75029b59b7cba9.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e1f0d1c009e95bc378c8834ac75029b59b7cba9.camel@perches.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2019 10:08:52-0700, Joe Perches wrote:
> On Wed, 2019-04-03 at 18:22 +0200, Alexandre Belloni wrote:
> > The X11 license text [1] is explicitly for the X Consortium and has a
> > couple of extra clauses. The MIT license text [2] is actually what the
> > current DT files claim.
> []
> > diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> []
> > @@ -1,46 +1,9 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> 
> Nope - NAK...
> 
> That's not the correct identifier.
> It's not GPL-2.0, it's either GPL-2.0+ or GPL-2.0-or-later
> 
> Check this for all submitted patches in this series.
> 

Ah, correct, I carefully checked the X11/MIT thingy but not the GPL,
I'll recheck. Thanks for catching that.

> >  /*
> >   * sama5d2.dtsi - Device Tree Include file for SAMA5D2 family SoC
> >   *
> >   *  Copyright (C) 2015 Atmel,
> >   *                2015 Ludovic Desroches <ludovic.desroches@atmel.com>
> > - *
> > - * This file is dual-licensed: you can use it either under the terms
> > - * of the GPL or the X11 license, at your option. Note that this dual
> > - * licensing only applies to this file, and not this project as a
> > - * whole.
> > - *
> > - *  a) This file is free software; you can redistribute it and/or
> > - *     modify it under the terms of the GNU General Public License as
> > - *     published by the Free Software Foundation; either version 2 of the
> > - *     License, or (at your option) any later version.
> > 
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
