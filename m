Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F370C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 10:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E353A21906
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 10:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="XUYmuQi/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfJAKeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 06:34:07 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42918 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfJAKeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 06:34:06 -0400
Received: by mail-io1-f66.google.com with SMTP id n197so46499387iod.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 03:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6AUoGAsc63xfOju6F5+pghwj/1bxK9PF7awTWjOwEOw=;
        b=XUYmuQi/GnwvsxCVi1F3iJRRhqxT2zq5bjp2Uoi/9d7VjsYEhxlebxKmO7/pd0xa0H
         OlITP0GsH0tmVi8M0vQbKLXpWPrI6YwTCXgJNnvpO0zkclQPnr1DDQ4PgxjuhEdIFZVb
         vXJlKxDJKbr82gIIl2ssLSyg+wte6jcrsEVPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6AUoGAsc63xfOju6F5+pghwj/1bxK9PF7awTWjOwEOw=;
        b=k8c03AlfzYMG6+QGD9z3D5YLol6EntpnINV0dvMKOitB134xJoZR14J8NYP02LwIfk
         WNcIBt7wjqCPvE8V4cO2lqfg1+3WxrCVicPk3usG2wonAZilUjLX/+1pvYU2nnPb+sOC
         6E6CySxqnYcgZnOiizSvMKffj0ynsbebnkSfmihnEEv61zvCA2DDtmfnytbIc31cAnNu
         7peLKRxjCsA55m4uL1PCTdrj5kPi15dXF3qbyX4ifwXTWesWGTVytPl19nJ1ISL+ua4y
         2tctBLgK2b+2g0exAdhjCUOdtXaXun8jVXFD4e9zItHvo4UWf3fOT2BrZ2PpHo8rmYDA
         bDwg==
X-Gm-Message-State: APjAAAUX41x35C/zdqZs+ks1vgYkPKKpO0UW0PnXhW86mUdBlI7l4d9c
        cJ99V3J3I/Q8NlR/Tbv1/dYjekdIPAiGUPD5qFUoKA==
X-Google-Smtp-Source: APXvYqxHnKG/AQXbNeChYThj5dd5yvNkhFAenW0UYhhzFKDyKT0mVDkf/X7vv/S8KA9rQY7cWNQ/6OoDgDEEox0dNiU=
X-Received: by 2002:a02:6284:: with SMTP id d126mr23167865jac.51.1569926045668;
 Tue, 01 Oct 2019 03:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190919052822.10403-1-jagan@amarulasolutions.com>
 <20190919052822.10403-5-jagan@amarulasolutions.com> <4177305.6QI6aNXrAv@phil>
In-Reply-To: <4177305.6QI6aNXrAv@phil>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 1 Oct 2019 16:03:54 +0530
Message-ID: <CAMty3ZBZ0kXsc-4EwUwy9rAHcDvhhYL1JWkyhhdvSvfRdyvvwA@mail.gmail.com>
Subject: Re: [PATCH 4/6] arm64: dts: rockchip: Rename roc-pc with libretech notation
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Levin Du <djw@t-chip.com.cn>, Akash Gajjar <akash@openedev.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Da Xue <da@lessconfused.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 3:02 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Hi Jagan,
>
> Am Donnerstag, 19. September 2019, 07:28:20 CEST schrieb Jagan Teki:
> > Though the ROC-PC is manufactured by firefly, it is co-designed
> > by libretch like other Libretech computer boards from allwinner,
> > amlogic does.
> >
> > So, it is always meaningful to keep maintain those vendors who
> > are part of design participation so-that the linux mainline
> > code will expose outside world who are the makers of such
> > hardware prototypes.
> >
> > So, rename the existing rk3399-roc-pc.dts with libretch notation,
> > rk3399-libretech-roc-rk3399-pc.dts
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/Makefile                           | 2 +-
> >  .../{rk3399-roc-pc.dts => rk3399-libretech-roc-rk3399-pc.dts}   | 0
>
> Somewhat "randomly" renaming files for "exposure" of the maker isn't the
> way to go. Especially as the file name itself is merely a handle and not
> meant for fame. The board filename should mainly enable developers to
> hopefully the correct board file to use/change - and "rk3399-roc-pc"
> is sufficiently unique to do that.
>
> Similar to how the NanoPi boards do that.
>
> And renames not only loose the history of changes but also in this case
> the file is in the kernel since july 2018 - more than a year, so this might
> actually affect the workflow of someone.

Yes, I agreed this point.

>
> So I'd really expect an actual technical reason for a rename.

This changes purely based on the recent changes on naming conventions
that have been followed in amlogic and allwinner with regards to
libretech [1]. I have seen few Bananapi boards from Allwinner H3 has
been converted as per Libretech computer recently. I assume these
changes are because libretech has part of co-designed vendor and also
open source forum supported for these hardware.

For further information, may be Da Xue can comment on this.

[1] https://libre.computer/products/boards/
