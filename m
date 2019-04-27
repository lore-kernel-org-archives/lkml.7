Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6624BC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 18:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EF052087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 18:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556389503;
	bh=kh8D00/7ITgVGh0adID3knm2y1Cr8/pPhKFd7SLKMis=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=LzCDk97PGJEfvjxg23vQMxWUuYylogPjUZ9Zft5rOyuP2VJKnOUTeqlR4VvkKTB9U
	 yy+TPeoqxYP0F5XtV0/HIxnpSrY5WSGEpc1zRFK2BJZ0yICZMfvtLg6ttDrhoF81bl
	 lPk+iU5fo6JQTiC6fu4tVen9iDLyFLmvUXohaS9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfD0SZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 14:25:02 -0400
Received: from casper.infradead.org ([85.118.1.10]:51848 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD0SZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 14:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wHts1d8Y6raq/bP++PtZKHYJGsQDFiyOnVnNB6iR6ug=; b=nWALiyYG9qmb9AK7Q+fRl4393o
        IYRO8bNjqx0dSc8OxqaEnZDy8Pw5YP840GG5uUwzL3K8X/Z3vNWDmoEtwlQ33Dg+04V+y4jTUUnVe
        iY+fz2lnrjaSFP9v8OMFojzyHyMSbKdKKKgw6NON+gKIHGi6FNVC60/J0USwwCE3LnzxAQAZZ/0gg
        yrDbuJr0Ptm1fVpUDeRbTqZa1i+n6uqilu8KJlUg3TkyJVIB+QB6fgAzP9LD3W7b6VWd+HS4LHVW1
        Yn2ysb11ICX7kN5Za39ksce6Ss38l9r2k8bY1kLSewvKdDfUlpcGWRDMzQ11KPp3svxcrIbz28+Ml
        PTVmm9mg==;
Received: from 177.17.250.151.dynamic.adsl.gvt.net.br ([177.17.250.151] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hKS0M-0004bX-Dh; Sat, 27 Apr 2019 18:24:55 +0000
Date:   Sat, 27 Apr 2019 15:24:49 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 20/27] Documentation: x86: convert i386/IO-APIC.txt to
 reST
Message-ID: <20190427152449.19df3fcb@coco.lan>
In-Reply-To: <20190426153150.21228-21-changbin.du@gmail.com>
References: <20190426153150.21228-1-changbin.du@gmail.com>
        <20190426153150.21228-21-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 26 Apr 2019 23:31:43 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  .../x86/i386/{IO-APIC.txt => IO-APIC.rst}     | 26 ++++++++++++-------
>  Documentation/x86/i386/index.rst              | 10 +++++++
>  Documentation/x86/index.rst                   |  1 +
>  3 files changed, 27 insertions(+), 10 deletions(-)
>  rename Documentation/x86/i386/{IO-APIC.txt => IO-APIC.rst} (93%)
>  create mode 100644 Documentation/x86/i386/index.rst
> 
> diff --git a/Documentation/x86/i386/IO-APIC.txt b/Documentation/x86/i386/IO-APIC.rst
> similarity index 93%
> rename from Documentation/x86/i386/IO-APIC.txt
> rename to Documentation/x86/i386/IO-APIC.rst
> index 15f5baf7e1b6..aec98f742763 100644
> --- a/Documentation/x86/i386/IO-APIC.txt
> +++ b/Documentation/x86/i386/IO-APIC.rst
> @@ -1,3 +1,11 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=======
> +IO-APIC
> +=======
> +
> +:Author: Ingo Molnar <mingo@kernel.org>
> +
>  Most (all) Intel-MP compliant SMP boards have the so-called 'IO-APIC',
>  which is an enhanced interrupt controller. It enables us to route
>  hardware interrupts to multiple CPUs, or to CPU groups. Without an
> @@ -13,7 +21,7 @@ usually worked around by the kernel. If your MP-compliant SMP board does
>  not boot Linux, then consult the linux-smp mailing list archives first.
>  
>  If your box boots fine with enabled IO-APIC IRQs, then your
> -/proc/interrupts will look like this one:
> +/proc/interrupts will look like this one::
>  
>     ---------------------------->
...
     <----------------------------

I would remove those lines, as they sounds like a way used by the
doc author to "escape" a literal block.

Either way:

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>


>    hell:~> cat /proc/interrupts  
> @@ -37,14 +45,14 @@ none of those IRQ sources is performance-critical.
>  In the unlikely case that your board does not create a working mp-table,
>  you can use the pirq= boot parameter to 'hand-construct' IRQ entries. This
>  is non-trivial though and cannot be automated. One sample /etc/lilo.conf
> -entry:
> +entry::
>  
>  	append="pirq=15,11,10"
>  
>  The actual numbers depend on your system, on your PCI cards and on their
>  PCI slot position. Usually PCI slots are 'daisy chained' before they are
>  connected to the PCI chipset IRQ routing facility (the incoming PIRQ1-4
> -lines):
> +lines)::
>  
>                 ,-.        ,-.        ,-.        ,-.        ,-.
>       PIRQ4 ----| |-.    ,-| |-.    ,-| |-.    ,-| |--------| |
> @@ -56,7 +64,7 @@ lines):
>       PIRQ1 ----| |-  `----| |-  `----| |-  `----| |--------| |
>                 `-'        `-'        `-'        `-'        `-'
>  
> -Every PCI card emits a PCI IRQ, which can be INTA, INTB, INTC or INTD:
> +Every PCI card emits a PCI IRQ, which can be INTA, INTB, INTC or INTD::
>  
>                                 ,-.
>                           INTD--| |
> @@ -78,19 +86,19 @@ to have non shared interrupts). Slot5 should be used for videocards, they
>  do not use interrupts normally, thus they are not daisy chained either.
>  
>  so if you have your SCSI card (IRQ11) in Slot1, Tulip card (IRQ9) in
> -Slot2, then you'll have to specify this pirq= line:
> +Slot2, then you'll have to specify this pirq= line::
>  
>  	append="pirq=11,9"
>  
>  the following script tries to figure out such a default pirq= line from
> -your PCI configuration:
> +your PCI configuration::
>  
>  	echo -n pirq=; echo `scanpci | grep T_L | cut -c56-` | sed 's/ /,/g'
>  
>  note that this script won't work if you have skipped a few slots or if your
>  board does not do default daisy-chaining. (or the IO-APIC has the PIRQ pins
>  connected in some strange way). E.g. if in the above case you have your SCSI
> -card (IRQ11) in Slot3, and have Slot1 empty:
> +card (IRQ11) in Slot3, and have Slot1 empty::
>  
>  	append="pirq=0,9,11"
>  
> @@ -105,7 +113,7 @@ won't function properly (e.g. if it's inserted as a module).
>  If you have 2 PCI buses, then you can use up to 8 pirq values, although such
>  boards tend to have a good configuration.
>  
> -Be prepared that it might happen that you need some strange pirq line:
> +Be prepared that it might happen that you need some strange pirq line::
>  
>  	append="pirq=0,0,0,0,0,0,9,11"
>  
> @@ -115,5 +123,3 @@ Good luck and mail to linux-smp@vger.kernel.org or
>  linux-kernel@vger.kernel.org if you have any problems that are not covered
>  by this document.
>  
> --- mingo
> -
> diff --git a/Documentation/x86/i386/index.rst b/Documentation/x86/i386/index.rst
> new file mode 100644
> index 000000000000..8747cf5bbd49
> --- /dev/null
> +++ b/Documentation/x86/i386/index.rst
> @@ -0,0 +1,10 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +============
> +i386 Support
> +============
> +
> +.. toctree::
> +   :maxdepth: 2
> +
> +   IO-APIC
> diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> index 526f7a008b8e..19323c5b89ce 100644
> --- a/Documentation/x86/index.rst
> +++ b/Documentation/x86/index.rst
> @@ -26,3 +26,4 @@ Linux x86 Support
>     microcode
>     resctrl_ui
>     usb-legacy-support
> +   i386/index



Thanks,
Mauro
