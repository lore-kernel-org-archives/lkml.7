Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B7DC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 17:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DE820693
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 17:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556387763;
	bh=ALrinMBOzmvPWcn0TVQBysXIHF+KLBXebfaoU6D9No4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=bdHffcoPNgvwDCzL0zHvVBnGpN0iZClC4RbOoxOPn1X/u5aTD6m9/k3Kx7AIGGu15
	 px2wsCcgG4eT5debhMgs3VRYA0JMGllmI5PlJoKyL1+rh3VTDDu3agAGmGi3K2eKDM
	 04heVXyRJWEfjQLs4LflvK85WH1lnciGZixBmlvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfD0R4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 13:56:03 -0400
Received: from casper.infradead.org ([85.118.1.10]:50212 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD0R4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 13:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IRMwCipQmbzQOz/VmePpUbaA6ieiTzkHm5Y+pjNgmk8=; b=ATUPXvdS6LCIXS9ZXmU/MLMZEC
        qOtbQLiTXnUapZhQW8aET2bId6kD0ZZSWrMJX685glqFoXm0+1IoSYv8SuiiVYve3aqPST9BoL5/U
        3+3FeeAG6uN8lsBLrcqQHdMu3LDjcbeo7mcXETVHmq1HxkcVRtcJsixIvZiUerXgj/XWEl2lKiRwA
        m0NmL3RaQXWcCdA83sz8O5pCtOwkK5GWpYHU0Ey6prMDLNY37fHcCu5sVuT6giAE66LhxaCkRS62l
        +U8qzMrl1HSkulayg4EK4OUsT9/92KB32+VZ6XI5xD+CfrKXekiN4/vHSStLWvKiDC5t7XuRy+Q+x
        F4+tgXfA==;
Received: from 177.17.250.151.dynamic.adsl.gvt.net.br ([177.17.250.151] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hKRYL-00039c-Do; Sat, 27 Apr 2019 17:55:57 +0000
Date:   Sat, 27 Apr 2019 14:55:52 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/27] Documentation: x86: convert
 amd-memory-encryption.txt to reST
Message-ID: <20190427145552.013e6bc4@coco.lan>
In-Reply-To: <20190426153150.21228-15-changbin.du@gmail.com>
References: <20190426153150.21228-1-changbin.du@gmail.com>
        <20190426153150.21228-15-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 26 Apr 2019 23:31:37 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  ...ory-encryption.txt => amd-memory-encryption.rst} | 13 ++++++++++---
>  Documentation/x86/index.rst                         |  1 +
>  2 files changed, 11 insertions(+), 3 deletions(-)
>  rename Documentation/x86/{amd-memory-encryption.txt => amd-memory-encryption.rst} (94%)
> 
> diff --git a/Documentation/x86/amd-memory-encryption.txt b/Documentation/x86/amd-memory-encryption.rst
> similarity index 94%
> rename from Documentation/x86/amd-memory-encryption.txt
> rename to Documentation/x86/amd-memory-encryption.rst
> index afc41f544dab..c48d452d0718 100644
> --- a/Documentation/x86/amd-memory-encryption.txt
> +++ b/Documentation/x86/amd-memory-encryption.rst
> @@ -1,3 +1,9 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====================
> +AMD Memory Encryption
> +=====================
> +
>  Secure Memory Encryption (SME) and Secure Encrypted Virtualization (SEV) are
>  features found on AMD processors.
>  
> @@ -34,7 +40,7 @@ is operating in 64-bit or 32-bit PAE mode, in all other modes the SEV hardware
>  forces the memory encryption bit to 1.
>  
>  Support for SME and SEV can be determined through the CPUID instruction. The
> -CPUID function 0x8000001f reports information related to SME:
> +CPUID function 0x8000001f reports information related to SME::
>  
>  	0x8000001f[eax]:
>  		Bit[0] indicates support for SME
> @@ -48,14 +54,14 @@ CPUID function 0x8000001f reports information related to SME:
>  			   addresses)
>  
>  If support for SME is present, MSR 0xc00100010 (MSR_K8_SYSCFG) can be used to
> -determine if SME is enabled and/or to enable memory encryption:
> +determine if SME is enabled and/or to enable memory encryption::
>  
>  	0xc0010010:
>  		Bit[23]   0 = memory encryption features are disabled
>  			  1 = memory encryption features are enabled
>  
>  If SEV is supported, MSR 0xc0010131 (MSR_AMD64_SEV) can be used to determine if
> -SEV is active:
> +SEV is active::
>  
>  	0xc0010131:
>  		Bit[0]	  0 = memory encryption is not active
> @@ -68,6 +74,7 @@ requirements for the system.  If this bit is not set upon Linux startup then
>  Linux itself will not set it and memory encryption will not be possible.
>  
>  The state of SME in the Linux kernel can be documented as follows:
> +
>  	- Supported:
>  	  The CPU supports SME (determined through CPUID instruction).
>  
> diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> index 20091d3e5d97..a0426ab156bd 100644
> --- a/Documentation/x86/index.rst
> +++ b/Documentation/x86/index.rst
> @@ -20,3 +20,4 @@ Linux x86 Support
>     pat
>     protection-keys
>     intel_mpx
> +   amd-memory-encryption



Thanks,
Mauro
