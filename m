Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A598C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2890220673
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 10:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388583AbfFKK6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 06:58:23 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33378 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388486AbfFKK6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 06:58:23 -0400
Received: by mail-qt1-f195.google.com with SMTP id x2so13021097qtr.0;
        Tue, 11 Jun 2019 03:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j4+cAKja5ctd4n4wYve41ZZXAaiKXNEQ2fa4f2n5B+Q=;
        b=bEtJTg6FbfjpF1LOPO+0Y4++pEDfIO5A9Rysa9fCXgjLwndq5xul9udmmH9q0Yg2aW
         RVcnnS2GbDplkc69tKcMvqURaJo8mQdfK5zpJOtruTNwNeKz00x360qjJyPvdTrWTR8Y
         GaLcacNYlC8qnTi+tf3926T8tz2TDfnP396ZiMJyME7pK1Yfd+m890JCNPaHEq0O95Cr
         uv23j9T1f5xtbwPlydTEb5VX4HpFJDmu5U+9S3GplGVcKUmpnOhEqQF9xGknY8Et9ejj
         PVQQnjIlUqWYfwFFaMI3iswdfmhXbkrLhip5DuRiID0fI6rqnHDlU5QYDLmjg6nBG8XK
         aF3w==
X-Gm-Message-State: APjAAAW7Z1CH9kMiKxqGw0joaMsoTMa7mY5nemGj0e6pLitRHmZ8lBjv
        BwyvolVR6PqtN1PXCt/fdM4JTYgSHsfPSaFhmdcjW+Bn
X-Google-Smtp-Source: APXvYqwBtk8X8CjFGz1hyn1jclGQrWy76DpGXabmlGMLJQi1edfd9kdTqdXYofzsyx+e0oPqh72w8vhgof2i3QBmAQc=
X-Received: by 2002:aed:2bc1:: with SMTP id e59mr43389945qtd.7.1560250701931;
 Tue, 11 Jun 2019 03:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190423151143.464992-1-arnd@arndb.de> <9da847b0-9e32-ad4b-78d3-15398b0f8fe2@koeln.de>
In-Reply-To: <9da847b0-9e32-ad4b-78d3-15398b0f8fe2@koeln.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 11 Jun 2019 12:58:05 +0200
Message-ID: <CAK8P3a0QEf1j96UhLNrZgxnHkKgs+BG7ONgqWX0Ep9Od1nm4gQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] isdn: deprecate non-mISDN drivers
To:     Simon Ehlen <simon.ehlen@koeln.de>
Cc:     linux-netdev@vger.kernel.org, linux-driver-devel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 10:43 AM Simon Ehlen <simon.ehlen@koeln.de> wrote:
>
> Am 23.04.2019 um 17:11 schrieb Arnd Bergmann:
> > It turns out that the suggestion from Karsten Keil wa to remove I4L
> > in 2018 after the last public ISDN networks are shut down. This has
> > happened now (with a very small number of exceptions), so I guess it's
> > time to try again.
> There are still public ISDN networks available. My provider (NetCologne) is still serving native ISDN.
> > If anyone is still using isdn4linux and CAPI with modern kernels, please
> > speak up now.
> I'm using kernel isdn support in different ways.
> 1. To connect (b1pci,capidrv) to the PSTN of my provider to use phone (capi, chan_capi), fax (capi4hylafax, hylafax) and answering machine (vbox) services.


It seems that NetCologne has tried to get rid of their ISDN users
since at least 2015,
according to
http://web.archive.org/web/20151005031127/https://www.netcologne.de/aktion-zukunft-ip

Do you have any information on when they finally turn it off? As stable kernels
with avmb1 support will be around for a while, you might not be affected.
For the gigaset driver, the idea so far is to leave it in staging
until Paul Bolle
loses his connection later this year.

You could become the maintainer for avmb1 until netcologne shuts down
theirs if you want.

The core CAPI code is still left in drivers/isdn, as Marcel Holtmann still
maintains his bluetooth front-end.

> 2. To build an internal ISDN network using hfc in NT mode.

This is mISDN, right? There seem to be a lot of people still doing this,
so we will keept that driver in mainline even though a lot of users are
probably on the forked mISDN v2 that never made it into the kernel in
the first place.

> There are other users as well still making use of isdn support in the linux kernel. [1]
> As he pointed out, although public ISDN services are phasing out every AVM
> Fritz!Box is capable of providing VOIP services over it's internal S0 bus.
> In case my provider decides to shut down ISDN I would make use of the S0 bus
> to keep my services running.
>
> So please refrain from removing ISDN/CAPI support of the linux kernel.

What I was looking for here was either someone who can become a
maintainer for whichever driver they still use, or someone with a specific
use case rather than a description of what can be done in theory.

The use case of having an NT-mode PBX (e.g. Fritzbox or mISDN based)
in combination with another Linux+CAPI instance as the client is
clearly possible, I just haven't heard any explanation of what that would
be good for, compared to using more widely available ethernet hardware
with SIP or other other protocols on top. This could of course just
me being ignorant, so please let me know if you have more specific
information on such setups.

Do you know anyone who is actually using a mainline supported CAPI
driver in NT mode (which driver?), or connects a CAPI based device
to a Fritzbox and has to update the kernel to linux-5.3 before moving to
an IP based replacement?

        Arnd
