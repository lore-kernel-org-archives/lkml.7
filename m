Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A0EC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 12:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CDE20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 12:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbfCFMZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 07:25:28 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:49790 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfCFMZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 07:25:27 -0500
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h1Vbq-0003KY-GV; Wed, 06 Mar 2019 13:25:18 +0100
Date:   Wed, 6 Mar 2019 13:25:17 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Matthew Wilcox <willy@infradead.org>
cc:     Borislav Petkov <bp@alien8.de>, Jann Horn <jannh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: a.out coredumping: fix or delete?
In-Reply-To: <20190305122218.GD13380@bombadil.infradead.org>
Message-ID: <alpine.DEB.2.21.1903061323030.1646@nanos.tec.linutronix.de>
References: <CAG48ez1RVd5mQ_Pb6eygQESaZhpQz765OAZYSoPE0kPqfZEXQg@mail.gmail.com> <20190305091904.GB8256@zn.tnic> <20190305122218.GD13380@bombadil.infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2019, Matthew Wilcox wrote:
> On Tue, Mar 05, 2019 at 10:19:04AM +0100, Borislav Petkov wrote:
> > On Sat, Mar 02, 2019 at 12:57:30AM +0100, Jann Horn wrote:
> > > In theory, Linux can dump cores for a.out binaries. In practice, that
> > > code is pretty bitrotten and buggy. Does anyone want that code so much
> > > that they'd like to fix it, or can we just delete it?
> > 
> > I was asking myself the same question while doing
> > 
> >   10970e1b4be9 ("x86/a.out: Clear the dump structure initially")
> > 
> > especially since it is kinda hard to get the toolchain to even create an
> > a.out executable - your script to create one case-in-point.
> 
> It's been 25 years since Linux added support for ELF.  Can we just
> delete the a.out support entirely now?  According to the Linux-ELF HOWTO,
> support was added in 1.1.52 (August 1994).  It's pretty much necromancy
> at this point.

The Kernel-Necrophilia cult members might disagree. :)

But yes, good riddance.

Thanks,

	tglx

