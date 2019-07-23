Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D331DC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 658E92239E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="L3WysIDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390889AbfGWQhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 12:37:20 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:37396 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbfGWQhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 12:37:19 -0400
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x6NGbD00016301
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 01:37:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x6NGbD00016301
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563899834;
        bh=JSFWAiztZP/N5BXKMO6gIHsKgS5zrSPfJfqhid6TItM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L3WysIDVNilUk+7BDmRZQTQzccQic31+bdiLhsO5Ezv/0p0IM6NKNOSHIjo8cST6/
         htc69zA2+dLuXqb9ZzlxCMd6QwzM3Bq7GNhlegmtT+hmXpoFCmKS9rA1kjAZpDISuY
         /iB+aaTnlZo46Y58v165t8+dF3Men7kTEWsTTAgkYTAHR8DyTk8Afy73ywgh0Q6jsr
         WkmahUa1uYPqFWYXxTXR0u8AT8QxAdYuwnTLUN+dkbPpvPrQx7SvEPjIR+P4KIWvNt
         GZMheetNuKYNZOVkHt7bjNbo8eeHBbx7ubFHWZhamgLGpolzVFTcMMF2ULKPMYinyv
         1BO+J3FohDglg==
X-Nifty-SrcIP: [209.85.221.173]
Received: by mail-vk1-f173.google.com with SMTP id b200so8759444vkf.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 09:37:13 -0700 (PDT)
X-Gm-Message-State: APjAAAVwTn8flScDOZG6c5QrDJylSzqqUWrgssiwGxd+j2AY0HNeIsFS
        gzE0/v8gscE3N/SqFcC8HSqWD2ZzZQmzJ/MT4Eo=
X-Google-Smtp-Source: APXvYqzUnVn4yGh99OfdRUkGaCtT70BglsZH2Wiari5nt/g+lE1EkJtm8JeU0YZP54Nn/Ybb2Ylws8X9Z3vnr5CYOaA=
X-Received: by 2002:a1f:4107:: with SMTP id o7mr29435305vka.34.1563899832702;
 Tue, 23 Jul 2019 09:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190721085409.24499-1-k0ma@utam0k.jp> <CAK7LNARBjkYHkmv1michYYMd-2_70d+-Gvg1Kv4FyPeeBShvdw@mail.gmail.com>
 <20190723162840.GA7110@gmail.com>
In-Reply-To: <20190723162840.GA7110@gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 24 Jul 2019 01:36:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQqUtUPSu=UmtZ-dqsjUgUO-f6U1tQa9VPmJ944poh6zA@mail.gmail.com>
Message-ID: <CAK7LNAQqUtUPSu=UmtZ-dqsjUgUO-f6U1tQa9VPmJ944poh6zA@mail.gmail.com>
Subject: Re: [PATCH] .gitignore: Add compilation database files
To:     Toru Komatsu <k0ma@utam0k.jp>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 1:28 AM Toru Komatsu <k0ma@utam0k.jp> wrote:
>
> On 07/24, Masahiro Yamada wrote:
> > Just a nit.
> >
> > The patch title is:
> > .gitignore: Add compilation database "files"
> >
> > Maybe, should it be singular?
> >
> >
> > On Sun, Jul 21, 2019 at 5:55 PM Toru Komatsu <k0ma@utam0k.jp> wrote:
> > >
> > > This file is used by clangd to use language server protocol.
> > > It can be generated at each compile using scripts/gen_compile_commands.py.
> > > Therefore it is different depending on the environment and should be
> > > ignored.
> > >
> > > Signed-off-by: Toru Komatsu <k0ma@utam0k.jp>
> > > ---
> > >  .gitignore | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/.gitignore b/.gitignore
> > > index 8f5422cba6e2..025d887f64f1 100644
> > > --- a/.gitignore
> > > +++ b/.gitignore
> > > @@ -142,3 +142,6 @@ x509.genkey
> > >
> > >  # Kdevelop4
> > >  *.kdev4
> > > +
> > > +# Clang's compilation database files
> > > +/compile_commands.json
> > > --
> > > 2.17.1
> > >
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada
>
> --
>
> Thanks for your review.
>
>  Sorry, this point which you pointed out is my mistake.
>  It is should be "file".
>
>  I'm begginer because this patch is my first time,
>  What should I do next?


This patch is trivial enough.

I will change "files" -> "file"
(patch subject and code),
then I will apply it.

Thanks.




-- 
Best Regards
Masahiro Yamada
