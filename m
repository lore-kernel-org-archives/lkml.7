Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC34C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 05:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229CB217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 05:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="QthS0PTX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbfH0FPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 01:15:49 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:35111 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfH0FPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 01:15:49 -0400
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x7R5Fajn025312
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 14:15:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x7R5Fajn025312
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566882937;
        bh=zeAycLLY1+YwZS+X2e0YqPWel6Z800aRLRMBYLbHzjc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QthS0PTXWF5aBM+m7e1UvVbvlMqry/Rqocy8p7BOjVAsh3YG7fXpSvAJOTH+trtQV
         ThzxsmWaCM5IYVDckq79nclpCwzP5KLhAfrNCBIzPB0lkKT/xFcaqPDIyAXXLhi+ZK
         FasB5AzWFwEerSy9yysA1paGNQqbzgU6Bj4ghKePZtccCfkkBzupFqOR64KyxddEsA
         +DjHYFnNtkdQQ/P9E5QeA5tGSqhW4MQorW7lggHr80fG8TJmhiXjp1ZO0G9CBGAjJW
         YkYUJS+cPrpBl3i8DgeE82aU37/DrrUaPu0vsWWCWm2WeImXOKkBgfknaI3EbHlD7N
         3AmnrLjbLD1gw==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id i128so12600060vsc.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 22:15:36 -0700 (PDT)
X-Gm-Message-State: APjAAAWNjJLGm3452P7mUqZdhwlGAv8eYsuuxCXzP4Lg+jtyTtPjKGu6
        zgw7dEcDNcWXeZGMkjJcPgsH94bEWsyZ/Ygoc2U=
X-Google-Smtp-Source: APXvYqwP0GzvRul07oVJT4KEY7/gNx4mfEnLfUfHczL8h8K2KZo6T88R3SmwojkurNLRCWeIE1hR1si3oTLM73bFypc=
X-Received: by 2002:a67:fd97:: with SMTP id k23mr12661548vsq.179.1566882935496;
 Mon, 26 Aug 2019 22:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190821092658.32764-1-yamada.masahiro@socionext.com> <20190826113526.GA23425@infradead.org>
In-Reply-To: <20190826113526.GA23425@infradead.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 27 Aug 2019 14:14:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ_5Hz_CXAdx8W0bLjMWQ08KDWK3gG2pfDZOEE+cr0KEw@mail.gmail.com>
Message-ID: <CAK7LNAQ_5Hz_CXAdx8W0bLjMWQ08KDWK3gG2pfDZOEE+cr0KEw@mail.gmail.com>
Subject: Re: [PATCH] riscv: add arch/riscv/Kbuild
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 8:35 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Aug 21, 2019 at 06:26:58PM +0900, Masahiro Yamada wrote:
> > Use the standard obj-y form to specify the sub-directories under
> > arch/riscv/. No functional change intended.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Do you have a document what the grand scheme here is?

There is a small documentation about "Makefile" vs "Kbuild"
in Documentation/kbuild/modules.rst section 3.2

It is talking about external modules, but the benefit applies
to arch/$(SRCARCH)/Kbuild as well.

arch/$(SRCARCH)/Makefile is included by the top Makefile
to specify arch-specific compiler flags, etc.

On the other hand, arch/$(SRCARCH)/Kbuild, if exists, is included
when Kbuild actually descends into arch/$(SRCARCH)/.

This allows you to hierarchize the sub-directories to visit
instead of specifying everything in flat in arch/$(SRCARCH)/Makefile.

Major architectures are already doing this.

See
arch/x86/Kbuild
arch/sparc/Kbuild
arch/powerpc/Kbuild
etc.

(and arm64 also adopted this recently)


The trick is "Kbuild" has precedence over "Makefile".

If you are interested in the actual code,
see line 41 of scripts/Makefile.build




>  Less of the magic
> in arch/$(ARCH)/Makefile sounds like a good idea, but unless we have
> a very specific split between the kbuild makefile and various override
> I fear just splitting things up into two files doesn't really help much.

Why not?


-- 
Best Regards
Masahiro Yamada
