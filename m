Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56752C74A21
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 16:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C07520844
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 16:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="BMhYT0+3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="OevQzLcO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbfGJQcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 12:32:22 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42160 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727230AbfGJQcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 12:32:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 17B8A8EE24C;
        Wed, 10 Jul 2019 09:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562776341;
        bh=AsLsb/ooY0lodDgUzHqyget5Lisb7UzWPjict/3/jQA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BMhYT0+3IHb/iITVaNiu4JvvXaO01SJwAb1HVCFbXx0jsbk63nMbOSGGdPwLBh6p2
         zAdLzXyCXC2S3w6F9R63ACiec8IfXue820XLOvbKSbWVkpz0HUnp5H/YaOM1lLAMr0
         abP69dHVdaLJpzeO/Chv1tfxy8qR0QaH71/W6rOE=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xlKxOxUkpX0N; Wed, 10 Jul 2019 09:32:20 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 84AF38EE147;
        Wed, 10 Jul 2019 09:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1562776340;
        bh=AsLsb/ooY0lodDgUzHqyget5Lisb7UzWPjict/3/jQA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OevQzLcO5Fez4jn2lpVqMN71Ys5QjyEdYMweuU9FUcw0ULkoWnEi122Ez52w2+dTU
         uABVyg0VNmIikwjOJb/vayL1ejoz5wFfTQVq7udoDA0byZX/xWCu05QkCKxT71hWP2
         8MeSleAIYpvO2UNIZTtGkne0CHCl0vmJgl35LNHI=
Message-ID: <1562776339.3213.50.camel@HansenPartnership.com>
Subject: Re: screen freeze with 5.2-rc6 Dell XPS-13 skylake  i915
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Paul Bolle <pebolle@tiscali.nl>, intel-gfx@lists.freedesktop.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 10 Jul 2019 09:32:19 -0700
In-Reply-To: <93b8a186f4c8b4dae63845a20bd49ae965893143.camel@tiscali.nl>
References: <1561834612.3071.6.camel@HansenPartnership.com>
         <1562770874.3213.14.camel@HansenPartnership.com>
         <93b8a186f4c8b4dae63845a20bd49ae965893143.camel@tiscali.nl>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-10 at 18:16 +0200, Paul Bolle wrote:
> Hi James,
> 
> James Bottomley schreef op wo 10-07-2019 om 08:01 [-0700]:
> > I've confirmed that 5.1 doesn't have the regression and I'm now
> > trying to bisect the 5.2 merge window, but since the problem takes
> > quite a while to manifest this will take some time.  Any hints
> > about specific patches that might be the problem would be welcome.
> 
> (Perhaps my message of yesterday never reached you.)

No, sorry, if the list is followup to list, I'm not subscribed.  I see
it now I look in the archives, though.

---
> Upgrading to 5.2 (from 5.1.y) on a "Dell XPS 13 9350" (is that a
> skylake too?)

I believe so.  My laptop is a 9350.  I believe they're the earliest
skylake produced. 

>  showed similar symptoms. There's no pattern to the freezes that I
> can see. They're rather frequent too (think every few minutes). Eg,
> two freezes while composing this message!

You seem to be getting it to happen much more often than I can. Last
night, on the below pull request it took me a good hour to see the
freeze.

---
> It seems I hit this problem quite easily. Bisecting v5.1..v5.2 could
> be a real chore, so perhaps we could coordinate efforts (off-list)?

Sure, my current testing indicates it's somewhere inside this pull
request:

Merge: 89c3b37af87e eb85d03e01c3
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed May 8 21:35:19 2019 -0700

    Merge tag 'drm-next-2019-05-09' of git://anongit.freedesktop.org/drm/drm
    
    Pull drm updates from Dave Airlie:

So I was about to test out the i915 changes in that but since my laptop
is what I use for daily work, it's a bit hard (can't freeze up on video
calls for instance).

James

