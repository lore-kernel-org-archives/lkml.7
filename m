Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CD3C28CC7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 07:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F52527CD8
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 07:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559547518;
	bh=T2JMny2kFt/9IceLjTOY4zcyV5OvxWKmS/QBTDsKWeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LDuYdqGdkS/slH1y6x4paWQdW6q4rwYekF4DNpPotGTox2A5I1dP7ERLGo/iAH0GN
	 NlcrZyhO0jf/96ln2yARrY0DMfs6C+TQCr3ul2PVE8QiJNTNz6ozdGDtCyyoVPVDAG
	 O87ZMokQxtd/Nko777WqWva+YZxdVu5iyH4nNGrY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfFCHih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 03:38:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbfFCHih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 03:38:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AB5727C84;
        Mon,  3 Jun 2019 07:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559547516;
        bh=T2JMny2kFt/9IceLjTOY4zcyV5OvxWKmS/QBTDsKWeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uyWte2wXI2BYh317jl8TvSdx+eLeUAOtlGEGOS+j4q/PE/zvsI59CPSEx535xvC7Z
         5cqpUV721T9PYqd+Z6HrqDT2Hdo5y/ZTuynLCY1n1yw8UbINuPXMvWWNjnS3XW6h5W
         QjVrkas7Pw/e5mU/MaPqdSw0FDvTp1vM6dk9+rN0=
Date:   Mon, 3 Jun 2019 09:38:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spdx@vger.kernel.org
Subject: Re: [GIT PULL] SPDX update for 5.2-rc3 - round 2
Message-ID: <20190603073833.GA20329@kroah.com>
References: <20190602063905.GA14513@kroah.com>
 <CAK7LNAQf7difmgLo3OmEHCEvODaU3zoXLA8mKcyVL7NdCcZD=w@mail.gmail.com>
 <20190602171531.GF19671@kroah.com>
 <CAK7LNARDyZ1pKHwiHsOntbc9oxbGHgbD+tptEF4a0VC3GvAyTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARDyZ1pKHwiHsOntbc9oxbGHgbD+tptEF4a0VC3GvAyTA@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 09:15:08AM +0900, Masahiro Yamada wrote:
> On Mon, Jun 3, 2019 at 2:15 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sun, Jun 02, 2019 at 09:03:46PM +0900, Masahiro Yamada wrote:
> > > On Sun, Jun 2, 2019 at 4:17 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > The following changes since commit 2f4c53349961c8ca480193e47da4d44fdb8335a8:
> > > >
> > > >   Merge tag 'spdx-5.2-rc3-1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core (2019-05-31 08:34:32 -0700)
> > > >
> > > > are available in the Git repository at:
> > > >
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/spdx-5.2-rc3-2
> > > >
> > > > for you to fetch changes up to 8e82fe2ab65a80b1526b285c661ab88cc5891e3a:
> > > >
> > > >   treewide: fix typos of SPDX-License-Identifier (2019-06-01 18:29:58 +0200)
> > > >
> > > > ----------------------------------------------------------------
> > > > SPDX fixes for 5.2-rc3, round 2
> > > >
> > > > Here are just two small patches, that fix up some found SPDX identifier
> > > > issues.
> > > >
> > > > The first patch fixes an error in a previous SPDX fixup patch, that
> > > > causes build errors when doing 'make clean' on the tree (the fact that
> > > > almost no one noticed it reflects the fact that kernel developers don't
> > > > like doing that option very often...)
> > >
> > > This paragraph is not precise.
> > >
> > > Not only "make clean", but also the normal build is broken.
> > > In fact, ARCH=arm allmodconfig is broken.
> > >
> > >
> > > $ make -j8 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- allmodconfig
> > >   [ snip ]
> > > $ make -j8 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-
> > >   [ snip ]
> > > drivers/crypto/ux500/cryp/Makefile:5: *** missing separator.  Stop.
> > > make[3]: *** [scripts/Makefile.build;489: drivers/crypto/ux500/cryp] Error 2
> > > make[2]: *** [scripts/Makefile.build;489: drivers/crypto/ux500] Error 2
> > > make[1]: *** [scripts/Makefile.build;489: drivers/crypto] Error 2
> > > make[1]: *** Waiting for unfinished jobs....
> > >
> > >
> > >
> > > The 0-day bot should check allmodconfig for all arches,
> > > but surprisingly it was not caught before the merge.
> >
> > Ah, good catch, odd that 0-day missed it.  Maybe it is not building
> > 32bit builds these days :(
> 
> 
> I noticed the SPDX patches were submitted to
> linux-spdx@vger.kernel.org
> but not to linux-kernel@vger.kernel.org
> 
> Maybe, the reason is why 0-day bot is not subscribing to
> linux-spdx@vger.kernel.org
> 
> 
> You picked up them and sent a pull request immediately,
> so the 0-day bot was not given time to test your branch either.

No, I got a response from the 0-day bot, it said it tested my branch but
timed out doing more tests because it was busy.  It seems the bot is not
working that well at the moment as it is giving me this same "limited"
testing for all of my trees right now :(

> >> Not all developers run scripts/checkpatch.pl before patch submission.
> >> Not all maintainers run scripts/checkpatch.pl before commit.
> >
> >Very true :(
> 
> 
> If we really want to improve the situation,
> perhaps can we ask Intel to run scripts/checkpatch.pl in the 0-day bot?
> 
> checkpatch.pl may warn false positives,
> but at least "Missing or malformed SPDX-License-Identifier tag"
> is a good checker.  Just my two cents.

Sounds like something good to be added to 0-day, please propose it to
the developers.  But let them fix whatever is currently not working with
it first :)

thanks,

greg k-h
