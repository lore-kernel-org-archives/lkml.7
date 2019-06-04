Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1D4C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8AE2218CD
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="m3lilr1b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfFDMNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 08:13:33 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:36786 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfFDMNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 08:13:32 -0400
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x54CDEKR026129
        for <linux-kernel@vger.kernel.org>; Tue, 4 Jun 2019 21:13:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x54CDEKR026129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1559650395;
        bh=j4ooK2TXA9XEPYH9036qD0m6269InPrHu8MiGbjtEI8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m3lilr1biUthCuT3Fwb+7h7x3OjfKAVGp2bE9jsxFdz480cpK4zWyzWgX0dKePLGR
         mZgdShIwhX49q0ci93vDu4QMpb3zu1PBaoyEXspH1/tGh9Yz05fmjmiw+H54h3mvG9
         CE27QOl3GpPGUyGx+EyypLmb9OnDengqyh6NLeeKlWpSL8p0ZCExPOJnWOY93Eb+eC
         xIBTysqsJhGAJnIDOBGDroEPy+9ky7qW+3FlZs0wDfGb/P/BHjgju6X+QjLBL1Fu5n
         c6EHM0wI2SdESGglwNFIbv6slL+rSBQrDZt2ch3jhU1JHtuRD1pOtBlpkeOLQ1L8Ya
         W12YaCpqjT5DQ==
X-Nifty-SrcIP: [209.85.222.44]
Received: by mail-ua1-f44.google.com with SMTP id e9so7687671uar.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 05:13:15 -0700 (PDT)
X-Gm-Message-State: APjAAAUzPq2LIMlrbuMlX3r3seqLQn2mQEa2BtQSRfQQ82IAbdvN5iRR
        pOASzed0cP3wOq9Cuei+Hjil47r3DA+zDBFj1sY=
X-Google-Smtp-Source: APXvYqz4S65tSxS052C5ndvPnTtlUmiHYxC0T11Z+OAFLZHKhv7vZjxFm8n9N1K3MCaX2SBo2i2B1jVPvSDV1C8QIe0=
X-Received: by 2002:a9f:25e9:: with SMTP id 96mr392723uaf.95.1559650393956;
 Tue, 04 Jun 2019 05:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190604111632.22479-1-yamada.masahiro@socionext.com> <90aa6d91-7592-17b0-17fd-e33676bd0a46@linux.ibm.com>
In-Reply-To: <90aa6d91-7592-17b0-17fd-e33676bd0a46@linux.ibm.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 4 Jun 2019 21:12:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNASV9Chjd+o3+2ZbA0WHu=dVBFf2AC1dT=eLSf3_2pe12Q@mail.gmail.com>
Message-ID: <CAK7LNASV9Chjd+o3+2ZbA0WHu=dVBFf2AC1dT=eLSf3_2pe12Q@mail.gmail.com>
Subject: Re: [PATCH] ocxl: do not use C++ style comments in uapi header
To:     Frederic Barrat <fbarrat@linux.ibm.com>
Cc:     Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 8:54 PM Frederic Barrat <fbarrat@linux.ibm.com> wrot=
e:
>
>
>
> Le 04/06/2019 =C3=A0 13:16, Masahiro Yamada a =C3=A9crit :
> > Linux kernel tolerates C++ style comments these days. Actually, the
> > SPDX License tags for .c files start with //.
> >
> > On the other hand, uapi headers are written in more strict C, where
> > the C++ comment style is forbidden.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
>
> Thanks!
> Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>
>

Please hold on this patch until
we get consensus about the C++ comment style.

Discussion just started here:
https://lore.kernel.org/patchwork/patch/1083801/


--=20
Best Regards
Masahiro Yamada
