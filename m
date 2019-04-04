Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECD3C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8E6214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbfDDN3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:29:39 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60332 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbfDDN3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:29:38 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 7AE6F8053F; Thu,  4 Apr 2019 15:29:28 +0200 (CEST)
Date:   Thu, 4 Apr 2019 15:21:52 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Rob Herring <robh@kernel.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>
Subject: Re: [PATCH 05/25] dt-bindings: leds: Add function and color
 properties
Message-ID: <20190404132152.GA6124@xo-6d-61-c0.localdomain>
References: <20190310182836.20841-1-jacek.anaszewski@gmail.com>
 <20190310182836.20841-6-jacek.anaszewski@gmail.com>
 <98c1a41e-77bb-5ffd-b5b3-772a28c0f0a6@ti.com>
 <796a13a7-fb8c-9b5b-6bd5-dfb7458731fe@gmail.com>
 <232b6154-cccd-c1f9-80c3-438098f3ab08@gmail.com>
 <20190328002341.GB22901@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190328002341.GB22901@bogus>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > > > > +- function: LED functon. Use one of the LED_FUNCTION_* prefixed
> > > > > definitions
> > > > > +        from the header include/dt-bindings/leds/common.h.
> > > > > +        If there is no matching LED_FUNCTION available, add a new one.
> > > > > +- color : Color of the LED. Use one of the LED_COLOR_NAME_*
> > > > > prefixed definitions
> > > > > +        from the header include/dt-bindings/leds/common.h.
> > > > > +        If there is no matching LED_COLOR_NAME available, add a
> > > > > new one.
> > > > > +
> > > > 
> > > > I am assuming multi color can re-use this property as well?
> > > 
> > > I intended it to be a string, but indeed it would be better if we will
> > > make it an integer to be consistent with the discussed LED multi color
> > > design.
> > 
> > Going further, I wonder if it would make sense to make function also
> > an integer. This way we could enforce use of LED functions known
> > to kernel.
> 
> I think if we did that, then we'd just need to keep label. I think we 
> need to allow for populating a string in DT matching a sticker next to 
> an LED on a device.

Well, there's often icon next to the LED... and we already use "label" for
something else. New property might make sense, but again, icons will make it tricky.

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
