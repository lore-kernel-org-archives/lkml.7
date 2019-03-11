Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CBBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5382148D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfCKWbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 18:31:33 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41013 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfCKWbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 18:31:32 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h3TRt-0001K5-8L; Mon, 11 Mar 2019 23:31:09 +0100
Date:   Mon, 11 Mar 2019 23:31:08 +0100 (CET)
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
In-Reply-To: <20190311131341.GA28223@amd>
Message-ID: <alpine.DEB.2.21.1903112211180.1651@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1812200022580.1651@nanos.tec.linutronix.de> <20190102235152.GA24163@amd> <20190311102109.GA14118@amd> <alpine.DEB.2.21.1903111403330.1691@nanos.tec.linutronix.de> <20190311131341.GA28223@amd>
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

On Mon, 11 Mar 2019, Pavel Machek wrote:
> On Mon 2019-03-11 14:05:07, Thomas Gleixner wrote:
> > Huch? Care to tell what's a lie instead of making bold statements?
> 
> Take a care to look at the patch I submitted?
> 
> Lie:
> 
> # A system with an up to date kernel is protected against attacks from
> # malicious user space applications.
> 
> 3GB system running 32bit kernel is not protected. Same is true for for
> really big 64bit systems.

I agree that this statement is incorrect.

Calling this a lie is a completly unjustified personal attack on those who
spent quite a lot of time on writing up documentation in the first
place. It's suggesting that this document was written with malicious intent
and the purpose of deceiving someone. Care to explain why you are assuming
this to be the case?

> If I do what dmesg suggests, this becomes untrue:
> 
> # The Linux kernel contains a mitigation for this attack vector, PTE
> # inversion, which is permanently enabled and has no performance
> # impact.
> 
> Limiting memory to 2GB _is_ going to have severe perfomance impact.

Sure. That still does not justify the "changelog" you provided.

> commit 9664b4dabdb132433a6843aefe05814953f1342f
> Author: Pavel <pavel@ucw.cz>
> Date:   Thu Jan 3 00:48:40 2019 +0100
> 
>     Ok, I guess L1TF was a lot of fun, and there was not time for a good
>     documentation.

It's interesting that quite some people were actually happy about that
document. Sorry, that we weren't able to live up to your high standards.

>     There's admin guide that is written as an advertisment, and

What is the advertisement part again?

>     unfortunately is slightly "inaccurate" at places (to the point of
>     lying).
>     
>     Plus, I believe it should go to x86/ directory, as this is really
>     Intel issue, and not anything ARM (or RISC-V) people need to know.

It's a document targeted at system administrators and it definitely should
not be burried somewhere in Documentation/x86. As there are more documents
being worked on for the other issues, I have a patch ready which moves that
stuff into a separate hardware vulnerabilites folder in the admin-guide.

FWIW, to the best of my knowledge the documentation about writing
changelogs is neither incorrect nor is it optional to adhere to it.

> @@ -1,10 +1,11 @@
>  L1TF - L1 Terminal Fault
>  ========================
>  
> -L1 Terminal Fault is a hardware vulnerability which allows unprivileged
> -speculative access to data which is available in the Level 1 Data Cache
> -when the page table entry controlling the virtual address, which is used
> -for the access, has the Present bit cleared or other reserved bits set.
> +L1 Terminal Fault is a hardware vulnerability on most recent Intel x86

The 'Affected processors' section right below this is very clear about this
being an Intel only issue (for now). So what exactly is the point of this
change?

> +CPUs which allows unprivileged speculative access to data which is
> +available in the Level 1 Data Cache when the page table entry
> +controlling the virtual address, which is used for the access, has the
> +Present bit cleared or other reserved bits set.
>  
>  Affected processors
>  -------------------
> @@ -76,12 +77,14 @@ Attack scenarios
>     deterministic and more practical.
>  
>     The Linux kernel contains a mitigation for this attack vector, PTE
> -   inversion, which is permanently enabled and has no performance
> -   impact. The kernel ensures that the address bits of PTEs, which are not
> -   marked present, never point to cacheable physical memory space.
> -
> -   A system with an up to date kernel is protected against attacks from
> -   malicious user space applications.
> +   inversion, which is permanently enabled and has no measurable
> +   performance impact in most configurations. The kernel ensures that
> +   the address bits of PTEs, which are not marked present, never point
> +   to cacheable physical memory space. On x86-32, this physical memory

On x86-32? That's incorrect, because there are a lot of x86-32 systems
which are not affected. Also it has nothing to do with the bit-width of the
hardware. A 32bit kernel booted on a 64bit capable CPU has the same issue.
For further correctness, this needs to mention that !PAE enabled kernels
cannot do PTE inversion at all.

> +   needs to be limited to 2GiB to make mitigation effective.

The 2G limitation is not a general limitation. The limitation depends on
the number of physical address bits supported by the cache (not the number
of physical addresss bits exposed as pins) and is definitely not hardcoded
to 2G. Just because your machine emits the 2G number does not make it
universally correct. On a system with 36bit physical address space the
limit is 32G and on some CPUs that's actually wrong as well, see:
override_cache_bits().

Quoting yourself:

> 3GB system running 32bit kernel is not protected. Same is true for for
> really big 64bit systems.

Where is the explanation for the 'really big 64bit systems' issue for
correctness sake?

Thanks,

	tglx
