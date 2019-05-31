Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5DAC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 14:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00E1F26B2F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 14:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfEaO6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 10:58:37 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38922 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfEaO6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 10:58:36 -0400
Received: by mail-oi1-f196.google.com with SMTP id v2so7924856oie.6;
        Fri, 31 May 2019 07:58:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m/iSMyUL9SEWCc7wCGYyJ//UVZgPKdoeEpVnczdvNmU=;
        b=W9HwAwtvY100ISNn0PkFcr+IGKqqVMjTPzUR4nStUn16q0a4EHCaeSGN8ZFPOhmBa+
         Fd6MPYMm1g7kRtDo9GXgFBP9ZIVD0N1eCzoVk5YJc6BxkOHzR0ulEPbY+MIQlQ/w/eOX
         JaN0MeKA+8yrCmWvuOk0RHw0NOHyw2Bab7xO668ndAGNAw7LbAG8BRx68Z76J9s/JJaR
         7FIAjIv6ooEuLoEWq+Clwv7LRyY7A2QXGdE1pHZ8rfUqSOgXxl8r72SmOt3/bANrrTYS
         oRncZ7xyO+/lbFo4mbKNCmBu+8C48yReHWZ9WP9ndfzZ2IV4eT9Oaqg+is4PbEb91Jjk
         TkHg==
X-Gm-Message-State: APjAAAWIG3sQGl1f56d78OqofakkUUcwqlksj49FMDfiCL0+Z3XpMWI5
        V7TPD7nLpTawjbZx1DEuNOx4x/dP/WzZkQNCf3o=
X-Google-Smtp-Source: APXvYqyylVFIBBoiDTwyq6KIWTkz8i/otAPKvGPy+gU590207yj550TEgKwx+0JL1pKqEcybwJxIrw1BX+8V2ddH/+Q=
X-Received: by 2002:aca:330b:: with SMTP id z11mr6124109oiz.148.1559314715666;
 Fri, 31 May 2019 07:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190531014808.GA30932@kroah.com> <CAMuHMdV=95sKB+h_pf45DiYeiJzrk1L=014Tj8Y04_hPyRMBNQ@mail.gmail.com>
 <20190531132400.GA5518@kroah.com> <CAMuHMdX3vQN5tF4-_vGjRQGdbxpPC+u4g-QU45=qykNZgwSj_w@mail.gmail.com>
 <20190531140209.GA31961@kroah.com>
In-Reply-To: <20190531140209.GA31961@kroah.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 31 May 2019 16:58:22 +0200
Message-ID: <CAMuHMdUYTaDS+bJpchsUyc+xNPJeYoxQ3vozQUPH=gacFEcdFw@mail.gmail.com>
Subject: Re: [GIT PULL] SPDX update for 5.2-rc3 - round 1
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spdx@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Fri, May 31, 2019 at 4:02 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> On Fri, May 31, 2019 at 03:51:18PM +0200, Geert Uytterhoeven wrote:
> > On Fri, May 31, 2019 at 3:24 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > On Fri, May 31, 2019 at 09:17:06AM +0200, Geert Uytterhoeven wrote:
> > > > On Fri, May 31, 2019 at 3:49 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > The following changes since commit cd6c84d8f0cdc911df435bb075ba22ce3c605b07:
> > > > >
> > > > >   Linux 5.2-rc2 (2019-05-26 16:49:19 -0700)
> > > > >
> > > > > are available in the Git repository at:
> > > > >
> > > > >   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/spdx-5.2-rc3-1
> > > > >
> > > > > for you to fetch changes up to 96ac6d435100450f0565708d9b885ea2a7400e0a:
> > > > >
> > > > >   treewide: Add SPDX license identifier - Kbuild (2019-05-30 11:32:33 -0700)
> > > > >
> > > > > ----------------------------------------------------------------
> > > > > SPDX update for 5.2-rc3, round 1
> > > > >
> > > > > Here is another set of reviewed patches that adds SPDX tags to different
> > > > > kernel files, based on a set of rules that are being used to parse the
> > > > > comments to try to determine that the license of the file is
> > > > > "GPL-2.0-or-later" or "GPL-2.0-only".  Only the "obvious" versions of
> > > > > these matches are included here, a number of "non-obvious" variants of
> > > > > text have been found but those have been postponed for later review and
> > > > > analysis.
> > > > >
> > > > > There is also a patch in here to add the proper SPDX header to a bunch
> > > > > of Kbuild files that we have missed in the past due to new files being
> > > > > added and forgetting that Kbuild uses two different file names for
> > > > > Makefiles.  This issue was reported by the Kbuild maintainer.
> > > > >
> > > > > These patches have been out for review on the linux-spdx@vger mailing
> > > > > list, and while they were created by automatic tools, they were
> > > > > hand-verified by a bunch of different people, all whom names are on the
> > > > > patches are reviewers.
> > > > >
> > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > >
> > > > I'm sorry, but as long[*] as this does not conform to
> > > > Documentation/process/license-rules.rst, I have to provide my:
> > > > NAked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > >
> > > > [*] The obvious solution is to update Documentation/process/license-rules.rst,
> > > >     as people have asked before.
> > >
> > > I don't understand, what does not conform?  We are trying _to_ conform
> > > to that file, what did we do wrong?
> >
> > The new "-or-later" and "-only" variants are not (yet) documented in that file.
> >
> >    File format examples::
> >
> >       Valid-License-Identifier: GPL-2.0
> >       Valid-License-Identifier: GPL-2.0+
> >       SPDX-URL: https://spdx.org/licenses/GPL-2.0.html
> >       Usage-Guide:
> >         To use this license in source code, put one of the following SPDX
> >         tag/value pairs into a comment according to the placement
> >         guidelines in the licensing rules documentation.
> >         For 'GNU General Public License (GPL) version 2 only' use:
> >           SPDX-License-Identifier: GPL-2.0
> >         For 'GNU General Public License (GPL) version 2 or any later
> > version' use:
> >           SPDX-License-Identifier: GPL-2.0+
>
>
> They do not have to be documented in that file.  As what you quoted
> said, "File format examples::"

My bad, I should have quoted the syntax rule:

   License identifiers for licenses like [L]GPL with the 'or later' option
   are constructed by using a "+" for indicating the 'or later' option.::

      // SPDX-License-Identifier: GPL-2.0+
      // SPDX-License-Identifier: LGPL-2.1+

Yes, this also predates the notion of "-only", so that is not documented
there.

> Please look in the files in the LICENSES directory for what all of the
> documented identifiers should look like:
>         $ head -n 4 LICENSES/preferred/GPL-2.0
>         Valid-License-Identifier: GPL-2.0
>         Valid-License-Identifier: GPL-2.0-only
>         Valid-License-Identifier: GPL-2.0+
>         Valid-License-Identifier: GPL-2.0-or-later

Oh, so we can no longer look it up in a single place :-(
I'm used to grepping in Documentation/process/license-rules.rst,
as I don't know the exact syntax by heart.

> If you want, please send a patch to fix up the documentation example,
> but it is not incorrect :)

May do, when I find a hole in my time/space continuum...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
