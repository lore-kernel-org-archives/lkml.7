Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF65C31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 15:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC382063F
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 15:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfFPPuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 11:50:08 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50375 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfFPPuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 11:50:07 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 0A0AC801F6; Sun, 16 Jun 2019 17:49:54 +0200 (CEST)
Date:   Sun, 16 Jun 2019 17:49:34 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Alexander Dahl <ada@thorsis.com>
Cc:     linux-leds@vger.kernel.org, Dan Murphy <dmurphy@ti.com>,
        jacek.anaszewski@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/9] Multicolor Framework update
Message-ID: <20190616154934.GC24837@xo-6d-61-c0.localdomain>
References: <20190523190820.29375-1-dmurphy@ti.com>
 <55737098.K72IVJ5cDM@ada>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55737098.K72IVJ5cDM@ada>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Am Donnerstag, 23. Mai 2019, 14:08:11 CEST schrieb Dan Murphy:
> >   leds: multicolor: Add sysfs interface definition
> >   dt: bindings: Add multicolor class dt bindings documention
> >   documention: leds: Add multicolor class documentation
> >   dt-bindings: leds: Add multicolor ID to the color ID  list
> >   leds: Add multicolor ID to the color ID list
> >   leds: multicolor: Introduce a multicolor class definition
> >   dt: bindings: lp50xx: Introduce the lp50xx family of RGB drivers
> >   leds: lp50xx: Add the LP50XX family of the RGB LED driver
> >   leds: Update the lp55xx to use the multi color framework
> 
> While not having much experience with the implementation of the LED subsystem, 
> I've had a short look at those. Curious question: would it be possible to take 
> three gpio-leds and group those together to one multicolor-led? I know at 
> least one board, where things are wired up like this, see e.g. 
> at91-sama5d27_som1_ek.dts

Probably could be done, but is not really a good match. Multicolor was meant for
LEDs with many brightness levels.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
