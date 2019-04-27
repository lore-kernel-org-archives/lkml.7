Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B1EC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 17:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED1C20693
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 17:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556387655;
	bh=rpv7ARZtSkn7BHhzledIz9e/X4r+F1Na41IdIcaXbDc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=G6A2QVlAgTzGFQGaqx9fi68lO1iHAiS1kzWeo/h1OtwDdS7O42P3OOW4Emejk+hzH
	 YJ1z9QjYbaISasB66Kn3XU0DpLsO5jX+TDdxnknYr47urVRoSs7fls2x4rgWbwgFfR
	 faExRbGJCHRq7HHkVvzyPulTrHPBAYy1bnadFb5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfD0RxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 13:53:11 -0400
Received: from casper.infradead.org ([85.118.1.10]:50060 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD0RxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 13:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=m/axIJWECruiJm14AvKljVic53v9dPYkge8WHqA1ALI=; b=XOU5lo4CYeiKUJH6990TycUM2v
        N8RgaSdutdWmJmaNxKhMlZBrEt6L8s7ezmKZX/Slx4vFAyQnDWlHoGMo2pGtm4U5IeMETYedKnZ5u
        p7z/JHjxaOx4lOlNY5UnlBEeu3WpycG2bmyFxGxOix1LXLbN9GbK2um0EdAYl8gqsFb2CnqXUKuJ+
        aA7SLlFmNB5FJne8X6BgQmBqUvW4OA1mJVYfF0KGJkwgjdjw7dDLVjz1pAAFnE/ZUnFlTDhfYJXHq
        ervmzseS9/4WlhF+5Gm/LOP8NcZnlwjaMFA3Fmng4DZWZ0soXA9ja9/StEhDTdNkxZQQL9CmP+JeY
        i0PJionw==;
Received: from 177.17.250.151.dynamic.adsl.gvt.net.br ([177.17.250.151] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hKRVZ-000300-EF; Sat, 27 Apr 2019 17:53:06 +0000
Date:   Sat, 27 Apr 2019 14:53:00 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/27] Documentation: x86: convert protection-keys.txt
 to reST
Message-ID: <20190427145300.29254985@coco.lan>
In-Reply-To: <20190426153150.21228-13-changbin.du@gmail.com>
References: <20190426153150.21228-1-changbin.du@gmail.com>
        <20190426153150.21228-13-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 26 Apr 2019 23:31:35 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  Documentation/x86/index.rst                   |  1 +
>  ...rotection-keys.txt => protection-keys.rst} | 33 ++++++++++++-------
>  2 files changed, 22 insertions(+), 12 deletions(-)
>  rename Documentation/x86/{protection-keys.txt => protection-keys.rst} (83%)
> 
> diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> index e06b5c0ea883..576628b121cc 100644
> --- a/Documentation/x86/index.rst
> +++ b/Documentation/x86/index.rst
> @@ -18,3 +18,4 @@ Linux x86 Support
>     tlb
>     mtrr
>     pat
> +   protection-keys
> diff --git a/Documentation/x86/protection-keys.txt b/Documentation/x86/protection-keys.rst
> similarity index 83%
> rename from Documentation/x86/protection-keys.txt
> rename to Documentation/x86/protection-keys.rst
> index ecb0d2dadfb7..49d9833af871 100644
> --- a/Documentation/x86/protection-keys.txt
> +++ b/Documentation/x86/protection-keys.rst
> @@ -1,3 +1,9 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +======================
> +Memory Protection Keys
> +======================
> +
>  Memory Protection Keys for Userspace (PKU aka PKEYs) is a feature
>  which is found on Intel's Skylake "Scalable Processor" Server CPUs.
>  It will be avalable in future non-server parts.
> @@ -23,9 +29,10 @@ even though there is theoretically space in the PAE PTEs.  These
>  permissions are enforced on data access only and have no effect on
>  instruction fetches.
>  
> -=========================== Syscalls ===========================
> +Syscalls
> +========
>  
> -There are 3 system calls which directly interact with pkeys:
> +There are 3 system calls which directly interact with pkeys::
>  
>  	int pkey_alloc(unsigned long flags, unsigned long init_access_rights)
>  	int pkey_free(int pkey);
> @@ -37,6 +44,7 @@ pkey_alloc().  An application calls the WRPKRU instruction
>  directly in order to change access permissions to memory covered
>  with a key.  In this example WRPKRU is wrapped by a C function
>  called pkey_set().
> +::
>  
>  	int real_prot = PROT_READ|PROT_WRITE;
>  	pkey = pkey_alloc(0, PKEY_DISABLE_WRITE);
> @@ -45,43 +53,44 @@ called pkey_set().
>  	... application runs here
>  
>  Now, if the application needs to update the data at 'ptr', it can
> -gain access, do the update, then remove its write access:
> +gain access, do the update, then remove its write access::
>  
>  	pkey_set(pkey, 0); // clear PKEY_DISABLE_WRITE
>  	*ptr = foo; // assign something
>  	pkey_set(pkey, PKEY_DISABLE_WRITE); // set PKEY_DISABLE_WRITE again
>  
>  Now when it frees the memory, it will also free the pkey since it
> -is no longer in use:
> +is no longer in use::
>  
>  	munmap(ptr, PAGE_SIZE);
>  	pkey_free(pkey);
>  
> -(Note: pkey_set() is a wrapper for the RDPKRU and WRPKRU instructions.
> - An example implementation can be found in
> - tools/testing/selftests/x86/protection_keys.c)
> +.. note:: pkey_set() is a wrapper for the RDPKRU and WRPKRU instructions.
> +          An example implementation can be found in
> +          tools/testing/selftests/x86/protection_keys.c.
>  
> -=========================== Behavior ===========================
> +Behavior
> +========
>  
>  The kernel attempts to make protection keys consistent with the
> -behavior of a plain mprotect().  For instance if you do this:
> +behavior of a plain mprotect().  For instance if you do this::
>  
>  	mprotect(ptr, size, PROT_NONE);
>  	something(ptr);
>  
> -you can expect the same effects with protection keys when doing this:
> +you can expect the same effects with protection keys when doing this::
>  
>  	pkey = pkey_alloc(0, PKEY_DISABLE_WRITE | PKEY_DISABLE_READ);
>  	pkey_mprotect(ptr, size, PROT_READ|PROT_WRITE, pkey);
>  	something(ptr);
>  
>  That should be true whether something() is a direct access to 'ptr'
> -like:
> +like::
>  
>  	*ptr = foo;
>  
>  or when the kernel does the access on the application's behalf like
> -with a read():
> +with a read()::
>  
>  	read(fd, ptr, 1);
>  



Thanks,
Mauro
