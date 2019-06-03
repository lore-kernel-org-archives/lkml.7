Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFE2C46470
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 00:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6641827A38
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 00:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Mougfo3C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfFCAP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 20:15:58 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:54192 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFCAP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 20:15:58 -0400
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x530FiAd022668;
        Mon, 3 Jun 2019 09:15:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x530FiAd022668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1559520945;
        bh=G2qNrJUov4dXP8u2Wgpy7sptEX3KgQf9n5SB1pe4Vr0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Mougfo3CiajI2QqTrKWVDBbynINcsDyE3u+jZ5QuM7fclkoc4oNS6vFEaT/nlIrDT
         RNdQFEyjLJD4jMZsJsC6E7FdZ0G9h7P44xqxEgHkW308pza8HowCfGW5fMSk80866F
         1b1Oo6r27Z86F+BraRKKdHLp2i5bSHavaddsYhFBQuyfKrHhJb+hzzYQGF4wfjAK5Q
         7CWn5FKKMLKlMBnma4tEqvM7PYgw08rP4o6UJ+wvwOg2OVw5c8wKGwxhcoJ/is5FH9
         JMtZwZC/xkHYg2qU8UDqCXKn3A2xPBS0QMeyJaIN9GJov4dqTBtFp0mozlsXgHAf7y
         hpnwHAzEpXRuQ==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id e25so233850vsk.2;
        Sun, 02 Jun 2019 17:15:45 -0700 (PDT)
X-Gm-Message-State: APjAAAW8jQ/otMWnRCBHyUdvcqxCa52uCalPBG+5SVwUUgixFG3viGpf
        KDOXS8iY0FjvPh+p+T8EJ0iR949qgGJZ+jKFuzQ=
X-Google-Smtp-Source: APXvYqwbGAmhFHnXZVVrPzb4X4TiJOB9fH3CJzes6SoSXu1Fxsox/oQsJKs3z5OrOgH6SZTocfpnYtzHn0RAp8QS1NE=
X-Received: by 2002:a67:1842:: with SMTP id 63mr323653vsy.179.1559520944259;
 Sun, 02 Jun 2019 17:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190602063905.GA14513@kroah.com> <CAK7LNAQf7difmgLo3OmEHCEvODaU3zoXLA8mKcyVL7NdCcZD=w@mail.gmail.com>
 <20190602171531.GF19671@kroah.com>
In-Reply-To: <20190602171531.GF19671@kroah.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 3 Jun 2019 09:15:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNARDyZ1pKHwiHsOntbc9oxbGHgbD+tptEF4a0VC3GvAyTA@mail.gmail.com>
Message-ID: <CAK7LNARDyZ1pKHwiHsOntbc9oxbGHgbD+tptEF4a0VC3GvAyTA@mail.gmail.com>
Subject: Re: [GIT PULL] SPDX update for 5.2-rc3 - round 2
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

On Mon, Jun 3, 2019 at 2:15 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, Jun 02, 2019 at 09:03:46PM +0900, Masahiro Yamada wrote:
> > On Sun, Jun 2, 2019 at 4:17 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > The following changes since commit 2f4c53349961c8ca480193e47da4d44fdb8335a8:
> > >
> > >   Merge tag 'spdx-5.2-rc3-1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core (2019-05-31 08:34:32 -0700)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/spdx-5.2-rc3-2
> > >
> > > for you to fetch changes up to 8e82fe2ab65a80b1526b285c661ab88cc5891e3a:
> > >
> > >   treewide: fix typos of SPDX-License-Identifier (2019-06-01 18:29:58 +0200)
> > >
> > > ----------------------------------------------------------------
> > > SPDX fixes for 5.2-rc3, round 2
> > >
> > > Here are just two small patches, that fix up some found SPDX identifier
> > > issues.
> > >
> > > The first patch fixes an error in a previous SPDX fixup patch, that
> > > causes build errors when doing 'make clean' on the tree (the fact that
> > > almost no one noticed it reflects the fact that kernel developers don't
> > > like doing that option very often...)
> >
> > This paragraph is not precise.
> >
> > Not only "make clean", but also the normal build is broken.
> > In fact, ARCH=arm allmodconfig is broken.
> >
> >
> > $ make -j8 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- allmodconfig
> >   [ snip ]
> > $ make -j8 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-
> >   [ snip ]
> > drivers/crypto/ux500/cryp/Makefile:5: *** missing separator.  Stop.
> > make[3]: *** [scripts/Makefile.build;489: drivers/crypto/ux500/cryp] Error 2
> > make[2]: *** [scripts/Makefile.build;489: drivers/crypto/ux500] Error 2
> > make[1]: *** [scripts/Makefile.build;489: drivers/crypto] Error 2
> > make[1]: *** Waiting for unfinished jobs....
> >
> >
> >
> > The 0-day bot should check allmodconfig for all arches,
> > but surprisingly it was not caught before the merge.
>
> Ah, good catch, odd that 0-day missed it.  Maybe it is not building
> 32bit builds these days :(


I noticed the SPDX patches were submitted to
linux-spdx@vger.kernel.org
but not to linux-kernel@vger.kernel.org

Maybe, the reason is why 0-day bot is not subscribing to
linux-spdx@vger.kernel.org


You picked up them and sent a pull request immediately,
so the 0-day bot was not given time to test your branch either.



>> Not all developers run scripts/checkpatch.pl before patch submission.
>> Not all maintainers run scripts/checkpatch.pl before commit.
>
>Very true :(


If we really want to improve the situation,
perhaps can we ask Intel to run scripts/checkpatch.pl in the 0-day bot?

checkpatch.pl may warn false positives,
but at least "Missing or malformed SPDX-License-Identifier tag"
is a good checker.  Just my two cents.

-- 
Best Regards
Masahiro Yamada
