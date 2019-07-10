Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AD0C74A36
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 17:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A69208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 17:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="okWIQmP9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="okWIQmP9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfGJRfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 13:35:37 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:43278 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726097AbfGJRfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 13:35:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id CE1698EE24C;
        Wed, 10 Jul 2019 10:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562780136;
        bh=B70gAXooxvZK/Lf3HwD7p1V8t+7FlnkHdVRJexmSkFw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=okWIQmP9GmOEZoBgruAKHEKyShJaVoqPbC0/vxxvqvwNL6cXmo1bjWaVEsOZc2GtZ
         dDnwoHAnt2DPX5g+Eoa/v9aScrOrFOppGatpMky2n2yplzfXszVU9wy9swQsUxGQe2
         yi5qacgvwVo31QseTxnEA5fsIinkjskyi8KvVqxM=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HoVGSRes2uiH; Wed, 10 Jul 2019 10:35:36 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 566D48EE147;
        Wed, 10 Jul 2019 10:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562780136;
        bh=B70gAXooxvZK/Lf3HwD7p1V8t+7FlnkHdVRJexmSkFw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=okWIQmP9GmOEZoBgruAKHEKyShJaVoqPbC0/vxxvqvwNL6cXmo1bjWaVEsOZc2GtZ
         dDnwoHAnt2DPX5g+Eoa/v9aScrOrFOppGatpMky2n2yplzfXszVU9wy9swQsUxGQe2
         yi5qacgvwVo31QseTxnEA5fsIinkjskyi8KvVqxM=
Message-ID: <1562780135.3213.58.camel@HansenPartnership.com>
Subject: Re: screen freeze with 5.2-rc6 Dell XPS-13 skylake  i915
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Paul Bolle <pebolle@tiscali.nl>, intel-gfx@lists.freedesktop.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 10 Jul 2019 10:35:35 -0700
In-Reply-To: <5245d2b3d82f11d2f988a3154814eb42dcb835c5.camel@tiscali.nl>
References: <1561834612.3071.6.camel@HansenPartnership.com>
         <1562770874.3213.14.camel@HansenPartnership.com>
         <93b8a186f4c8b4dae63845a20bd49ae965893143.camel@tiscali.nl>
         <1562776339.3213.50.camel@HansenPartnership.com>
         <5245d2b3d82f11d2f988a3154814eb42dcb835c5.camel@tiscali.nl>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-10 at 18:45 +0200, Paul Bolle wrote:
> James Bottomley schreef op wo 10-07-2019 om 09:32 [-0700]:
> > You seem to be getting it to happen much more often than I can.
> > Last
> > night, on the below pull request it took me a good hour to see the
> > freeze.
> 
> Yes. Sometimes within a minute of resuming. Typing stuff into
> evolution seems to help with triggering this. It's all a bit
> mysterious, but this message alone frooze my laptop a few times.
> Seriously!
> 
> > Sure, my current testing indicates it's somewhere inside this pull
> > request:
> > 
> > Merge: 89c3b37af87e eb85d03e01c3
> > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > Date:   Wed May 8 21:35:19 2019 -0700
> > 
> >     Merge tag 'drm-next-2019-05-09' of
> > git://anongit.freedesktop.org/drm/drm
> >     
> >     Pull drm updates from Dave Airlie:
> 
> Lazy question: how does one determine the first and last commit
> inside a merge request? Can I simply do
>     good   a2d635decbfa9c1e4ae15cb05b68b2559f7f827c^
>     bad    a2d635decbfa9c1e4ae15cb05b68b2559f7f827c
> 
> for git bisect?

I think so.  I actually did

	bad	a2d635decbfa9c1e4ae15cb05b68b2559f7f827c
	good	89c3b37af87ec183b666d83428cb28cc421671a6

But I think ^ steps down in the main branch.  Note, I've only done a
couple of hours run on what I think is the good commit ... and actually
I'd already marked a2d635decbfa9c1e4ae15cb05b68b2559f7f827c as good
until the screen froze just after I'd built the new bisect kernel, so
there's still some chance 89c3b37af87ec183b666d83428cb28cc421671a6 is
bad.

> > So I was about to test out the i915 changes in that but since my
> > laptop is what I use for daily work, it's a bit hard (can't freeze
> > up on video calls for instance).
> 
> I usually use one of the ThinkPads from my embarrassing pile of
> outdated hardware to do nasty bisects, but I'm not about to loose any
> income if my much appreciated XPS 13 is out of order for a while.

I can get back to it this afternoon, when I'm done with the meeting
requirements and doing other dev stuff.

James

