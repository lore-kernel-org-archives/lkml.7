Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8820C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 18:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947B42087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 18:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556389910;
	bh=d3DJjawEwF+6C2mJN9WhXTAhirTuBKrVbPAglHnUhL4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=vJ2lI0MYLcABWInuDPx+X5GInGnfFciXrUY89MQq2To09OViCQXWK7zII/sICNLWF
	 WA+bvJSzwU0kP5vD6w3SDtU6aVATNu9YpTqJ3mSQ+VCLMACH2yxJydjJl31c5gW06r
	 vV3a9U5LNIoLfQfC1pcY755ggBByUAJ4/zNvW6IU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfD0Sbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 14:31:49 -0400
Received: from casper.infradead.org ([85.118.1.10]:52034 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD0Sbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 14:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1uHpzDXyV3o5TkJ1PZo+a8SqCH8uszKNt3MHK980r4w=; b=V7dv+80si9QpFL29SSpsmFJE0E
        wngeMOLSTujsEXl348wjFORnba9tQokLgfphsK8qU0MAOonbsOEi3BtnRUw8JhMULI5qCpB0HG58V
        L2QjbAsQWa1Yer1xJZqyQFHxx2PEBzUqg11PHc/9H+8kq4/oGOtGgI1gM4PjTccPkDim0mIJCZDoo
        DZztBwTbw3ffl+TxhlHrqmYFR0/AEAkg73ftL7uIDabqiWvX/N9AIpE8YWE/wYuBhVG4yGZ8FgzVI
        9Mjk/iFEUOwTpo3kT/8PkiFN9+wX3YUOi4rK3AaMcYP6JGIMN211yIlt2+4HrTBAdi6G3XM1lMmGC
        GSPE4uCQ==;
Received: from 177.17.250.151.dynamic.adsl.gvt.net.br ([177.17.250.151] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hKS6w-0004tI-PE; Sat, 27 Apr 2019 18:31:43 +0000
Date:   Sat, 27 Apr 2019 15:31:37 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/27] Documentation: x86: convert x86_64/uefi.txt to
 reST
Message-ID: <20190427153137.0bab2ab7@coco.lan>
In-Reply-To: <20190426153150.21228-23-changbin.du@gmail.com>
References: <20190426153150.21228-1-changbin.du@gmail.com>
        <20190426153150.21228-23-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 26 Apr 2019 23:31:45 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  Documentation/x86/x86_64/index.rst            |  1 +
>  .../x86/x86_64/{uefi.txt => uefi.rst}         | 30 ++++++++++++++-----
>  2 files changed, 24 insertions(+), 7 deletions(-)
>  rename Documentation/x86/x86_64/{uefi.txt => uefi.rst} (79%)
> 
> diff --git a/Documentation/x86/x86_64/index.rst b/Documentation/x86/x86_64/index.rst
> index a8cf7713cac9..ddfa1f9d4193 100644
> --- a/Documentation/x86/x86_64/index.rst
> +++ b/Documentation/x86/x86_64/index.rst
> @@ -8,3 +8,4 @@ x86_64 Support
>     :maxdepth: 2
>  
>     boot-options
> +   uefi
> diff --git a/Documentation/x86/x86_64/uefi.txt b/Documentation/x86/x86_64/uefi.rst
> similarity index 79%
> rename from Documentation/x86/x86_64/uefi.txt
> rename to Documentation/x86/x86_64/uefi.rst
> index a5e2b4fdb170..88c3ba32546f 100644
> --- a/Documentation/x86/x86_64/uefi.txt
> +++ b/Documentation/x86/x86_64/uefi.rst
> @@ -1,5 +1,8 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====================================
>  General note on [U]EFI x86_64 support
> --------------------------------------
> +=====================================
>  
>  The nomenclature EFI and UEFI are used interchangeably in this document.
>  
> @@ -14,29 +17,42 @@ with EFI firmware and specifications are listed below.
>  
>  3. x86_64 platform with EFI/UEFI firmware.
>  
> -Mechanics:
> +Mechanics
>  ---------
> -- Build the kernel with the following configuration.
> +
> +- Build the kernel with the following configuration::
> +
>  	CONFIG_FB_EFI=y
>  	CONFIG_FRAMEBUFFER_CONSOLE=y
> +
>    If EFI runtime services are expected, the following configuration should
> -  be selected.
> +  be selected::
> +
>  	CONFIG_EFI=y
>  	CONFIG_EFI_VARS=y or m		# optional
> +
>  - Create a VFAT partition on the disk
>  - Copy the following to the VFAT partition:
> +
>  	elilo bootloader with x86_64 support, elilo configuration file,
>  	kernel image built in first step and corresponding
>  	initrd. Instructions on building elilo	and its dependencies
>  	can be found in the elilo sourceforge project.
> +
>  - Boot to EFI shell and invoke elilo choosing the kernel image built
>    in first step.
>  - If some or all EFI runtime services don't work, you can try following
>    kernel command line parameters to turn off some or all EFI runtime
>    services.
> -	noefi		turn off all EFI runtime services
> -	reboot_type=k	turn off EFI reboot runtime service
> +
> +	noefi
> +		turn off all EFI runtime services
> +	reboot_type=k
> +		turn off EFI reboot runtime service
> +
>  - If the EFI memory map has additional entries not in the E820 map,
>    you can include those entries in the kernels memory map of available
>    physical RAM by using the following kernel command line parameter.
> -	add_efi_memmap	include EFI memory map of available physical RAM
> +
> +	add_efi_memmap
> +		include EFI memory map of available physical RAM



Thanks,
Mauro
