Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9F4C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 18:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B889E2087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 18:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556390174;
	bh=FBJHMsWumH5WlS3YjdVNZxeJnXVbeQnhC2ezA5BQfcM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=gPl6m6616nE1ZIs8/CsHs1fdekNl/tNp6tDnr1b2XTB9CBRDv4NJSJwOk8Y5Vbize
	 Udwbv+m2ISeGUbHYjU5yg5OGhsqeQC4z1uTj6AinCETh6QIlD28tjHQci4dC5vJhHs
	 FJf8NMVtl8/UMeS2WzcV5EPeETsVgpDYHV3eWrCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfD0SgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 14:36:13 -0400
Received: from casper.infradead.org ([85.118.1.10]:52398 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD0SgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 14:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WQj6gXdzFR8miqmqebftfIL9RL+iHbuv/4bZGOk/lPI=; b=SSrgUtClOHxQ3RNxLQrl4adp6C
        fR8zqK3PUGkHTRmjRU3asYhs9mlJCKdygFny8+VVFrymeuEALMCEkScAD1UOJToARL8YmZCBIgCIh
        f+fX1B3EokfNwdK9H2LE2m/V5/WJNAWaBKn3pXcJf8R5Eqt4klWV5ovbyK7hojRobEUJllxNF2nZ5
        DI47+gc+qwjZNc19LU5jQ8cOyBUiXl2zitAMJ+OurPlJZvjRsS6EhVIsxsAicLy0ArIZzl/gTf15i
        486bl6Uk3uyIc6i9O+E9ZTO0OdQa7W/UYzQUVB4DZd31AW3tabFKuPS6EX2bODDELr9CkMULLmxmL
        inAc898Q==;
Received: from 177.17.250.151.dynamic.adsl.gvt.net.br ([177.17.250.151] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hKSBD-00059f-GC; Sat, 27 Apr 2019 18:36:08 +0000
Date:   Sat, 27 Apr 2019 15:36:02 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/27] Documentation: x86: convert
 x86_64/5level-paging.txt to reST
Message-ID: <20190427153602.14835973@coco.lan>
In-Reply-To: <20190426153150.21228-25-changbin.du@gmail.com>
References: <20190426153150.21228-1-changbin.du@gmail.com>
        <20190426153150.21228-25-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 26 Apr 2019 23:31:47 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  .../{5level-paging.txt => 5level-paging.rst}     | 16 +++++++++++-----
>  Documentation/x86/x86_64/index.rst               |  1 +
>  2 files changed, 12 insertions(+), 5 deletions(-)
>  rename Documentation/x86/x86_64/{5level-paging.txt => 5level-paging.rst} (91%)
> 
> diff --git a/Documentation/x86/x86_64/5level-paging.txt b/Documentation/x86/x86_64/5level-paging.rst
> similarity index 91%
> rename from Documentation/x86/x86_64/5level-paging.txt
> rename to Documentation/x86/x86_64/5level-paging.rst
> index 2432a5ef86d9..ab88a4514163 100644
> --- a/Documentation/x86/x86_64/5level-paging.txt
> +++ b/Documentation/x86/x86_64/5level-paging.rst
> @@ -1,5 +1,11 @@
> -== Overview ==
> +.. SPDX-License-Identifier: GPL-2.0
>  
> +==============
> +5-level paging
> +==============
> +
> +Overview
> +========
>  Original x86-64 was limited by 4-level paing to 256 TiB of virtual address
>  space and 64 TiB of physical address space. We are already bumping into
>  this limit: some vendors offers servers with 64 TiB of memory today.
> @@ -16,16 +22,17 @@ QEMU 2.9 and later support 5-level paging.
>  Virtual memory layout for 5-level paging is described in
>  Documentation/x86/x86_64/mm.txt
>  
> -== Enabling 5-level paging ==
>  
> +Enabling 5-level paging
> +=======================
>  CONFIG_X86_5LEVEL=y enables the feature.
>  
>  Kernel with CONFIG_X86_5LEVEL=y still able to boot on 4-level hardware.
>  In this case additional page table level -- p4d -- will be folded at
>  runtime.
>  
> -== User-space and large virtual address space ==
> -
> +User-space and large virtual address space
> +==========================================
>  On x86, 5-level paging enables 56-bit userspace virtual address space.
>  Not all user space is ready to handle wide addresses. It's known that
>  at least some JIT compilers use higher bits in pointers to encode their
> @@ -58,4 +65,3 @@ One important case we need to handle here is interaction with MPX.
>  MPX (without MAWA extension) cannot handle addresses above 47-bit, so we
>  need to make sure that MPX cannot be enabled we already have VMA above
>  the boundary and forbid creating such VMAs once MPX is enabled.
> -
> diff --git a/Documentation/x86/x86_64/index.rst b/Documentation/x86/x86_64/index.rst
> index 4b65d29ef459..7b8c82151358 100644
> --- a/Documentation/x86/x86_64/index.rst
> +++ b/Documentation/x86/x86_64/index.rst
> @@ -10,3 +10,4 @@ x86_64 Support
>     boot-options
>     uefi
>     mm
> +   5level-paging



Thanks,
Mauro
