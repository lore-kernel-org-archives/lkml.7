Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B151BC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84EDB20693
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 09:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="GodJ1SH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfGaJXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 05:23:49 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:31934 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbfGaJXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:23:48 -0400
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x6V9NcLb007060
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 18:23:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x6V9NcLb007060
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564565021;
        bh=9tUjIz1fGxhObB1pzGXilSS2tawCCVGtMhdl2p7YMLk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GodJ1SH7hNvqP7xGg69guLxpiLMGWb3rywHUqjcAVoz7wR7ex+3WjOR/CY+MwQUfj
         lfDKiXselUh5g3ayzOuj5fjC4rB/UpHJwULkXQIP463z95v857AETvrjaC99YVdJDV
         Fei7d91XEhEpQgN61VhP0qqsaY4+r7TrzG8Z8EddqqW1AIKXcNJJYyzP6QHBhWdQeH
         b10ZcDfm9cRMhVdmCV7qeFi12G6Ekj1eLcu//+ccbcFDOFg0S1Rz2EqGVoSaPZmDJJ
         rvbkyMuU9tb1zPjj54G8ulcweOA8to2/wlJMgB8t0KCX32hMQ0az1SOqmQ4uuIOFsc
         WPgIGtIDPBhpg==
X-Nifty-SrcIP: [209.85.217.52]
Received: by mail-vs1-f52.google.com with SMTP id v6so45733896vsq.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 02:23:40 -0700 (PDT)
X-Gm-Message-State: APjAAAVOTCqvsmHB8sit0y2lyqGSpNHJCPJrky4yWGELtRzllsSPHv1w
        1qrIZTGHBebYLb0geqB0i1v6/UrvyRYTFrc3Dog=
X-Google-Smtp-Source: APXvYqy+cQDUqYKvKJzVt1ni/ykoG5y018qK8bIlFDYIVOu3Yq3WGfpMKJUdrHac6HYyrQbW6Lb4sLZh9BZlSP9pseQ=
X-Received: by 2002:a67:8e0a:: with SMTP id q10mr53229263vsd.215.1564565017600;
 Wed, 31 Jul 2019 02:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190728154728.11126-1-yamada.masahiro@socionext.com> <20190730125249.b899526e44608371fb11e03c@linux-foundation.org>
In-Reply-To: <20190730125249.b899526e44608371fb11e03c@linux-foundation.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 31 Jul 2019 18:23:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNATSaZVdFm4=mODoAUnjwf3QKS5Fx5drkZ-yGDHTabfPsQ@mail.gmail.com>
Message-ID: <CAK7LNATSaZVdFm4=mODoAUnjwf3QKS5Fx5drkZ-yGDHTabfPsQ@mail.gmail.com>
Subject: Re: [PATCH] linux/coff.h: add include guard
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Wed, Jul 31, 2019 at 4:52 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 29 Jul 2019 00:47:28 +0900 Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>
> > Add a header include guard just in case.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> > Looks like this file is unused at least in the kernel tree,
> > but I am not it is OK to delete it.
>
> arch/alpha/boot/tools/objstrip.c includes it but I don't think it's
> actually needed.  Yes, it would be nice to kill coff.h.

After some consideration, I think it is better to keep it
until we dump the alpha support entirely.

The following line in arch/alpha/boot/tools/objstrip.c
references a macro in <linux/coff.h>:

        if (!(aout->fh.f_flags & COFF_F_EXEC)) {


I was not able to build objstrip.c anyway,
but I think it is better to keep the can of worms closed for now.


Could you apply this as-is please?


My motivation is to allow Kbuild to detect missing include guard:

https://patchwork.kernel.org/patch/11063011/


Before I enable this checker,
I want to fix as many headers as possible.



-- 
Best Regards
Masahiro Yamada
