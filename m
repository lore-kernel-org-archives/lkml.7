Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B75C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 02:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0FC21841
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 02:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="CSvmpxzP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbfEWCub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 22:50:31 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:45004 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbfEWCua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 22:50:30 -0400
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x4N2oFjD014618;
        Thu, 23 May 2019 11:50:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x4N2oFjD014618
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1558579816;
        bh=2/FugdO2450EGjLSvjVI5FNYBjL5g1ZfuRbjKTuspjk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CSvmpxzPkU2LHsR9dH7CWIjYKucvLevctvHA7v5ONetX796qRZ1xbCWNqGXa9XwVI
         vQAQo+KiE2WYWDesNWHle3/0jQGRB83XXCX/CXeXwmLJVoLdQjPiT+K+jnVhrhUfOu
         tm/HUoLPbtiXp7ykFzGxbzSU5T+Z0lqXgsIwhDeAl4oIeQRKv65HiawMrZhatj2GZ5
         pQz5REwF0Kej+deu7CvPaT0WUOxqgI7SZ2ITehIbGUYVPk/+u3nH9vLR7Ekk5c6mvg
         D/LkSQzS4ADtu3MOaEfRhUIT/SeD/df/vrdgfkSedUXQOOJOR354EprRyHbcDY5hNg
         pVQbw7zfgHPSA==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id d128so2646752vsc.10;
        Wed, 22 May 2019 19:50:16 -0700 (PDT)
X-Gm-Message-State: APjAAAXCqKNItr8XEFsj2X9svS0Hej9fNMpbYLl3yvpSNGuqsu2XTp5T
        Qhxd/NtX99s+ne+exBTi9cadK3//EBuRCs7Nb9k=
X-Google-Smtp-Source: APXvYqyyUQRDo34h8x9tqqKP8C5sThOQ4CucA4sp0PJzI8TeKi1Fk+k9xQaLmwClSBfAo0Z5KvKi8o5tYXUAshG+xqA=
X-Received: by 2002:a05:6102:3d9:: with SMTP id n25mr19610186vsq.181.1558579815029;
 Wed, 22 May 2019 19:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190521133257.GA21471@kroah.com> <CAK7LNASZWLwYC2E3vBkXhp7wt9zBWkFrR+NTnxTyLn1zO66a0w@mail.gmail.com>
 <eae2d0e80824cc84965c571a0ea097e14d3f498c.camel@perches.com>
In-Reply-To: <eae2d0e80824cc84965c571a0ea097e14d3f498c.camel@perches.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 23 May 2019 11:49:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ=M0ejV3C8bgjuMxdRR9v=2-GRdXeUjFR6URrrtYPCnA@mail.gmail.com>
Message-ID: <CAK7LNAQ=M0ejV3C8bgjuMxdRR9v=2-GRdXeUjFR6URrrtYPCnA@mail.gmail.com>
Subject: Re: [GIT PULL] SPDX update for 5.2-rc1 - round 1
To:     Joe Perches <joe@perches.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spdx@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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


I agree.


> If so, I'll submit a checkpatch patch.

That will be nice.


> I could also wire up a patch to checkpatch and docs to
> remove the /* */
> requirement for .h files and prefer
> the generic // form for both .c and
> .h files as the
> current minimum tooling versions now all allow //
> comments
> .

We have control for minimal tool versions for building the kernel,
so I think // will be OK for in-kernel headers.


On the other hand, I am not quite sure about UAPI headers.
We cannot define minimum tool versions
for building user-space.
Perhaps, using // in UAPI headers causes a problem
if an ancient compiler is used?


BTW, if we allow to use // in header files,
we have no reason to forbid // in assembly files either.

We use *.S files (assembly that should be preprocessed)
instead of *.s files.

So, comments are ripped off by CPP anyway
whichever comment style is used.


--
Best Regards
Masahiro Yamada
