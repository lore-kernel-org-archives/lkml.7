Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF9AC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 06:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879852175B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 06:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="iVsglhas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfEJGVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 02:21:15 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:21908 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfEJGVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 02:21:14 -0400
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x4A6L4l3009238
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 15:21:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x4A6L4l3009238
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557469265;
        bh=RfshYBEawlaUrELiRcm1azT4/5cCoz/xlPLRX8HpZ6I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iVsglhasHCMUQ2gTfrrTQ9SA+2qlLIJLIgGVSrvPFJCyyso0I6t8SKcqGsDj6Yx87
         VMH36aRqji1lhQU4TsBO8+3Cv25iAzR/FhUu7KgB0T0Bq5nMjhfwTVOkgHaXaZ/i21
         bb/TsUnKm75RMjKlLSDlLaCJAX5wB8lC/Lf1e6si5/mR9G7eYbhN3FAbj2YqWwVRRh
         WclVbITM5CMzu2urKnMnyLP2WlnALR4CwuFuY38ci3ilr3/HBNg4eGf9vw1hwALU2g
         fW4DAPi14b7emn6waDPmSaS3IV6I50VnJn5D1bLDCrq0h7ofj9dkKqlXIlF2CmtbVQ
         3NALgOJXSgSZw==
X-Nifty-SrcIP: [209.85.221.180]
Received: by mail-vk1-f180.google.com with SMTP id o187so1210636vkg.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 23:21:04 -0700 (PDT)
X-Gm-Message-State: APjAAAV7ZyqZZLqmLAEUuwbCeuEseWOA6j8LdU7EYSNEt6KJCNRwZGGL
        +yWpDq2tDxR0eQDKYuH73zbz+HQhljVxJVHEamM=
X-Google-Smtp-Source: APXvYqwru5xCITeIP3IDzXSiJdp/KtT+NW5kB4jgvyTrzGgF89HhvyXc3U41UDxZXmkplPVI3cWbBuu0U8mXmBp2XCY=
X-Received: by 2002:a1f:b297:: with SMTP id b145mr4163622vkf.74.1557469263784;
 Thu, 09 May 2019 23:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190507175912.GA11709@kroah.com> <CAHk-=wh=Uscp=yO1p===JjH3x9NS-ez+wrk64Z0pw7EGfWvVTA@mail.gmail.com>
In-Reply-To: <CAHk-=wh=Uscp=yO1p===JjH3x9NS-ez+wrk64Z0pw7EGfWvVTA@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 10 May 2019 15:20:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQd5+-+fcmy3PMH1V6eDckXaeibv_vVgP5GX5L7j-2nEw@mail.gmail.com>
Message-ID: <CAK7LNAQd5+-+fcmy3PMH1V6eDckXaeibv_vVgP5GX5L7j-2nEw@mail.gmail.com>
Subject: Re: [GIT PULL] Driver core patches for 5.2-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,


On Fri, May 10, 2019 at 5:50 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> [ Ok, this may look irrelevant to people, but I actually notice this
> because I do quick rebuilds *all* the time, so the 30s vs 41s
> difference is actually something I reacted to and then tried to figure
> out... ]
>
> On Tue, May 7, 2019 at 10:59 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > Joel Fernandes (Google) (2):
> >       Provide in-kernel headers to make extending kernel easier
>
> Joel and Masahiro,
>  this commit does annoying things. It's a small thing, but it ends up
> grating on my kernel rebuild times, so I hope somebody can take a look
> at it..
>
> Try building a kernel with no changes, and it shouldn't re-link.
>
> HOWEVER.
>
> If you re-make the config in between, the kernel/kheaders_data.tar.xz
> is re-generated too. I think it checks timestamps despite having that
> "CHK" phase that should verify just contents.
>
> I think the kernel/config_data.gz rules do the same thing, judging by
> the output.
>
> I use "make allmodconfig" to re-generate the same kernel config, which
> triggers this. The difference between "nothing changed" and "rerun
> 'make allmodconfig' and nothing _still_ should have changed" is quite
> stark:

Yeah, I have had this in my mind for a while.

If you run "make *config" and it happens to be creating
the exactly the same .config, Kconfig should not overwrite
it at all.

If you apply the following two,
I hope you will get the behavior you like.

https://patchwork.kernel.org/patch/10938255/
https://patchwork.kernel.org/patch/10938253/

(1/2 is just a cleanup because I am touching the
same hunk.)

Because I have not sent a Kconfig pull request yet
in the current MW, I will consider to merge them.

Thanks.


> - nothing changed: rebuild in less than 30s
>
>     [torvalds@i7 linux]$ time make -j32
>       DESCEND  objtool
>       CALL    scripts/atomic/check-atomics.sh
>       CALL    scripts/checksyscalls.sh
>       CHK     include/generated/compile.h
>       CHK     kernel/kheaders_data.tar.xz
>       Building modules, stage 2.
>     Kernel: arch/x86/boot/bzImage is ready  (#9)
>       MODPOST 7282 modules
>
>     real        0m29.379s
>     user        1m50.586s
>     sys 0m41.047s
>
> - do (the same) "make allmodconfig" in between, now rebuild time is
> just over 41s:
>
>     [torvalds@i7 linux]$ make allmodconfig
>
>     [torvalds@i7 linux]$ time make -j32
>     scripts/kconfig/conf  --syncconfig Kconfig
>       DESCEND  objtool
>       CALL    scripts/atomic/check-atomics.sh
>       CALL    scripts/checksyscalls.sh
>       CHK     include/generated/compile.h
>       GZIP    kernel/config_data.gz
>       CHK     kernel/kheaders_data.tar.xz
>       CC [M]  kernel/configs.o
>       GEN     kernel/kheaders_data.tar.xz
>       CC [M]  kernel/kheaders.o
>       Building modules, stage 2.
>     Kernel: arch/x86/boot/bzImage is ready  (#9)
>       MODPOST 7282 modules
>       LD [M]  kernel/configs.ko
>       LD [M]  kernel/kheaders.ko
>
>     real        0m41.326s
>     user        2m17.822s
>     sys 0m54.561s
>
> No, this isn't the end of the world, but if somebody sees a simple
> solution to avoid that extra ten seconds, I'd appreciate it.
>
>                   Linus



-- 
Best Regards
Masahiro Yamada
