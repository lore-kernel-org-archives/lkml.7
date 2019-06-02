Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6193EC28CC6
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 17:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2322798D
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 17:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559495735;
	bh=iKIo93UeJ437K4irUmndYQOjZYcRPejH0B2PixPv/8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XcLbnK5n/esrKXakI4jYRs4tMcS0PnbXvb1f3OyJjt5JjRREqGn6RAvHw2t/3iVGo
	 2sJsGxLPGRsTdtFS0+ZwjFM9RzvkdohNMRbNC1LLpHZmoZvl5xim+Uyn/KdP2Jqgsp
	 xwSkzLm2NFc/caqjtHyygUYCZbUXG2G5DiNEyhww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfFBRPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 13:15:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbfFBRPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 13:15:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBC0F2798C;
        Sun,  2 Jun 2019 17:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559495733;
        bh=iKIo93UeJ437K4irUmndYQOjZYcRPejH0B2PixPv/8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dM9LC8+DmMT6anTs5JrPomeWrfyAuYEk3PrDXE1TMXu+1RrNhP2kKj8YCoj0ZPJBy
         Y1ABbXGwgBf/M+nVi4qrBs26We6vrL9NBFFpGIQYnjb1b6nk018Dip4piYW8koN7Dz
         VIFfuyj1Zwuo7YNWjqPkTYgQa2CIa7EkvXLBjWNw=
Date:   Sun, 2 Jun 2019 19:15:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spdx@vger.kernel.org
Subject: Re: [GIT PULL] SPDX update for 5.2-rc3 - round 2
Message-ID: <20190602171531.GF19671@kroah.com>
References: <20190602063905.GA14513@kroah.com>
 <CAK7LNAQf7difmgLo3OmEHCEvODaU3zoXLA8mKcyVL7NdCcZD=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAQf7difmgLo3OmEHCEvODaU3zoXLA8mKcyVL7NdCcZD=w@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 02, 2019 at 09:03:46PM +0900, Masahiro Yamada wrote:
> On Sun, Jun 2, 2019 at 4:17 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > The following changes since commit 2f4c53349961c8ca480193e47da4d44fdb8335a8:
> >
> >   Merge tag 'spdx-5.2-rc3-1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core (2019-05-31 08:34:32 -0700)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/spdx-5.2-rc3-2
> >
> > for you to fetch changes up to 8e82fe2ab65a80b1526b285c661ab88cc5891e3a:
> >
> >   treewide: fix typos of SPDX-License-Identifier (2019-06-01 18:29:58 +0200)
> >
> > ----------------------------------------------------------------
> > SPDX fixes for 5.2-rc3, round 2
> >
> > Here are just two small patches, that fix up some found SPDX identifier
> > issues.
> >
> > The first patch fixes an error in a previous SPDX fixup patch, that
> > causes build errors when doing 'make clean' on the tree (the fact that
> > almost no one noticed it reflects the fact that kernel developers don't
> > like doing that option very often...)
> 
> This paragraph is not precise.
> 
> Not only "make clean", but also the normal build is broken.
> In fact, ARCH=arm allmodconfig is broken.
> 
> 
> $ make -j8 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- allmodconfig
>   [ snip ]
> $ make -j8 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf-
>   [ snip ]
> drivers/crypto/ux500/cryp/Makefile:5: *** missing separator.  Stop.
> make[3]: *** [scripts/Makefile.build;489: drivers/crypto/ux500/cryp] Error 2
> make[2]: *** [scripts/Makefile.build;489: drivers/crypto/ux500] Error 2
> make[1]: *** [scripts/Makefile.build;489: drivers/crypto] Error 2
> make[1]: *** Waiting for unfinished jobs....
> 
> 
> 
> The 0-day bot should check allmodconfig for all arches,
> but surprisingly it was not caught before the merge.

Ah, good catch, odd that 0-day missed it.  Maybe it is not building
32bit builds these days :(

> > The second patch fixes up a number of places in the tree where people
> > mistyped the string "SPDX-License-Identifier".  Given that people can
> > not even type their own name all the time without mistakes, this was
> > bound to happen, and odds are, we will have to add some type of check
> > for this to checkpatch.pl to catch this happening in the future.
> 
> checkpatch.pl already warns
> "Missing or malformed SPDX-License-Identifier tag"
> unless correctly typed "SPDX-License-Identifier" is found in the file.
> 
> No more check is needed for this, I think.

Ok, thanks, I thought it was not caught which is why it snuck in.

> Not all developers run scripts/checkpatch.pl before patch submission.
> Not all maintainers run scripts/checkpatch.pl before commit.

Very true :(

thanks,

greg k-h
