Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC34EC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78AAA2084B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 07:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="DCf6AIsR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfF0HHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 03:07:21 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:65381 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfF0HHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 03:07:20 -0400
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x5R778ra019578
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 16:07:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x5R778ra019578
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1561619228;
        bh=gj7s9w7UjXz0QHPHPCGEcB7DjBVPqUTYuZyU7sdAJGw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DCf6AIsRzYlp5t1zwsJPkD6eGEu5QWqqV/2eaydEHdB15Wg8YhM883tol3tJU+a2M
         lYJpBrRLro0MO5aKXO9saaQHvF8WJ8YoJxlD7R4Yiq3xPX3bEtgMGzpawIClNyDgoO
         QnZdjfD0eiSXx9hqTNffy/Q8bjJbDK2NSGfPY47AE0fFlk6qP+NchGA/2SmgTbky1t
         xVftm4d5SfI8cCvOADNu6IyxC46BVTflQxaYo8817ZVoW9azbu1jtt+2Ij2vaggPwk
         10Am7HZ7CiWvTvOpaEH96Rg7j/7aHqjNPSCVNqNYm5Szc0Ato0iwBTREBUQ14kgwAy
         DnmNRgW9t8Kjg==
X-Nifty-SrcIP: [209.85.222.43]
Received: by mail-ua1-f43.google.com with SMTP id o2so446781uae.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 00:07:08 -0700 (PDT)
X-Gm-Message-State: APjAAAUzW9OtB08VtBjZIdYPRPsjhIzsR4I9NqhD9VjFbkZvf39yJAm5
        bW34D3owarFE4+ijaa0orMFk+z9z77rD8MWG3SY=
X-Google-Smtp-Source: APXvYqx824GHdql4BE5NM/JzpgGc4JoQsrkCC8hqQAOm3UzXYSdRRi1zarQ28eOqavgTIxG4QWRhxiFU9drmOTEF+WY=
X-Received: by 2002:ab0:70d9:: with SMTP id r25mr880005ual.109.1561619227668;
 Thu, 27 Jun 2019 00:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190618030926.30616-1-yamada.masahiro@socionext.com> <1318390798.95477.1560838785550.JavaMail.zimbra@nod.at>
In-Reply-To: <1318390798.95477.1560838785550.JavaMail.zimbra@nod.at>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 27 Jun 2019 16:06:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNARA62uqi8rkDeJ=zjA6vnruTAH2VGOBd4=sQMhF+FHMLA@mail.gmail.com>
Message-ID: <CAK7LNARA62uqi8rkDeJ=zjA6vnruTAH2VGOBd4=sQMhF+FHMLA@mail.gmail.com>
Subject: Re: [PATCH v2] jffs2: remove C++ style comments from uapi header
To:     Richard Weinberger <richard@nod.at>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 3:20 PM Richard Weinberger <richard@nod.at> wrote:
>
> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Masahiro Yamada" <yamada.masahiro@socionext.com>
> > An: "linux-mtd" <linux-mtd@lists.infradead.org>
> > CC: "Boris Brezillon" <bbrezillon@kernel.org>, "Miquel Raynal" <miquel.=
raynal@bootlin.com>, "Brian Norris"
> > <computersforpeace@gmail.com>, "Vignesh Raghavendra" <vigneshr@ti.com>,=
 "Marek Vasut" <marek.vasut@gmail.com>,
> > "Masahiro Yamada" <yamada.masahiro@socionext.com>, "richard" <richard@n=
od.at>, "David Woodhouse" <dwmw2@infradead.org>,
> > "linux-kernel" <linux-kernel@vger.kernel.org>
> > Gesendet: Dienstag, 18. Juni 2019 05:09:26
> > Betreff: [PATCH v2] jffs2: remove C++ style comments from uapi header
>
> > Linux kernel tolerates C++ style comments these days. Actually, the
> > SPDX License tags for .c files start with //.
> >
> > On the other hand, uapi headers are written in more strict C, where
> > the C++ comment style is forbidden.
> >
> > I simply dropped these lines instead of fixing the comment style.
> >
> > This code has been always commented out since it was added around
> > Linux 2.4.9 (i.e. commented out for more than 17 years).
> >
> > 'Maybe later...' will never happen.
>
> :-)
>
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Acked-by: Richard Weinberger <richard@nod.at>
>
> Thanks,
> //richard


Will this be picked up for v5.3-rc1 ?



--=20
Best Regards
Masahiro Yamada
