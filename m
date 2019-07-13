Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA50C31E40
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 23:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CCBB20838
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 23:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Yi45kjJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbfGMXiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 19:38:50 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:28066 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbfGMXiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 19:38:50 -0400
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x6DNcX9K025044
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 08:38:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x6DNcX9K025044
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563061113;
        bh=D9pbrTjD/dqwhKk+y191+uZ3i09jNpt6GI//YlslbF8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Yi45kjJ9Xi1GBrQP0nXFXp0GUfcXqp+UcTTseShibnFC1HG4WUKXycYdh0GoBXRHo
         eCHyDbpAks+9Yf0XW6ws28Y2Ojpf3hTK8b3clztcgMrErt9eftNh86sXE4XkAXxgQL
         4V+lVkGoXi4H9vdE/WuSJBB9IdyO38s52HzojFC9pDW+rv6OZ6wXwrXfWmiqxT+bIE
         PhIaJWkGZdQBZjc+h35Eek2bP2N34DLWyXiraYzjD/TFlkjqMZ8dqsiwUiyt353eXJ
         7QvxlEGGPMFPwSpr1CsTGqEQ5L7PfyPlJMcSRiLnf+3/oEKYwlIB1zTKR2s2BUi70e
         UGrOO47gZgpgw==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id h28so9030161vsl.12
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2019 16:38:33 -0700 (PDT)
X-Gm-Message-State: APjAAAWWtpY6EHsQGAo/cZEWpS4WYSvpLxJpw/8/Z00MMRPUoRNOi2mS
        YhS0D0DfTuQzEmp8I3oP6y4kinMhg9PwDxre1lM=
X-Google-Smtp-Source: APXvYqz7FXm0oP6FGHZYY9YFOlW2+XjgzCe0Da31HjR1aO7rfcVxizTh3hB+rg2GzOLhrBD7CGGk1PNa5nbX0jMXBgg=
X-Received: by 2002:a67:f495:: with SMTP id o21mr12562362vsn.54.1563061112478;
 Sat, 13 Jul 2019 16:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190618030926.30616-1-yamada.masahiro@socionext.com>
 <1318390798.95477.1560838785550.JavaMail.zimbra@nod.at> <CAK7LNARA62uqi8rkDeJ=zjA6vnruTAH2VGOBd4=sQMhF+FHMLA@mail.gmail.com>
 <957967732.18164.1561621143523.JavaMail.zimbra@nod.at>
In-Reply-To: <957967732.18164.1561621143523.JavaMail.zimbra@nod.at>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 14 Jul 2019 08:37:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQLheA3E0UrjirNHzpS2x+xmjc2YCupCBMNoHOwviz6GQ@mail.gmail.com>
Message-ID: <CAK7LNAQLheA3E0UrjirNHzpS2x+xmjc2YCupCBMNoHOwviz6GQ@mail.gmail.com>
Subject: Re: [PATCH v2] jffs2: remove C++ style comments from uapi header
To:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 4:39 PM Richard Weinberger <richard@nod.at> wrote:
>
> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Masahiro Yamada" <yamada.masahiro@socionext.com>
> > An: "richard" <richard@nod.at>
> > CC: "Vignesh Raghavendra" <vigneshr@ti.com>, "Boris Brezillon" <bbrezil=
lon@kernel.org>, "linux-kernel"
> > <linux-kernel@vger.kernel.org>, "Marek Vasut" <marek.vasut@gmail.com>, =
"linux-mtd" <linux-mtd@lists.infradead.org>,
> > "Miquel Raynal" <miquel.raynal@bootlin.com>, "Brian Norris" <computersf=
orpeace@gmail.com>, "David Woodhouse"
> > <dwmw2@infradead.org>
> > Gesendet: Donnerstag, 27. Juni 2019 09:06:31
> > Betreff: Re: [PATCH v2] jffs2: remove C++ style comments from uapi head=
er
>
> > On Tue, Jun 18, 2019 at 3:20 PM Richard Weinberger <richard@nod.at> wro=
te:
> >>
> >> ----- Urspr=C3=BCngliche Mail -----
> >> > Von: "Masahiro Yamada" <yamada.masahiro@socionext.com>
> >> > An: "linux-mtd" <linux-mtd@lists.infradead.org>
> >> > CC: "Boris Brezillon" <bbrezillon@kernel.org>, "Miquel Raynal"
> >> > <miquel.raynal@bootlin.com>, "Brian Norris"
> >> > <computersforpeace@gmail.com>, "Vignesh Raghavendra" <vigneshr@ti.co=
m>, "Marek
> >> > Vasut" <marek.vasut@gmail.com>,
> >> > "Masahiro Yamada" <yamada.masahiro@socionext.com>, "richard" <richar=
d@nod.at>,
> >> > "David Woodhouse" <dwmw2@infradead.org>,
> >> > "linux-kernel" <linux-kernel@vger.kernel.org>
> >> > Gesendet: Dienstag, 18. Juni 2019 05:09:26
> >> > Betreff: [PATCH v2] jffs2: remove C++ style comments from uapi heade=
r
> >>
> >> > Linux kernel tolerates C++ style comments these days. Actually, the
> >> > SPDX License tags for .c files start with //.
> >> >
> >> > On the other hand, uapi headers are written in more strict C, where
> >> > the C++ comment style is forbidden.
> >> >
> >> > I simply dropped these lines instead of fixing the comment style.
> >> >
> >> > This code has been always commented out since it was added around
> >> > Linux 2.4.9 (i.e. commented out for more than 17 years).
> >> >
> >> > 'Maybe later...' will never happen.
> >>
> >> :-)
> >>
> >> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >>
> >> Acked-by: Richard Weinberger <richard@nod.at>
> >>
> >> Thanks,
> >> //richard
> >
> >
> > Will this be picked up for v5.3-rc1 ?
>
> Yes.
>
> Thanks,
> //richard



Looks like this trivial patch missed the pull request.


My motivation is to make sure UAPI headers
are really compilable in user-space,
and now checked by the following commit:

commit d6fc9fcbaa655cff2d2be05e16867d1918f78b85
Author: Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon Jul 1 09:58:40 2019 +0900

    kbuild: compile-test exported headers to ensure they are self-contained



Is there a chance for it being merged,
or must wait until v5.4-rc1 ?



--=20
Best Regards
Masahiro Yamada
