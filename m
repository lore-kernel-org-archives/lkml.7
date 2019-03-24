Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E877C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 20:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5EC720989
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 20:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbfCXUlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 16:41:46 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44290 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfCXUlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 16:41:46 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h89vl-0006EP-Ji; Sun, 24 Mar 2019 21:41:21 +0100
Date:   Sun, 24 Mar 2019 21:41:20 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Pavel Machek <pavel@ucw.cz>
cc:     corbet@lwn.net, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tony Luck <tony.luck@intel.com>,
        Salvatore Bonaccorso <carnil@debian.org>,
        linux-doc@vger.kernel.org
Subject: Re: [patch] Fix up l1ft documentation was Re: Taking a break - time
 to look back
In-Reply-To: <20190312115757.GA29955@amd>
Message-ID: <alpine.DEB.2.21.1903120633000.1985@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1812200022580.1651@nanos.tec.linutronix.de> <20190102235152.GA24163@amd> <20190311102109.GA14118@amd> <alpine.DEB.2.21.1903111403330.1691@nanos.tec.linutronix.de> <20190311131341.GA28223@amd> <alpine.DEB.2.21.1903112211180.1651@nanos.tec.linutronix.de>
 <20190312115757.GA29955@amd>
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

Pavel,

On Tue, 12 Mar 2019, Pavel Machek wrote:
> On Mon 2019-03-11 23:31:08, Thomas Gleixner wrote:
> > Calling this a lie is a completly unjustified personal attack on those who
> 
> So how should it be called? I initally used less strong words, only to
> get "Care to tell what's a lie instead of making bold statements?"
> back. Also look at the timing of the thread.

You called it a lie from the very beginning or what do you think made me
tell you that? Here is what you said:

> There's admin guide that is written as an advertisment, and
> unfortunately is slightly "inaccurate" at places (to the point of
> lying).

Nice try.

> > >     Ok, I guess L1TF was a lot of fun, and there was not time for a good
> > >     documentation.
> > 
> > It's interesting that quite some people were actually happy about that
> > document. Sorry, that we weren't able to live up to your high
> > standards.
> 
> Ok, now can we have that document updated to meet the standards?

What is 'the standards'? Your's or is there a general agreement?

> > > -L1 Terminal Fault is a hardware vulnerability which allows unprivileged
> > > -speculative access to data which is available in the Level 1 Data Cache
> > > -when the page table entry controlling the virtual address, which is used
> > > -for the access, has the Present bit cleared or other reserved bits set.
> > > +L1 Terminal Fault is a hardware vulnerability on most recent Intel x86
> > 
> > The 'Affected processors' section right below this is very clear about this
> > being an Intel only issue (for now). So what exactly is the point of this
> > change?
> 
> Making it very clear from the begining this is x86-only issue. Yes,
> you can kind-of figure it out from the next section... except for
> Intel StrongArm.

It's pretty clear, but yes admittedly we forgot to mention that Intel
StrongARM is not affected. That's truly important because its widely
deployed in the cloud space and elsewhere.

> Next sentence speaks about "present bit" of "page table entry". That
> may be confusing for people familiar with other architectures, which
> may not have such bit. We should mention this is x86 before using
> x86-specific terminology.

X86 terminology? Care to check how pte_present() is implemented across the
architectures? Most of them use the PRESENT bit naming convention, just a
few use VALID. That's truly confusing and truly x86 specific.

> > > 3GB system running 32bit kernel is not protected. Same is true for for
> > > really big 64bit systems.
> > 
> > Where is the explanation for the 'really big 64bit systems' issue for
> > correctness sake?
> 
> I don't know the detailed limits for each system; what about this?

It's not about detailed limits for particular systems. It's about the way
the limit is determined on certain class of systems. And that can be
deduced from the code.

If you want to provide more accurate documentation then you better come up
with something which is helpful instead of completely useless blurb like
the below:

> -   malicious user space applications.
> +   inversion, which has no measurable performance impact in most
> +   configurations. The kernel ensures that the address bits of PTEs,
> +   which are not marked present, never point to cacheable physical
> +   memory space. For mitigation to be effective, physical memory needs
> +   to be limited in some configurations.

How is the admin going to figure that out? What kind of systems might be
affected by this?

> +   Mitigation is present in kernels v4.19 and newer, and in
> +   recent -stable kernels. PAE needs to be enabled for mitigation to
> +   work.

No. The mitigation is available when the kernel provides it. Numbers are
irrelevant because that documentation has to be applicable for stable
kernels as well. And what is a recent -stable kernel?

Also the PAE part needs to go to a completely different section.

Thanks,

	tglx
