Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE17C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B922147A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="rAjVJiwL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfFDNdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:33:02 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:29681 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbfFDNdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:33:01 -0400
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x54DWsae002994;
        Tue, 4 Jun 2019 22:32:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x54DWsae002994
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1559655175;
        bh=DdqPGelx+UvqSQNSB1I82Uy9HAejQQVpNWFtcrMN3s0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rAjVJiwLOkHm7o7rk8TOVCWIrlz4lEFPvhbcigcAQMyJPMLq5Pkuq5hPBZB5n1t4p
         LZcXnk4gHixreL9SVPw3ebUbUBnUnoJJcn80ml4hPjw5Y8UoZlKp0m1wSPJ7Y71PFQ
         LePoi8PRnKmUMc9GPt6UWVjGZmTs5JH3jCt3hivuRgOrh1xiKLpEwjYi9C4klK7rQy
         D+An6Nmy3W8YZTqCpmwWVEbowtHjwu60Xu1/KHbV5z+3LufZ+ob3hLIrt6rgKcoYWK
         qbuLLXyDWDS/sdoHtdrNMrfKqGUANKEbiom91sGknB0aaJsPn/mnGHIh/v19/hnRWS
         KQ9sfBvBngX9A==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id b10so13492516vsp.5;
        Tue, 04 Jun 2019 06:32:54 -0700 (PDT)
X-Gm-Message-State: APjAAAXY2mkL6tCz3d/aaLYDUrqBg90o02hnV9/Wcju45LagFp+8WvLH
        3xkmkYjZ9oaNCl+wSe/70RVYHHaOMXJQW/lWix8=
X-Google-Smtp-Source: APXvYqz7BnkNRib5XNmOJemAMuFC8aSh7H5hU1PtqEoB8GufdTmw/nFNj7w4ihQj5dlOKpGtYWdrt9XB4W6GiuWNOdg=
X-Received: by 2002:a05:6102:3c2:: with SMTP id n2mr16019239vsq.181.1559655173678;
 Tue, 04 Jun 2019 06:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190604111334.22182-1-yamada.masahiro@socionext.com>
 <8cf48e20064eabdfe150795365e6ca6f36032e9f.camel@perches.com>
 <CAK8P3a1oDfNF_T+NCoPsXkJAY2x4_uCWSwrDXHi7dDSaMqfnfA@mail.gmail.com> <CAK7LNAS0Ph2Z6x0-UPSkJUC31NvPi09BmFrve+YJcXMrop-BGA@mail.gmail.com>
In-Reply-To: <CAK7LNAS0Ph2Z6x0-UPSkJUC31NvPi09BmFrve+YJcXMrop-BGA@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 4 Jun 2019 22:32:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNARdX2nQMsdaua3qi7k3TpAs4APrUXm3rBrj6Y02xOmp_w@mail.gmail.com>
Message-ID: <CAK7LNARdX2nQMsdaua3qi7k3TpAs4APrUXm3rBrj6Y02xOmp_w@mail.gmail.com>
Subject: Re: [PATCH] media: do not use C++ style comments in uapi headers
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Joe Perches <joe@perches.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 9:48 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Tue, Jun 4, 2019 at 8:55 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Tue, Jun 4, 2019 at 1:23 PM Joe Perches <joe@perches.com> wrote:
> > >
> > > On Tue, 2019-06-04 at 20:13 +0900, Masahiro Yamada wrote:
> > > > On the other hand, uapi headers are written in more strict C, where
> > > > the C++ comment style is forbidden.
> > >
> > > Is this a real problem for any toolchain?
> >
> > There is likely some code that is built with -Wpedandic -Werror --std=c89
> > or similar. Since glibc allows this combination for its own headers, it seems
> > best to also allow it in kernel headers that may be included by libc headers
> > or by applications, at least where it does not hurt.
> >
> > Realistically though, we probably assume c99 or gnu89 in user space
> > headers anyway, since there is no 'long long' in earlier standards.
> >
> >        Arnd
>
> In fact, I detected this issue by the following patch:
> https://patchwork.kernel.org/patch/10974669/
>
> When I worked on it, I wondered which
> c-dialect flags should be used.
>
> This code:
>
> > # Unlike the kernel space, uapi headers are written in more strict C.
> > #  - Forbid C++ style comments
> > #  - Use '__inline', '__asm__' instead of 'inline', 'asm'
> > #
> > # -std=c90 (equivalent to -ansi) catches the violation of those.
> > # We cannot go as far as adding -Wpedantic since it emits too many warnings.
> > #
> > # REVISIT: re-consider the proper set of compiler flags for uapi compile-test.
> >
> > UAPI_CFLAGS := -std=c90 -Wpedantic -Wall -Werror=implicit-function-declaration


I got rid of -Wpedantic in the submitted patch.
Sorry if I confused you.


--
Best Regards
Masahiro Yamada
