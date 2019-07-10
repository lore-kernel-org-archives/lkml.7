Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E782C73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 11:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609002064A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 11:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mengyan1223.wang header.i=@mengyan1223.wang header.b="uIQydmLB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfGJL2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 07:28:19 -0400
Received: from mengyan1223.wang ([89.208.246.23]:38382 "EHLO mengyan1223.wang"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfGJL2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 07:28:18 -0400
Received: from [192.168.50.135] (unknown [124.115.222.149])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: xry111@mengyan1223.wang)
        by mengyan1223.wang (Postfix) with ESMTPSA id 8BDE666017;
        Wed, 10 Jul 2019 07:28:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mengyan1223.wang;
        s=mail; t=1562758096;
        bh=2h7Lx57k+M/g6Rq8mI2WdK5E9uWze+XlMUmrRUBio8g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=uIQydmLBWV/4lhA72ne1tCb3QofFxYIm1elBsZXsp8Ez3zOeIYKLYwX0R832S0bJj
         tdsU4lz783zDXGHBZfv1u3KwYME1tuCP7brIEJ56rW9weEvXlVhgBxRe5WuOf2Ultv
         SvKSX9jYPByTCEowdYrKpiVT/oc7ykTShRsNQCmq1bQuBJkzy/uPjgE0Wh0F4pdGr8
         tm3FIqCyMlJti8Gw3EgcWhF2kp2V8DDYIn0lywCz97YKxj8vjOBlu0KczsuLlPMvyA
         5as6uf6v65/cA1xqWNpM+dx5WeipcM28woL6e9z4KsaaZxolaSAANjWGqSR77nUKbY
         wIijqvEAfQDqA==
Message-ID: <1ad2de95e694a29909801d022fe2d556df9a4bd5.camel@mengyan1223.wang>
Subject: Re: [GIT PULL] x86/topology changes for v5.3
From:   Xi Ruoyao <xry111@mengyan1223.wang>
To:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tony Luck <tony.luck@intel.com>, Jiri Kosina <jkosina@suse.cz>,
        Bob Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        xry111@mengyan1223.wang
Date:   Wed, 10 Jul 2019 19:27:53 +0800
In-Reply-To: <201907091727.91CC6C72D8@keescook>
References: <20190708162756.GA69120@gmail.com>
         <CAHk-=wigbHd6wXcrpH+6jnDe=e+OHFy6-KdVSUP2yU5aip-UAg@mail.gmail.com>
         <CAHk-=wgkWTtW-JWVAO0Y6s=dRgZGAaTWAsOuYaTFNJzkF+Z_Jg@mail.gmail.com>
         <CAHk-=whJtbQFHNtNG7t7y6+oEKLpjj3eSQOrr3OPCVGbMaRz-A@mail.gmail.com>
         <CAHk-=wh7NChJP+WkaDd3qCz847Fq4NdQ6z6m-VFpbr3py_EknQ@mail.gmail.com>
         <alpine.DEB.2.21.1907100023020.1758@nanos.tec.linutronix.de>
         <alpine.DEB.2.21.1907100039540.1758@nanos.tec.linutronix.de>
         <alpine.DEB.2.21.1907100115220.1758@nanos.tec.linutronix.de>
         <201907091727.91CC6C72D8@keescook>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-09 17:31 -0700, Kees Cook wrote:
> On Wed, Jul 10, 2019 at 01:17:11AM +0200, Thomas Gleixner wrote:
> > On Wed, 10 Jul 2019, Thomas Gleixner wrote:
> > > That still does not explain the cr4/0 issue you have. Can you send me your
> > > .config please?
> > 
> > Does your machine have UMIP support? None of my test boxes has. So that'd
> > be the difference of bits enforced in CR4. Should not matter because it's
> > User mode instruction prevention, but who knows.
> 
> Ew. Yeah, I don't have i9 nor i7 for testing this. I did try everything
> else I had (and hibernation). Is only Linus able to reproduce this so far?

I can, too.

> To rule out (in?) UMIP, this would remove UMIP from the pinning:
> 
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 309b6b9b49d4..f3beedb6da8a 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -380,7 +380,7 @@ static void __init setup_cr_pinning(void)
>  {
>  	unsigned long mask;
>  
> -	mask = (X86_CR4_SMEP | X86_CR4_SMAP | X86_CR4_UMIP);
> +	mask = (X86_CR4_SMEP | X86_CR4_SMAP);
>  	cr4_pinned_bits = this_cpu_read(cpu_tlbstate.cr4) & mask;
>  	static_key_enable(&cr_pinning.key);
>  }

I'll try it.
-- 
Xi Ruoyao <xry111@mengyan1223.wang>
School of Aerospace Science and Technology, Xidian University

