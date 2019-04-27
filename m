Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20ECAC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 17:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE31520881
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 17:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556385691;
	bh=TuQxojjM3AvXPiXPE1+Caa0NSneKVOKxH/meHp9Xyq8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=lhUn/rKw3pSD2ffqJLj1ZIrGMkBl4F7wcYgnzjN3EhBctD1fHCNEnodAk8TXz1fUx
	 pPUwP/x8PhPYP48Qw9ROAipoRYmdM9awiC4j8La/FIu+jbHBG4VkdirK+/L8gvOTyl
	 1jLX3uolU9iFQv5F8efuqFvtwsqZlU+0a4thakEI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfD0RVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 13:21:30 -0400
Received: from casper.infradead.org ([85.118.1.10]:49360 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfD0RVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 13:21:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4B7AoWZicUwwqyJfuODmYqlOhDr2IiPWGxZmLepUTik=; b=CVJ0D3rf+SZ6O5/vK14hsLrdlN
        eSgbvk7N1zmdCx7cDH5N+4+F9/zCN+sg3at1WZbgOiJd+9C1/xBalhJAqPUpVH+r8i3/9e1FaavcU
        A05VawPqq60q+VDVLa5c8aCra6mkhIfq3UHJ6mTZTzmipGRDTGW6FEfq1byNgw8O1qdVoNpG3HpjN
        IrT0jEMmYVd165KN3jtvvRKiGzwEV8wDCh8PklgK5DI5rXX+WdgkRYg6A9mHLDmEaYJoXWOV5Jj9V
        GWDHvVntPSVZP8FbxQoF8GCn5gf7cBHBmWgGfUuKxgswDPu9Sih5nFkUb6E4NUU/XR7orAwJ1hy9g
        eqh64aOw==;
Received: from 177.17.250.151.dynamic.adsl.gvt.net.br ([177.17.250.151] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hKR0u-0001hN-Gd; Sat, 27 Apr 2019 17:21:25 +0000
Date:   Sat, 27 Apr 2019 14:21:19 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/27] Documentation: x86: convert tlb.txt to reST
Message-ID: <20190427142119.594f58ae@coco.lan>
In-Reply-To: <20190426153150.21228-10-changbin.du@gmail.com>
References: <20190426153150.21228-1-changbin.du@gmail.com>
        <20190426153150.21228-10-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 26 Apr 2019 23:31:32 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  Documentation/x86/index.rst            |  1 +
>  Documentation/x86/{tlb.txt => tlb.rst} | 30 ++++++++++++++++----------
>  2 files changed, 20 insertions(+), 11 deletions(-)
>  rename Documentation/x86/{tlb.txt => tlb.rst} (81%)
> 
> diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> index 9a0b5f38ef6b..fd54b859db9b 100644
> --- a/Documentation/x86/index.rst
> +++ b/Documentation/x86/index.rst
> @@ -15,3 +15,4 @@ Linux x86 Support
>     entry_64
>     earlyprintk
>     zero-page
> +   tlb
> diff --git a/Documentation/x86/tlb.txt b/Documentation/x86/tlb.rst
> similarity index 81%
> rename from Documentation/x86/tlb.txt
> rename to Documentation/x86/tlb.rst
> index 6a0607b99ed8..82ec58ae63a8 100644
> --- a/Documentation/x86/tlb.txt
> +++ b/Documentation/x86/tlb.rst
> @@ -1,5 +1,12 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=======
> +The TLB
> +=======
> +
>  When the kernel unmaps or modified the attributes of a range of
>  memory, it has two choices:
> +
>   1. Flush the entire TLB with a two-instruction sequence.  This is
>      a quick operation, but it causes collateral damage: TLB entries
>      from areas other than the one we are trying to flush will be
> @@ -10,6 +17,7 @@ memory, it has two choices:
>      damage to other TLB entries.
>  
>  Which method to do depends on a few things:
> +
>   1. The size of the flush being performed.  A flush of the entire
>      address space is obviously better performed by flushing the
>      entire TLB than doing 2^48/PAGE_SIZE individual flushes.
> @@ -33,7 +41,7 @@ well.  There is essentially no "right" point to choose.
>  You may be doing too many individual invalidations if you see the
>  invlpg instruction (or instructions _near_ it) show up high in
>  profiles.  If you believe that individual invalidations being
> -called too often, you can lower the tunable:
> +called too often, you can lower the tunable::
>  
>  	/sys/kernel/debug/x86/tlb_single_page_flush_ceiling
>  
> @@ -43,7 +51,7 @@ Setting it to 1 is a very conservative setting and it should
>  never need to be 0 under normal circumstances.
>  
>  Despite the fact that a single individual flush on x86 is
> -guaranteed to flush a full 2MB [1], hugetlbfs always uses the full
> +guaranteed to flush a full 2MB [1]_, hugetlbfs always uses the full
>  flushes.  THP is treated exactly the same as normal memory.
>  
>  You might see invlpg inside of flush_tlb_mm_range() show up in
> @@ -54,15 +62,15 @@ Essentially, you are balancing the cycles you spend doing invlpg
>  with the cycles that you spend refilling the TLB later.
>  
>  You can measure how expensive TLB refills are by using
> -performance counters and 'perf stat', like this:
> +performance counters and 'perf stat', like this::
>  
> -perf stat -e
> -	cpu/event=0x8,umask=0x84,name=dtlb_load_misses_walk_duration/,
> -	cpu/event=0x8,umask=0x82,name=dtlb_load_misses_walk_completed/,
> -	cpu/event=0x49,umask=0x4,name=dtlb_store_misses_walk_duration/,
> -	cpu/event=0x49,umask=0x2,name=dtlb_store_misses_walk_completed/,
> -	cpu/event=0x85,umask=0x4,name=itlb_misses_walk_duration/,
> -	cpu/event=0x85,umask=0x2,name=itlb_misses_walk_completed/
> +  perf stat -e
> +    cpu/event=0x8,umask=0x84,name=dtlb_load_misses_walk_duration/,
> +    cpu/event=0x8,umask=0x82,name=dtlb_load_misses_walk_completed/,
> +    cpu/event=0x49,umask=0x4,name=dtlb_store_misses_walk_duration/,
> +    cpu/event=0x49,umask=0x2,name=dtlb_store_misses_walk_completed/,
> +    cpu/event=0x85,umask=0x4,name=itlb_misses_walk_duration/,
> +    cpu/event=0x85,umask=0x2,name=itlb_misses_walk_completed/
>  
>  That works on an IvyBridge-era CPU (i5-3320M).  Different CPUs
>  may have differently-named counters, but they should at least
> @@ -70,6 +78,6 @@ be there in some form.  You can use pmu-tools 'ocperf list'
>  (https://github.com/andikleen/pmu-tools) to find the right
>  counters for a given CPU.
>  
> -1. A footnote in Intel's SDM "4.10.4.2 Recommended Invalidation"
> +.. [1] A footnote in Intel's SDM "4.10.4.2 Recommended Invalidation"
>     says: "One execution of INVLPG is sufficient even for a page
>     with size greater than 4 KBytes."



Thanks,
Mauro
