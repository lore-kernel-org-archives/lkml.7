Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58EFC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 00:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E1520850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 00:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="mlzkfAbt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731977AbfCAAOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 19:14:16 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:17698 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731073AbfCAAOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 19:14:16 -0500
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x210E3Ho017295
        for <linux-kernel@vger.kernel.org>; Fri, 1 Mar 2019 09:14:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x210E3Ho017295
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1551399244;
        bh=l/IWV3LZWtsWgxBlgAhhhO4gMz3C36RGPg8IAsWi7KU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mlzkfAbt9UyqVeECgYNBLpOpVNWaSTvFfLgLPyi94fWU2nvUT2xJXhzTyDuNGp/qB
         /74t55h+lDyg0fA6LvgVoP/bW906TpUkaxkT1E3abfo6Fi21cJl8Bz9a+zwQ4Sjdux
         jFgQakGPQF+BmYykcCRiiK75bgtGy0sxMjMKQ5AQqNVkHBDDZQ1/mbW31Uy5hRDG6C
         KwjNrSa6cQEPP/oSS9d5x0mmyDD8qcRtNUnzUra6nrkQN3PBaGtcdoPJdX2A05fIDq
         lpNyfctXnStTBQzW2bMzqvtiQN641khyzAPuQ1kGKWz0WS3UbpjRAQO+iE9/A5mdaR
         /wQBX796kZVVQ==
X-Nifty-SrcIP: [209.85.222.47]
Received: by mail-ua1-f47.google.com with SMTP id a42so20808782uad.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 16:14:03 -0800 (PST)
X-Gm-Message-State: APjAAAUM/o3C+Hl2A5Z6+wKTKGMcsS6W+l9/zAfQGFhfieJbl3q9/fAe
        YVYPm6q+5SrWuXJD4Krc5aUmZUi+80B/kMKwehM=
X-Google-Smtp-Source: APXvYqw83fvoS/QWpc1wwFaBQefer4R95enHT2K396DLkjKmgki0SBePum5kiEhKZwnb1p7b20O148xYIlZGGtk063I=
X-Received: by 2002:a05:6102:18f:: with SMTP id r15mr1151656vsq.215.1551399242814;
 Thu, 28 Feb 2019 16:14:02 -0800 (PST)
MIME-Version: 1.0
References: <20190228174109.MrWZN%akpm@linux-foundation.org> <20190228211126.GA28901@avx2>
In-Reply-To: <20190228211126.GA28901@avx2>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 1 Mar 2019 09:13:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQv4giq5r4AKv4Ff1KP7k7US2Sdt=m1ZAXsDmKWKhZ9vQ@mail.gmail.com>
Message-ID: <CAK7LNAQv4giq5r4AKv4Ff1KP7k7US2Sdt=m1ZAXsDmKWKhZ9vQ@mail.gmail.com>
Subject: Re: + include-linux-typesh-use-unsigned-int-instead-of-unsigned.patch
 added to -mm tree
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wang.bo116@zte.com.cn, WangBo <wdjjwb@163.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 1, 2019 at 7:08 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> On Thu, Feb 28, 2019 at 09:41:09AM -0800, akpm@linux-foundation.org wrote:
> > --- a/include/linux/types.h~include-linux-typesh-use-unsigned-int-instead-of-unsigned
> > +++ a/include/linux/types.h
> > @@ -155,9 +155,9 @@ typedef u64 dma_addr_t;
> >  typedef u32 dma_addr_t;
> >  #endif
> >
> > -typedef unsigned __bitwise gfp_t;
> > -typedef unsigned __bitwise slab_flags_t;
> > -typedef unsigned __bitwise fmode_t;
> > +typedef unsigned int __bitwise gfp_t;
> > +typedef unsigned int __bitwise slab_flags_t;
> > +typedef unsigned int __bitwise fmode_t;
>
> I don't know if this is desireable. Switching to "unsigned" is better:
> 1 less token and less 80 column pressure.



See the following commit.




commit a1ce18e4f941d2039aa3bdeee17db968919eac2f
Author: Joe Perches <joe@perches.com>
Date:   Tue Mar 15 14:58:03 2016 -0700

    checkpatch: warn on bare unsigned or signed declarations without int

    Kernel style prefers "unsigned int <foo>" over "unsigned <foo>" and
    "signed int <foo>" over "signed <foo>".

    Emit a warning for these simple signed/unsigned <foo> declarations.  Fix
    it too if desired.

    Signed-off-by: Joe Perches <joe@perches.com>
    Acked-by: David S. Miller <davem@davemloft.net>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>






-- 
Best Regards
Masahiro Yamada
