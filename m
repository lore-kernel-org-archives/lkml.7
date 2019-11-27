Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EFDC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 09:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 762A4204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 09:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfK0JZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 04:25:42 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33757 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfK0JZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 04:25:41 -0500
Received: by mail-oi1-f193.google.com with SMTP id x21so12381877oic.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 01:25:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e3SI+PalkAVg/EhpKyNHwp1BQJsL2GZX4PjkGsyUXnU=;
        b=OniQZNKCDhOfzvscsApmcl6SEEZHalhTZ1PAEz/gkuQzGTVXlUEt7s8uUOdYsdceDm
         v2EQzBEdkc7vJY7DjEkMzsakhHlndEp2prNd1Kt+PUuRKF43weLkKE7V0z4KpP7CX9ZF
         4R3uBPus1HwVeN5oB7qd1+MUz8vsXFYik4s7/nse3d+xXlNemWNSI6BhVjcq+5VoZsNh
         SB73r82UNNuVAwb3CHM0b7Y5dKrA6lKFrj1Kh34ZNMY41/zSEtQsdN6uAXNLZlBM60vC
         JH8+q41n2Z0WxAe1IGnqxGZm8APqOevKZKgq5NQ+X89WGJiPN1NuI1l5PwUilD+agbHx
         KJMQ==
X-Gm-Message-State: APjAAAUzCvXKlESh5k+DphW35MHENOLHN6efePXbhBMpb0I9AC/wN9jO
        pm+U3DIlqnGBmJL+910GjKGg7/kCibAm1psk3Fs=
X-Google-Smtp-Source: APXvYqwlfP556yI7xTcMB0OAC7IxK3vUcovtm5hRT1uToSaoYNd1PAbNuHxWBQNo01mxjK1zerzjxZim95QPOkPhtSc=
X-Received: by 2002:aca:3a86:: with SMTP id h128mr3049038oia.131.1574846740792;
 Wed, 27 Nov 2019 01:25:40 -0800 (PST)
MIME-Version: 1.0
References: <20191115150202.15208-1-erosca@de.adit-jv.com> <05ba4e29fb78885cf9abf7bfc87e0a7bcda099fe.camel@perches.com>
 <20191115154627.GA2187@lxhi-065.adit-jv.com> <20191115092943.7c79f81e@lwn.net>
 <20191115172141.GA3085@lxhi-065.adit-jv.com>
In-Reply-To: <20191115172141.GA3085@lxhi-065.adit-jv.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 27 Nov 2019 10:25:29 +0100
Message-ID: <CAMuHMdUhPV2B4dpgpPogpFQPprX-VOCC5RuwLLv3MiHzp-pq3Q@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: whitelist Originally-by: signature
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugeniu,

On Fri, Nov 15, 2019 at 6:24 PM Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
> On Fri, Nov 15, 2019 at 09:29:43AM -0700, Jonathan Corbet wrote:
> > On Fri, 15 Nov 2019 16:46:27 +0100
> > Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
> > > On Fri, Nov 15, 2019 at 07:09:17AM -0800, Joe Perches wrote:
> > > > On Fri, 2019-11-15 at 16:02 +0100, Eugeniu Rosca wrote:
> > > > > Oftentimes [1], the contributor would like to honor or give credits [2]
> > > > > to somebody's original ideas in the submission/reviewing process. While
> > > > > "Co-developed-by:" and "Suggested-by:" (currently whitelisted) could be
> > > > > employed for this purpose, they are not ideal.
> > > >
> > > > You need to get the use of this accepted into Documentation/process
> > > > before adding it to checkpatch
> > >
> > > If the change [*] makes sense to you, I can submit an update to
> > > Documentation/process/submitting-patches.rst
> >
> > So there appear to be 89 patches with Originally-by in the entire Git
> > history, which isn't a a lot; there are 3x as many Co-developed-by tags,
> > which still isn't a huge number.  I do wonder if it's worth recognizing
> > yet another tag with a subtly different shade of meaning here?  My own
> > opinion doesn't matter a lot, but I'd like to have a sense that there is
> > wider acceptance of this tag before adding it to the docs.
>
> I will give a real-life example. Say, I have some patches in my
> local tree and they've been developed by somebody who is no longer
> interested/paid to upstream those.
>
> I first submit those patches with the original authorship, plus my SoB.
> Then, the reviewers post their findings. I put my time into fixing those
> and re-testing the patch or the entire series. The final patch/series
> may look totally different compared to the original one.
>
> Which way would you suggest to give credits to the original author?
> I personally think that "Co-developed-by:" conveys the idea/feeling of
> "teaming up" with somebody, which doesn't happen in my example.

What I typically do is this:
  1. If the changes due to review are minor, I just add my SoB below the
     original SoB,
  2. If the changes are not insignificant, I also add a line "[geert: Did foo]"
     in between the original SoB and mine,
  3. If the patch needed a complete rewrite, I assume ownership, and add
     "Based on/inspired by ..." to the patch description to give credit.

Hope this helps (and is acceptable for other people ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
