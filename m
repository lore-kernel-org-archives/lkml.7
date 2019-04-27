Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C798C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 14:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFEB206BB
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 14:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556376759;
	bh=BYkU7pic6QGbEdehfGqOWP+uVPvHdXCVktIwQzSIiZs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=SnGqRuM8XAprLzqgFrM0wUl9jekq9EpYClraN3UsJlsiCQVWpv27RJP+q2wPvvSvD
	 BwOTzC2z7LpyqQjBZpSY2I4lM9Rfx/iAcb6qXS+iKqE2lH8dbB7ZlkAnzW8TYfRbUz
	 1f4I4EEJtvNsSpa/dzLB3x3M5+aL7bcStoRDmrfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfD0Owi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 10:52:38 -0400
Received: from casper.infradead.org ([85.118.1.10]:43124 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfD0Owh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 10:52:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZJ7gB7ALl0BnksovHo2/bXR9EeDH5jZVqNSWTebcr1o=; b=qo5M8amTrznOQFjuXNtv4MbmMY
        Cncxt5UZ/p0zubsJjfc+qvDF+ecLUYNmqG2xd+dgdREgBjCa0erlb3v4jTOm1NBZoUlHVz4elAhCL
        09MJ4KzIIiZnUZPkELKxL1u1B0EJjnE4IIwJ6PUkK7ITddthTezV8sJohQo0lklXPZ/Om554wSCAz
        aAB+WLRem8HcqAlXHUo1Qp8mSGC0DTS/1USt3JTvy8QCinXHlpkaVPdLVZq3ZW2xipFRFOnA2yea5
        ZLIl3qfZ0cwbsQ6D0Od9DykuPiIE6d7wGQbdB3NYloVSUsj/vph9glVJejDIcFzQnlgwP9ccmWmnP
        Wb7oWQ6Q==;
Received: from 177.17.250.151.dynamic.adsl.gvt.net.br ([177.17.250.151] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hKOgq-0000Be-Jw; Sat, 27 Apr 2019 14:52:33 +0000
Date:   Sat, 27 Apr 2019 11:52:27 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/27] Documentation: x86: convert entry_64.txt to reST
Message-ID: <20190427115227.5d5fd333@coco.lan>
In-Reply-To: <20190426153150.21228-7-changbin.du@gmail.com>
References: <20190426153150.21228-1-changbin.du@gmail.com>
        <20190426153150.21228-7-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 26 Apr 2019 23:31:29 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  Documentation/x86/{entry_64.txt => entry_64.rst} | 12 +++++++++---
>  Documentation/x86/index.rst                      |  1 +
>  2 files changed, 10 insertions(+), 3 deletions(-)
>  rename Documentation/x86/{entry_64.txt => entry_64.rst} (95%)
> 
> diff --git a/Documentation/x86/entry_64.txt b/Documentation/x86/entry_64.rst
> similarity index 95%
> rename from Documentation/x86/entry_64.txt
> rename to Documentation/x86/entry_64.rst
> index c1df8eba9dfd..a48b3f6ebbe8 100644
> --- a/Documentation/x86/entry_64.txt
> +++ b/Documentation/x86/entry_64.rst
> @@ -1,3 +1,9 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==============
> +Kernel Entries
> +==============
> +
>  This file documents some of the kernel entries in
>  arch/x86/entry/entry_64.S.  A lot of this explanation is adapted from
>  an email from Ingo Molnar:
> @@ -59,7 +65,7 @@ Now, there's a secondary complication: there's a cheap way to test
>  which mode the CPU is in and an expensive way.
>  
>  The cheap way is to pick this info off the entry frame on the kernel
> -stack, from the CS of the ptregs area of the kernel stack:
> +stack, from the CS of the ptregs area of the kernel stack::
>  
>  	xorl %ebx,%ebx
>  	testl $3,CS+8(%rsp)
> @@ -67,7 +73,7 @@ stack, from the CS of the ptregs area of the kernel stack:
>  	SWAPGS
>  
>  The expensive (paranoid) way is to read back the MSR_GS_BASE value
> -(which is what SWAPGS modifies):
> +(which is what SWAPGS modifies)::
>  
>  	movl $1,%ebx
>  	movl $MSR_GS_BASE,%ecx
> @@ -76,7 +82,7 @@ The expensive (paranoid) way is to read back the MSR_GS_BASE value
>  	js 1f   /* negative -> in kernel */
>  	SWAPGS
>  	xorl %ebx,%ebx
> -1:	ret
> +  1:	ret
>  
>  If we are at an interrupt or user-trap/gate-alike boundary then we can
>  use the faster check: the stack will be a reliable indicator of
> diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> index 489f4f4179c4..8a666c5abc85 100644
> --- a/Documentation/x86/index.rst
> +++ b/Documentation/x86/index.rst
> @@ -12,3 +12,4 @@ Linux x86 Support
>     topology
>     exception-tables
>     kernel-stacks
> +   entry_64


Thanks,
Mauro
