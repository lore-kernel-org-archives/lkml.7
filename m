Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9E7C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 11:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091E920665
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 11:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfK0LZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 06:25:40 -0500
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:41683 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbfK0LZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 06:25:39 -0500
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id CFD583C0579;
        Wed, 27 Nov 2019 12:25:36 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id n11AOOZ_Mvdq; Wed, 27 Nov 2019 12:25:31 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id D50FC3C00BE;
        Wed, 27 Nov 2019 12:25:31 +0100 (CET)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Wed, 27 Nov
 2019 12:25:31 +0100
Date:   Wed, 27 Nov 2019 12:25:28 +0100
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] checkpatch: whitelist Originally-by: signature
Message-ID: <20191127112445.GA21836@vmlxhi-102.adit-jv.com>
References: <20191115150202.15208-1-erosca@de.adit-jv.com>
 <05ba4e29fb78885cf9abf7bfc87e0a7bcda099fe.camel@perches.com>
 <20191115154627.GA2187@lxhi-065.adit-jv.com>
 <20191115092943.7c79f81e@lwn.net>
 <20191115172141.GA3085@lxhi-065.adit-jv.com>
 <CAMuHMdUhPV2B4dpgpPogpFQPprX-VOCC5RuwLLv3MiHzp-pq3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUhPV2B4dpgpPogpFQPprX-VOCC5RuwLLv3MiHzp-pq3Q@mail.gmail.com>
User-Agent: Mutt/1.12.1+40 (7f8642d4ee82) (2019-06-28)
X-Originating-IP: [10.72.93.184]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Wed, Nov 27, 2019 at 10:25:29AM +0100, Geert Uytterhoeven wrote:
[..]
> On Fri, Nov 15, 2019 at 6:24 PM Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
[..]
> > I will give a real-life example. Say, I have some patches in my
> > local tree and they've been developed by somebody who is no longer
> > interested/paid to upstream those.
> >
> > I first submit those patches with the original authorship, plus my SoB.
> > Then, the reviewers post their findings. I put my time into fixing those
> > and re-testing the patch or the entire series. The final patch/series
> > may look totally different compared to the original one.
> >
> > Which way would you suggest to give credits to the original author?
> > I personally think that "Co-developed-by:" conveys the idea/feeling of
> > "teaming up" with somebody, which doesn't happen in my example.
> 
> What I typically do is this:
>   1. If the changes due to review are minor, I just add my SoB below the
>      original SoB,
>   2. If the changes are not insignificant, I also add a line "[geert: Did foo]"
>      in between the original SoB and mine,
>   3. If the patch needed a complete rewrite, I assume ownership, and add
>      "Based on/inspired by ..." to the patch description to give credit.
> 
> Hope this helps (and is acceptable for other people ;-)

Thank you for your time to share the best practices from the heart of
Linux kernel community. This looks like a reasonable blueprint to follow
and I will personally bookmark and quote it whenever appropriate.

The way I see "Originally-by" is that it attempts to replace the free
wording implied at #3 (i.e. patch rewrite case) and hence its benefit.

The less words I have to creatively write by myself, the less errors
I'll make, the less ambiguous my patch will be, the more time I'll have
to dedicate to the important parts of the patch description (feature
overview, bug reproduction, test scenario, etc).

I also understand the desire not to make the process more complicated
than it needs to be. I expect the signature to still pop up here and
there and whether it makes sense to whitelist it, time will tell.

-- 
Best Regards,
Eugeniu
