Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F734C432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8F320833
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfLBNcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 08:32:41 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39021 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfLBNck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 08:32:40 -0500
Received: by mail-oi1-f196.google.com with SMTP id a67so13630655oib.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 05:32:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FUb7Rc+GIP9MKLEXkxhbaxhusHdmEduUo1Z+J1qlGCo=;
        b=QCngT7ECbbOr7x84sAPDWXTS38Wclwm4YzpxHuZ3YqUF8NQrKDuiZK2wBgQ5qh6wOO
         lSKeYbrz5r8jDLDsvoTAn8F10AGeKFYO9haKt9l2vyg94FlguoL/W7YnPsedKZ+saEw3
         A0LEFy6uxoTXLaihXyOvJbQnruGT5+4mDCom5qLANG5OKyoifeubBPJtb3fHrkEqucnb
         XmxNrXhiwQxOAgJ7ldXWTVr1L35dqyss7Ugm6qfx0M9uFUVqCE4rawGPc3fNMEsyw0kc
         iGGVWZDet6/J/l2i/3w2roFDgFhWK2fT+Ij2Cwo+6qR3UFgwjUvkfJ2lDL19Zdxr387O
         nMMw==
X-Gm-Message-State: APjAAAWv7c1m1g6E8pJYhhNJwSx3/X71knz0xooFYTiKMwNvVX6i64S+
        zdCCPw7TqPR5kADP+3ZtRAqNhDB/A3ZQtL3+6mM=
X-Google-Smtp-Source: APXvYqyCMxXLzeZ3RnbW9zza35sEQ4DWlDlwDArm/Dx7HkjU3qwX5haNiFPRwXfVX2mL+pSh+XgrY1BY0k87X19WS1c=
X-Received: by 2002:aca:fdd0:: with SMTP id b199mr11619204oii.153.1575293559910;
 Mon, 02 Dec 2019 05:32:39 -0800 (PST)
MIME-Version: 1.0
References: <021330b6-67a2-0b74-c129-5c725dd23810@infradead.org>
 <CAMuHMdVLusDDB5G1R7=-53sK1bd2+3=s42hr9xkgPtWyjOrozg@mail.gmail.com> <CACz-3rjOPg_rMt_FbJ5_nKLpjTK-Bv=amGsJpXwqbTBNX4YA7w@mail.gmail.com>
In-Reply-To: <CACz-3rjOPg_rMt_FbJ5_nKLpjTK-Bv=amGsJpXwqbTBNX4YA7w@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 2 Dec 2019 14:32:28 +0100
Message-ID: <CAMuHMdW1iqNkmCztAv93W4eLR5ooxh5m+vRLJHJmCfrjsOmc5g@mail.gmail.com>
Subject: Re: m68k Kconfig warning
To:     Kars de Jong <karsdejong@home.nl>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kars,.

On Mon, Dec 2, 2019 at 12:42 PM Kars de Jong <karsdejong@home.nl> wrote:
> Op wo 27 nov. 2019 om 08:12 schreef Geert Uytterhoeven <geert@linux-m68k.org>:
> > On Wed, Nov 27, 2019 at 2:27 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> > > Just noticed this.  I don't know what the right fix is.
> > > Would you take care of it, please?
> > >
> > > on Linux 5.4, m68k allmodconfig:
> > >
> > > WARNING: unmet direct dependencies detected for NEED_MULTIPLE_NODES
> > >   Depends on [n]: DISCONTIGMEM [=n] || NUMA
> > >   Selected by [y]:
> > >   - SINGLE_MEMORY_CHUNK [=y] && MMU [=y]
> >
> > This has been basically there forever, but working.
>
> The reason for SINGLE_MEMORY_CHUNK depending on NEED_MULTIPLE_NODES is
> historic due to the way it is implemented.
> I played with it this weekend and I got a working version of FLATMEM,
> which can replace SINGLE_MEMORY_CHUNK.

Nice, thanks!

> step might be to replace DISCONTIGMEM with SPARSEMEM (since
> DISCONTIGMEM has been deprecated).

Mike Rapoport has patches for that:
"[PATCH v2 0/3] m68k/mm: switch from DISCONTIGMEM to SPARSEMEM"

Unfortunately they're not on lore, and there were some issues with them.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
