Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63EEC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9BAD20868
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 10:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbfEVKOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 06:14:17 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:35904 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbfEVKOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 06:14:16 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hTOGA-0000iG-C1; Wed, 22 May 2019 12:14:10 +0200
Date:   Wed, 22 May 2019 12:14:09 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Joe Perches <joe@perches.com>
cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spdx@vger.kernel.org
Subject: Re: [GIT PULL] SPDX update for 5.2-rc1 - round 1
In-Reply-To: <eae2d0e80824cc84965c571a0ea097e14d3f498c.camel@perches.com>
Message-ID: <alpine.DEB.2.21.1905221210340.1637@nanos.tec.linutronix.de>
References: <20190521133257.GA21471@kroah.com>  <CAK7LNASZWLwYC2E3vBkXhp7wt9zBWkFrR+NTnxTyLn1zO66a0w@mail.gmail.com> <eae2d0e80824cc84965c571a0ea097e14d3f498c.camel@perches.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2019, Joe Perches wrote:
> On Wed, 2019-05-22 at 13:32 +0900, Masahiro Yamada wrote:
> > (Perhaps, checkpatch.pl can suggest newer tags in case
> > patch submitters do not even know that deprecation.)
> 
> I'd still prefer the kernel use of a single SPDX style.
> 
> I don't know why the -only and -or-later forms were
> used for this patch, but I like it.

Mostly because the underlying tools use the latest SDPX version.

> Is it agreed that the GPL-<v>-only and GPL-<v>-or-later
> forms should be preferred for new SPDX identifiers?

I have no strong opinion, but using the -only / -or-later variant makes a
lot of sense.

> If so, I'll submit a checkpatch patch.

No objections, but we please have to make it clear that this is not a new
playground for s/OLDSTYLE/NEWSTYLE/ scriptkiddies.

The compliance tools have to understand both anyway.

> I could also wire up a patch to checkpatch and docs to
> remove the /* */
> requirement for .h files and prefer
> the generic // form for both .c and
> .h files as the
> current minimum tooling versions now all allow //
> comments

Yes, that makes sense. The restriction is not longer relevant, but again we
are not changing all the existing files for no reason.

Thanks,

	tglx


