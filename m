Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F82C48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC0A20644
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 11:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="oDCIID4e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbfFYLUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 07:20:14 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:63109 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfFYLUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 07:20:14 -0400
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x5PBK6p4021676;
        Tue, 25 Jun 2019 20:20:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x5PBK6p4021676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1561461608;
        bh=EozDTvKOHcxfsnch/gqc5P65unHEyuMQ8uubcxmAZlM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oDCIID4eTViowrKJm64kltyop6/yXFi4a2ne2EJNdeKBsXlpbk5LAz3XmX8AfmWfL
         8CEq6IaPuCWnSpZWOWIiPr4CMraGKriEV0dr/scssIAkOoQ4tPdFZf/sWcGHhTErgP
         uzz7xpwO38q+fHoB2SXfUDAGFds07jvr0L1ZGEE2+BxDxyNrHQwPE091iWCJKZFQ8y
         CqAd43sbpPvZu06lGYYH6os07MhVCFJkVJ746HU7Fk8AcSr5M03G/W5iv5nQ1LUlU4
         6ol4CQkJwTNbK2DDUBsnbh7qseqlivtSp/+N+V3oqdTU24RpIXXVYcI13t2Ave4WyT
         Ufl80JYYkOmjg==
X-Nifty-SrcIP: [209.85.217.51]
Received: by mail-vs1-f51.google.com with SMTP id l20so10627514vsp.3;
        Tue, 25 Jun 2019 04:20:07 -0700 (PDT)
X-Gm-Message-State: APjAAAWqI4Elr7cLz+KisnO7gADGdW7IGrFIequShb6IrkeVZx50whlA
        Q3htS0g83M4P49MV0mE91fjbPuY796F2c1iJUeg=
X-Google-Smtp-Source: APXvYqz4C0jEV6JsmnAwXrS5jug/6D8+RpgLCkFumref4bUDIhrX+Gv/FiXLBqM2LQNc5AGO2JH8aSjrMd1YVy1QTpw=
X-Received: by 2002:a67:cd1a:: with SMTP id u26mr46893396vsl.155.1561461606319;
 Tue, 25 Jun 2019 04:20:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190521133257.GA21471@kroah.com> <CAK7LNASZWLwYC2E3vBkXhp7wt9zBWkFrR+NTnxTyLn1zO66a0w@mail.gmail.com>
 <eae2d0e80824cc84965c571a0ea097e14d3f498c.camel@perches.com>
In-Reply-To: <eae2d0e80824cc84965c571a0ea097e14d3f498c.camel@perches.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 25 Jun 2019 20:19:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNASR_vJS13GjZmqMC0DSO=kTVNprpsRgtK4QSLExRUQFtg@mail.gmail.com>
Message-ID: <CAK7LNASR_vJS13GjZmqMC0DSO=kTVNprpsRgtK4QSLExRUQFtg@mail.gmail.com>
Subject: Re: [GIT PULL] SPDX update for 5.2-rc1 - round 1
To:     Joe Perches <joe@perches.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spdx@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Wed, May 22, 2019 at 3:37 PM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2019-05-22 at 13:32 +0900, Masahiro Yamada wrote:
> > On Tue, May 21, 2019 at 10:34 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> []
> > >  - Add GPL-2.0-only or GPL-2.0-or-later tags to files where our scan
> > >     tools can determine the license text in the file itself.  Where this
> > >     happens, the license text is removed, in order to cut down on the
> > >     700+ different ways we have in the kernel today, in a quest to get
> > >     rid of all of these.
> []
> > I have been wondering for a while
> > which version of spdx tags I should use in my work.
> >
> > I know the 'GPL-2.0' tag is already deprecated.
> > (https://spdx.org/licenses/GPL-2.0.html)
> >
> > But, I saw negative reaction to this:
> > https://lore.kernel.org/patchwork/patch/975394/
> >
> > Nor "-only" / "-or-later" are documented in
> > Documentation/process/license-rules.rst
> >
> > In this patch series, Thomas used 'GPL-2.0-only' and 'GPL-2.0-or-later'
> > instead of 'GPL-2.0' and 'GPL-2.0+'.
> >
> > Now, we have a great number of users of spdx v3 tags.
> > $ git grep -P 'SPDX-License-Identifier.*(?:-or-later|-only)'| wc -l
> > 4135
> > So, what I understood is:
> >
> >   For newly added tags, '*-only' and '*-or-later' are preferred.
> >
> > (But, we do not convert existing spdx v2 tags globally.)
> >
> >
> > "
> > Joe's patch was not merged, but at least
> > Documentation/process/license-rules.rst
> > should be updated in my opinion.
> >
> > (Perhaps, checkpatch.pl can suggest newer tags in case
> > patch submitters do not even know that deprecation.)
>
> I'd still prefer the kernel use of a single SPDX style.
>
> I don't know why the -only and -or-later forms were
> used for this patch, but I like it.
>
> I believe the -only and -or-later are more intelligible
> as a trivial reading of
>
>         SPDX-License-Identifier: GPL-2.0
>
> would generally mean to me the original
> GPL-2.0 license without the elision of the
> (or at your option, any later version) bits
>
> whereas
>
>         SPDX-License-Identifier: GPL-2.0-only
>
> seems fairly descriptive.
>
> Is it agreed that the GPL-<v>-only and GPL-<v>-or-later
> forms should be preferred for new SPDX identifiers?
>
> If so, I'll submit a checkpatch patch.


Could you send a patch to update checkpatch and doc ?

Similar discussion here too.
https://lkml.org/lkml/2019/5/31/456

We need better documentation to stop wasting time for this.

This should be separated from the
 /* ... */  vs // discussion.


Thanks.


> I could also wire up a patch to checkpatch and docs to
> remove the /* */
> requirement for .h files and prefer
> the generic // form for both .c and
> .h files as the
> current minimum tooling versions now all allow //
> comments
> .
>
>


-- 
Best Regards
Masahiro Yamada
