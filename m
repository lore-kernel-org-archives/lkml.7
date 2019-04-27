Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3269EC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 17:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD2B020693
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 17:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556387701;
	bh=PQg3nTZzwOj2l47QoCddRaChy5RXVs8mbS2AMopPjvk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=eh26x4ORVkgLnExELtLtHjBeVvdUMw004NLR1T5MYIMCM7jUMHt7S33QpK3HG9AEa
	 IIKLCcqHPQWXpXpPInpe+RLEHW4aJOKqvIFvSdHqsx43sm9PaDLAR1b3kn0iARDVwM
	 zfzMq6LCoUP0JDJvz/VtJ3izu7zzwMJ8z1DF5WXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfD0Ry7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 13:54:59 -0400
Received: from casper.infradead.org ([85.118.1.10]:50148 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD0Ry7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 13:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VnGv60lXWgCIm1Lv059d8K9VsK+We4cgVeyWKgpYt4Y=; b=Se2y9twjLLfMaCF0z8rZaLeuG7
        p5EHNTtLhho6yA9d8zzjjMMdxbvKVA8GnCHXSFE/bU42RTNe/uTXzDWK8gGAUhHFakcjM7t+EoNoE
        1FP5+aEppgCkhD0qSd4M3hk7OUrpnFydzE9E2BVf/QBCe9AnqYDxlm7ff+e5EJm2kqOpqLV+DkenW
        MqwpW41By1WhwymxXdNr4Qv+Io3lLowFMjX9YEpbxyj4WrdVyC+ydUpn4wYA6swHvfXkg/nK//MxY
        SpHvsxllwgJQ41CyOZAy+1/vq3N6L+7aifTpJ82SNl9+NvycKfwZWRp0t0tk0JaBmAKCJTaSmhph8
        J0BWVAbw==;
Received: from 177.17.250.151.dynamic.adsl.gvt.net.br ([177.17.250.151] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hKRXI-00035Z-5o; Sat, 27 Apr 2019 17:54:52 +0000
Date:   Sat, 27 Apr 2019 14:54:47 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/27] Documentation: x86: convert intel_mpx.txt to reST
Message-ID: <20190427145447.4312c114@coco.lan>
In-Reply-To: <20190426153150.21228-14-changbin.du@gmail.com>
References: <20190426153150.21228-1-changbin.du@gmail.com>
        <20190426153150.21228-14-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 26 Apr 2019 23:31:36 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  Documentation/x86/index.rst                   |   1 +
>  .../x86/{intel_mpx.txt => intel_mpx.rst}      | 120 ++++++++++--------
>  2 files changed, 65 insertions(+), 56 deletions(-)
>  rename Documentation/x86/{intel_mpx.txt => intel_mpx.rst} (75%)
> 
> diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> index 576628b121cc..20091d3e5d97 100644
> --- a/Documentation/x86/index.rst
> +++ b/Documentation/x86/index.rst
> @@ -19,3 +19,4 @@ Linux x86 Support
>     mtrr
>     pat
>     protection-keys
> +   intel_mpx
> diff --git a/Documentation/x86/intel_mpx.txt b/Documentation/x86/intel_mpx.rst
> similarity index 75%
> rename from Documentation/x86/intel_mpx.txt
> rename to Documentation/x86/intel_mpx.rst
> index 85d0549ad846..387a640941a6 100644
> --- a/Documentation/x86/intel_mpx.txt
> +++ b/Documentation/x86/intel_mpx.rst
> @@ -1,5 +1,11 @@
> -1. Intel(R) MPX Overview
> -========================
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===========================================
> +Intel(R) Memory Protection Extensions (MPX)
> +===========================================
> +
> +Intel(R) MPX Overview
> +=====================
>  
>  Intel(R) Memory Protection Extensions (Intel(R) MPX) is a new capability
>  introduced into Intel Architecture. Intel MPX provides hardware features
> @@ -7,7 +13,7 @@ that can be used in conjunction with compiler changes to check memory
>  references, for those references whose compile-time normal intentions are
>  usurped at runtime due to buffer overflow or underflow.
>  
> -You can tell if your CPU supports MPX by looking in /proc/cpuinfo:
> +You can tell if your CPU supports MPX by looking in /proc/cpuinfo::
>  
>  	cat /proc/cpuinfo  | grep ' mpx '
>  
> @@ -21,8 +27,8 @@ can be downloaded from
>  http://software.intel.com/en-us/articles/intel-software-development-emulator
>  
>  
> -2. How to get the advantage of MPX
> -==================================
> +How to get the advantage of MPX
> +===============================
>  
>  For MPX to work, changes are required in the kernel, binutils and compiler.
>  No source changes are required for applications, just a recompile.
> @@ -84,14 +90,15 @@ Kernel MPX Code:
>     is unmapped.
>  
>  
> -3. How does MPX kernel code work
> -================================
> +How does MPX kernel code work
> +=============================
>  
>  Handling #BR faults caused by MPX
>  ---------------------------------
>  
>  When MPX is enabled, there are 2 new situations that can generate
>  #BR faults.
> +
>    * new bounds tables (BT) need to be allocated to save bounds.
>    * bounds violation caused by MPX instructions.
>  
> @@ -124,37 +131,37 @@ the kernel. It can theoretically be done completely from userspace. Here
>  are a few ways this could be done. We don't think any of them are practical
>  in the real-world, but here they are.
>  
> -Q: Can virtual space simply be reserved for the bounds tables so that we
> -   never have to allocate them?
> -A: MPX-enabled application will possibly create a lot of bounds tables in
> -   process address space to save bounds information. These tables can take
> -   up huge swaths of memory (as much as 80% of the memory on the system)
> -   even if we clean them up aggressively. In the worst-case scenario, the
> -   tables can be 4x the size of the data structure being tracked. IOW, a
> -   1-page structure can require 4 bounds-table pages. An X-GB virtual
> -   area needs 4*X GB of virtual space, plus 2GB for the bounds directory.
> -   If we were to preallocate them for the 128TB of user virtual address
> -   space, we would need to reserve 512TB+2GB, which is larger than the
> -   entire virtual address space today. This means they can not be reserved
> -   ahead of time. Also, a single process's pre-populated bounds directory
> -   consumes 2GB of virtual *AND* physical memory. IOW, it's completely
> -   infeasible to prepopulate bounds directories.
> -
> -Q: Can we preallocate bounds table space at the same time memory is
> -   allocated which might contain pointers that might eventually need
> -   bounds tables?
> -A: This would work if we could hook the site of each and every memory
> -   allocation syscall. This can be done for small, constrained applications.
> -   But, it isn't practical at a larger scale since a given app has no
> -   way of controlling how all the parts of the app might allocate memory
> -   (think libraries). The kernel is really the only place to intercept
> -   these calls.
> -
> -Q: Could a bounds fault be handed to userspace and the tables allocated
> -   there in a signal handler instead of in the kernel?
> -A: mmap() is not on the list of safe async handler functions and even
> -   if mmap() would work it still requires locking or nasty tricks to
> -   keep track of the allocation state there.
> +:Q: Can virtual space simply be reserved for the bounds tables so that we
> +    never have to allocate them?
> +:A: MPX-enabled application will possibly create a lot of bounds tables in
> +    process address space to save bounds information. These tables can take
> +    up huge swaths of memory (as much as 80% of the memory on the system)
> +    even if we clean them up aggressively. In the worst-case scenario, the
> +    tables can be 4x the size of the data structure being tracked. IOW, a
> +    1-page structure can require 4 bounds-table pages. An X-GB virtual
> +    area needs 4*X GB of virtual space, plus 2GB for the bounds directory.
> +    If we were to preallocate them for the 128TB of user virtual address
> +    space, we would need to reserve 512TB+2GB, which is larger than the
> +    entire virtual address space today. This means they can not be reserved
> +    ahead of time. Also, a single process's pre-populated bounds directory
> +    consumes 2GB of virtual *AND* physical memory. IOW, it's completely
> +    infeasible to prepopulate bounds directories.
> +
> +:Q: Can we preallocate bounds table space at the same time memory is
> +    allocated which might contain pointers that might eventually need
> +    bounds tables?
> +:A: This would work if we could hook the site of each and every memory
> +    allocation syscall. This can be done for small, constrained applications.
> +    But, it isn't practical at a larger scale since a given app has no
> +    way of controlling how all the parts of the app might allocate memory
> +    (think libraries). The kernel is really the only place to intercept
> +    these calls.
> +
> +:Q: Could a bounds fault be handed to userspace and the tables allocated
> +    there in a signal handler instead of in the kernel?
> +:A: mmap() is not on the list of safe async handler functions and even
> +    if mmap() would work it still requires locking or nasty tricks to
> +    keep track of the allocation state there.
>  
>  Having ruled out all of the userspace-only approaches for managing
>  bounds tables that we could think of, we create them on demand in
> @@ -167,20 +174,20 @@ If a #BR is generated due to a bounds violation caused by MPX.
>  We need to decode MPX instructions to get violation address and
>  set this address into extended struct siginfo.
>  
> -The _sigfault field of struct siginfo is extended as follow:
> -
> -87		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
> -88		struct {
> -89			void __user *_addr; /* faulting insn/memory ref. */
> -90 #ifdef __ARCH_SI_TRAPNO
> -91			int _trapno;	/* TRAP # which caused the signal */
> -92 #endif
> -93			short _addr_lsb; /* LSB of the reported address */
> -94			struct {
> -95				void __user *_lower;
> -96				void __user *_upper;
> -97			} _addr_bnd;
> -98		} _sigfault;
> +The _sigfault field of struct siginfo is extended as follow::
> +
> +  87		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
> +  88		struct {
> +  89			void __user *_addr; /* faulting insn/memory ref. */
> +  90 #ifdef __ARCH_SI_TRAPNO
> +  91			int _trapno;	/* TRAP # which caused the signal */
> +  92 #endif
> +  93			short _addr_lsb; /* LSB of the reported address */
> +  94			struct {
> +  95				void __user *_lower;
> +  96				void __user *_upper;
> +  97			} _addr_bnd;
> +  98		} _sigfault;
>  
>  The '_addr' field refers to violation address, and new '_addr_and'
>  field refers to the upper/lower bounds when a #BR is caused.
> @@ -209,9 +216,10 @@ Adding new prctl commands
>  
>  Two new prctl commands are added to enable and disable MPX bounds tables
>  management in kernel.
> +::
>  
> -155	#define PR_MPX_ENABLE_MANAGEMENT	43
> -156	#define PR_MPX_DISABLE_MANAGEMENT	44
> +  155	#define PR_MPX_ENABLE_MANAGEMENT	43
> +  156	#define PR_MPX_DISABLE_MANAGEMENT	44
>  
>  Runtime library in userspace is responsible for allocation of bounds
>  directory. So kernel have to use XSAVE instruction to get the base
> @@ -223,8 +231,8 @@ into struct mm_struct to be used in future during PR_MPX_ENABLE_MANAGEMENT
>  command execution.
>  
>  
> -4. Special rules
> -================
> +Special rules
> +=============
>  
>  1) If userspace is requesting help from the kernel to do the management
>  of bounds tables, it may not create or modify entries in the bounds directory.



Thanks,
Mauro
