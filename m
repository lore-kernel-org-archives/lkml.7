Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBA1C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8974220675
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 11:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbfDPLKW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 07:10:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:21749 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728224AbfDPLKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 07:10:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 04:10:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,357,1549958400"; 
   d="scan'208";a="136235600"
Received: from irsmsx152.ger.corp.intel.com ([163.33.192.66])
  by orsmga006.jf.intel.com with ESMTP; 16 Apr 2019 04:10:18 -0700
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.21]) by
 IRSMSX152.ger.corp.intel.com ([169.254.6.225]) with mapi id 14.03.0415.000;
 Tue, 16 Apr 2019 12:10:17 +0100
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Ingo Molnar <mingo@kernel.org>, "tytso@mit.edu" <tytso@mit.edu>,
        "Daniel Borkmann" <daniel@iogearbox.net>
CC:     "luto@kernel.org" <luto@kernel.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "jannh@google.com" <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] x86/entry/64: randomize kernel stack offset upon syscall
Thread-Topic: [PATCH] x86/entry/64: randomize kernel stack offset upon
 syscall
Thread-Index: AQHU81HQwzT9MH4dM0y/JZXnSwiYT6Y8wW2AgAAdM1CAAXexAIAANZ3g
Date:   Tue, 16 Apr 2019 11:10:16 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4C51962@IRSMSX102.ger.corp.intel.com>
References: <20190415060918.3766-1-elena.reshetova@intel.com>
 <20190415072535.GA51449@gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4C4F90F@IRSMSX102.ger.corp.intel.com>
 <20190416073444.GC127769@gmail.com>
In-Reply-To: <20190416073444.GC127769@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMjNmODlkN2QtOTc5Yi00MDUxLWJlZmItM2VjMDY3MzliYWRkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiaTRWRStQMXEzT3NjXC9QSUFPVVFZdFwvbWRzXC9IT3dudytzK0lQRXNaVXVab1AzZXRzeVljZnNWeldUYnBVeEpCTyJ9
x-originating-ip: [163.33.239.182]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Theodore & Daniel since I guess they are the best positioned to comment on
exact strengths of prandom. See my comments below. 

> * Reshetova, Elena <elena.reshetova@intel.com> wrote:
> 
> > > 4)
> > >
> > > But before you tweak the patch, a more fundamental question:
> > >
> > > Does the stack offset have to be per *syscall execution* randomized?
> > > Which threats does this protect against that a simpler per task syscall
> > > random offset wouldn't protect against?
> >
> > We *really* need it per syscall. If you take a look on the recent stack attacks
> > [1],[2],[3],[4], they all do some initial probing on syscalls first to discover stack
> addresses
> > or leftover data on the stack (or pre-populate stack with some attacker-controlled
> data),
> > and then in the following syscall execute the actual attack (leak data, use
> > pre-populated data for execution, etc.). If the offset stays the same during
> > task life time, it can be easily recovered during this initial probing phase, and
> > then nothing changes for the attacker.
> >
> > [1] Kernel Exploitation Via Uninitialized Stack, 2011
> > https://www.defcon.org/images/defcon-19/dc-19-presentations/Cook/DEFCON-
> 19-Cook-Kernel-Exploitation.pdf
> > [2] Stackjacking, 2011, https://jon.oberheide.org/files/stackjacking-infiltrate11.pdf
> > [3] The Stack is Back, 2012, https://jon.oberheide.org/files/infiltrate12-
> thestackisback.pdf
> > [4] Exploiting Recursion in the Linux Kernel, 2016,
> > https://googleprojectzero.blogspot.com/2016/06/exploiting-recursion-in-linux-
> kernel_20.html
> 
> Yeah, so if there's an information leak from the kernel stack, don't we
> now effectively store 5 PRNG bits there for every syscall, allowing the
> systematic probing of the generic PRNG?

Yes, so if there is a reliable stack-based leak that allows you to leak the 5 
PRNG bits for every syscall within the 60 sec (until the reseeding happens), then
we indeed leak these 5 bits with every syscall. After we have accumulated 
enough bits (not sure what is the correct bound here on how many bits we need
minimum), we can predict PRGN output until the reseed happens. 

> 
> The kernel can execute millions of syscalls per second, I'm pretty sure
> there's a statistical attack against:
> 
>  * This is a maximally equidistributed combined Tausworthe generator
>  * based on code from GNU Scientific Library 1.5 (30 Jun 2004)
>  *
>  * lfsr113 version:
>  *
>  * x_n = (s1_n ^ s2_n ^ s3_n ^ s4_n)
>  *
>  * s1_{n+1} = (((s1_n & 4294967294) << 18) ^ (((s1_n <<  6) ^ s1_n) >> 13))
>  * s2_{n+1} = (((s2_n & 4294967288) <<  2) ^ (((s2_n <<  2) ^ s2_n) >> 27))
>  * s3_{n+1} = (((s3_n & 4294967280) <<  7) ^ (((s3_n << 13) ^ s3_n) >> 21))
>  * s4_{n+1} = (((s4_n & 4294967168) << 13) ^ (((s4_n <<  3) ^ s4_n) >> 12))
>  *
>  * The period of this generator is about 2^113 (see erratum paper).
> 
> ... which recovers the real PRNG state much faster than the ~60 seconds
> seeding interval and allows the prediction of the next stack offset?

I hope Theodore can comment on bounds here. How many syscalls we need
to issue  assuming that each leaks 5 presudorandom bits out of 32 bit 
presudorandom number produced by PRGN before we can predict the
PRNG output. 

Daniel made a change to prandom a while back to allow to store the state & do
the seeding of PRNG separately, so I guess this is what you meant initially when proposing
to move the state out of per-cpu to per-task/thread. 

I have been thinking more about this now, it is certainly good to limit the
potential damage to just one task/thread by having it depend on its own PRNG,
and I guess my previous argument on amount of control that attacker has 
when trying to break per-cpu PRGN vs. per-thread PRGN does not really hold, 
because attacker can probably "create/adjust" environment quite some 
(i.e. make sure that it is mostly the attacker process that execute syscalls
during the desired small attack window). 

However, what I am still wondering
is how safe is to store per-task PRGN clear state in smth like task struct or thread_info? 
If it leaks, only one leak is enough, these structs are very known and
well-studied by attackers, thread_info even used to be on stack itself 
(and still is if you disable CONFIG_THREAD_INFO_IN_TASK)... 

More thoughts on options below...

> 
> I.e. I don't see how kernel stack PRNG randomization protects against
> information leaks from the kernel stack. 

It does not protect against information leaks from the kernel stack, we have
other protections for that: STACKLEAK, CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL.
What it aims to do is to make the stack structure different and unpredictable on
each syscall, so that attacker cannot reliably dereference to any particular
spot in the stack. So, if you do smth like this as attacker:

1) Make some probing syscalls to discover some info about the stack,
where some data structures land on stack during a particular syscall, 
or pre-fill particular spots in the stack with attacker controlled data. 

2) Execute the actual attack via a new syscall where you attempt to 
either reliably use the data you prefilled on the stack or for example leak some 
particular spot from the stack via overlapping data structure. 

In order to do 2) successful you need stack structure over different
invocations of syscalls to be somewhat predictable. This is exactly
what this protection aims to remove. 

By putting PRNG information into
> the kernel stack for *every* system call we add a broad attack surface:
> any obscure ioctl information leak can now be escalated into an attack
> against the net_rand_state PRNG, right?

I was previously  thinking that net code doesn't share the PRNG state with the rest of 
the system, but looking into the code now, it does do exactly that.
Only bpf & netfiler out of net-related code manage their own states.. 
So, yes, looks like usage of prandom joined state through the kernel is pretty
big already and making it bigger is a bad idea, indeed. 

What if we define separate new per-cpu states for this stack randomization and seed/reseed 
them separately & regularly (have to just understand where to do code-wise initial seeding etc.).
This way we don't expose any other PRGN use and still
don't have an issue of storing PRGN state in task struct.
However this won't address your concern on a need to dereference this per-cpu variable 
upon each syscall. But if I make specific inline function (like you recommended before) to do extraction
of small amount of bits (5-6) for every time we need it, it would be already
much smaller than the current construct and if performance is acceptable, then
would not it be a good alternative?

It still of course does not cancel the fact that if you have a reliable leak and do enough of syscalls
within the reseeding period, you can break the PRGN, but the worst consequence of 
that would be breaking stack randomization only. 

Best Regards,
Elena.

