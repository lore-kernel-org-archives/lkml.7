Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAF2C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 09:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E379E20843
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 09:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfHNJJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 05:09:05 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:53501 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfHNJJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 05:09:01 -0400
Received: from localhost (alyon-656-1-672-152.w92-137.abo.wanadoo.fr [92.137.69.152])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 30601200010;
        Wed, 14 Aug 2019 09:08:58 +0000 (UTC)
Date:   Wed, 14 Aug 2019 11:08:58 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Nicolas.Ferre@microchip.com
Cc:     efremov@linux.com, linux-kernel@vger.kernel.org, joe@perches.com,
        linux-arm-kernel@lists.infradead.org,
        Ludovic.Desroches@microchip.com
Subject: Re: [PATCH] MAINTAINERS: Update path to tcb_clksrc.c
Message-ID: <20190814090858.GF3600@piout.net>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
 <20190813061046.15712-1-efremov@linux.com>
 <efb86032-7547-dbc1-19ac-11dc9aff1521@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efb86032-7547-dbc1-19ac-11dc9aff1521@microchip.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/08/2019 08:11:23+0000, Nicolas Ferre wrote:
> On 13/08/2019 at 08:10, Denis Efremov wrote:
> > Update MAINTAINERS record to reflect the filename change
> > from tcb_clksrc.c to timer-atmel-tcb.c
> > 
> > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> But, while you're at it, I would add another line: see below...
> 
> > Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Fixes: a7aae768166e ("clocksource/drivers/tcb_clksrc: Rename the file for consistency")
> > Signed-off-by: Denis Efremov <efremov@linux.com>
> > ---
> >   MAINTAINERS | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index c9ad38a9414f..3ec8154e4630 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -10637,7 +10637,7 @@ M:	Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> +M:      Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> But Alexandre have to agree, of course.
> 
> >   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> >   S:	Supported
> >   F:	drivers/misc/atmel_tclib.c
> > -F:	drivers/clocksource/tcb_clksrc.c
> > +F:	drivers/clocksource/timer-atmel-tcb.c
> >   
> >   MICROCHIP USBA UDC DRIVER
> >   M:	Cristian Birsan <cristian.birsan@microchip.com>
> 
> We could also remove this entry and mix it with:
> "ARM/Microchip (AT91) SoC support"
> 
> But I prefer to keep it separated like this for various reasons.
> 

I would simply remove this entry because all the files are already
matching the SoC entry (it has N: atmel) and atmel_tclib will go away (I
have a series to do that).

If you want to keep a separate entry, maybe we should then add the
system timer and pit drivers.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
