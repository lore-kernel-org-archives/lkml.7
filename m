Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDDBC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 17:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1EB204EC
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 17:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556387840;
	bh=nGVD9vO59yeGm/ZP1NGurU2npr4e4IEV7PLfmVDqkyk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=t18WHDVC/B/FHPF4YuVJD2WfHTqORK5HU48jwbdPKwpYQ15HFrEFYi00Nru1fkuIR
	 EpvKX7wNYdhDAfSPz0cMaH7y5Lfv7bqkX8GlroJsYe7SrmxRpCEnAZE9eWvnQw26N4
	 v01CwF3Ad6zDd/Lsw1tYz01GrJFYFsc4CF+KcWl0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfD0R5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 13:57:19 -0400
Received: from casper.infradead.org ([85.118.1.10]:50298 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbfD0R5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 13:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oBiHv0THBfUXjJClic9ROjQf6mlSKVP8ZVkAva9ccFo=; b=gCqVKJ3X+pSII5lauUiHz1aInL
        eYDZNm9inAh/dB6r8iueSZnD6app/9uYMrB8CWzJeW+s0sevnc5D+cDRYhpmSqRY3rFG7eQmW7dIJ
        wFdi71Zdv7k22oE6uLPJHMFgFjqV357SIbhVH+cc7ggyj0U4uEM15LFcGODHqgjeHNN1/WOSaOa9H
        4Dl+mse+FXIplEqBf/jXQ5qmOVDSmcbZ+49jOoNViHrg/hxj5FNoTjVYuAufItM1YAsS/X9tWYR0i
        PgMnaSNcaCEW9tAmIEQC50FCR6nsCeGfVOE8m8eL5V+G3xgHz/6GOdWD+q/9l9NJskmVgQfnqHofZ
        ZBrO0YlQ==;
Received: from 177.17.250.151.dynamic.adsl.gvt.net.br ([177.17.250.151] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hKRZZ-0003DN-3B; Sat, 27 Apr 2019 17:57:13 +0000
Date:   Sat, 27 Apr 2019 14:57:08 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/27] Documentation: x86: convert pti.txt to reST
Message-ID: <20190427145708.281493e4@coco.lan>
In-Reply-To: <20190426153150.21228-16-changbin.du@gmail.com>
References: <20190426153150.21228-1-changbin.du@gmail.com>
        <20190426153150.21228-16-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 26 Apr 2019 23:31:38 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  Documentation/x86/index.rst            |  1 +
>  Documentation/x86/{pti.txt => pti.rst} | 17 +++++++++++++----
>  2 files changed, 14 insertions(+), 4 deletions(-)
>  rename Documentation/x86/{pti.txt => pti.rst} (96%)
> 
> diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> index a0426ab156bd..1c675cef14d7 100644
> --- a/Documentation/x86/index.rst
> +++ b/Documentation/x86/index.rst
> @@ -21,3 +21,4 @@ Linux x86 Support
>     protection-keys
>     intel_mpx
>     amd-memory-encryption
> +   pti
> diff --git a/Documentation/x86/pti.txt b/Documentation/x86/pti.rst
> similarity index 96%
> rename from Documentation/x86/pti.txt
> rename to Documentation/x86/pti.rst
> index 5cd58439ad2d..4b858a9bad8d 100644
> --- a/Documentation/x86/pti.txt
> +++ b/Documentation/x86/pti.rst
> @@ -1,9 +1,15 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==========================
> +Page Table Isolation (PTI)
> +==========================
> +
>  Overview
>  ========
>  
> -Page Table Isolation (pti, previously known as KAISER[1]) is a
> +Page Table Isolation (pti, previously known as KAISER [1]_) is a
>  countermeasure against attacks on the shared user/kernel address
> -space such as the "Meltdown" approach[2].
> +space such as the "Meltdown" approach [2]_.
>  
>  To mitigate this class of attacks, we create an independent set of
>  page tables for use only when running userspace applications.  When
> @@ -60,6 +66,7 @@ Protection against side-channel attacks is important.  But,
>  this protection comes at a cost:
>  
>  1. Increased Memory Use
> +
>    a. Each process now needs an order-1 PGD instead of order-0.
>       (Consumes an additional 4k per process).
>    b. The 'cpu_entry_area' structure must be 2MB in size and 2MB
> @@ -68,6 +75,7 @@ this protection comes at a cost:
>       is decompressed, but no space in the kernel image itself.
>  
>  2. Runtime Cost
> +
>    a. CR3 manipulation to switch between the page table copies
>       must be done at interrupt, syscall, and exception entry
>       and exit (it can be skipped when the kernel is interrupted,
> @@ -142,6 +150,7 @@ ideally doing all of these in parallel:
>     interrupted, including nested NMIs.  Using "-c" boosts the rate of
>     NMIs, and using two -c with separate counters encourages nested NMIs
>     and less deterministic behavior.
> +   ::
>  
>  	while true; do perf record -c 10000 -e instructions,cycles -a sleep 10; done
>  
> @@ -182,5 +191,5 @@ that are worth noting here.
>     tended to be TLB invalidation issues.  Usually invalidating
>     the wrong PCID, or otherwise missing an invalidation.
>  
> -1. https://gruss.cc/files/kaiser.pdf
> -2. https://meltdownattack.com/meltdown.pdf
> +.. [1] https://gruss.cc/files/kaiser.pdf
> +.. [2] https://meltdownattack.com/meltdown.pdf



Thanks,
Mauro
