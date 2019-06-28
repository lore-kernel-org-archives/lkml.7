Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE11CC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C69B208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 13:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561729164;
	bh=Zz4I2Zc8Y4oVDDkGMpX2kEmE8ymQCXwUHg8ED9aiwhM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=fD4dXt8eiO8hLPm+0mT523SRLHo1JL2v6hRxNd4LWtgeKOTPqr9X4o5W+qAsvi1ab
	 TjwU6TEL4AcyE3czGQ2e3zi1M8uXWEZ9+WbQMnY4GXdYM7cRsOhfj06xMZv0mx15M3
	 R/0xrS/ooQI6clz2xz0irXKogULPI8ybB5JWJQAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfF1NjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 09:39:23 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56768 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfF1NjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 09:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Hd+4YFDiBJERyhN7PHFcmfikFE7KlUt1avVVgYQ6YVE=; b=h5NtAtFWCjXPJAeBvvp27srXa
        EIuxp0c4dUINEzOvnIwc/QaboVPbSeLVLS06mhEpJHxAlExcYKswDAgGUxy/NhloX9MMBK/HBGZt+
        Oz+2VZe8p0roNDDePtEFDwBhFYaFizmf9ERGO6Y1ZArgw4hBh+ixVWf/szAYEFO4w/WQhzowhP8s3
        x/GJa19+VLErBh3b79Fw2KAy9Eu0UudyQzK0ugsVAmDfWzvgab4s2DsuqM5Ldy1BCBI4sCLCK/rtH
        vcva1nF3pPkUgx21Dlr/p27r1Pq7mSplHFOctUB/lY+3E+KPcEeWak0yhegSeFQP8/ISSqkZF/7hJ
        7bkmTul3Q==;
Received: from [186.213.242.156] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgr5z-0007Xn-Ou; Fri, 28 Jun 2019 13:39:20 +0000
Date:   Fri, 28 Jun 2019 10:39:15 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Vandana BN <bnvandana@gmail.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-sh@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] Documentation:sh:convert register-banks.txt  and
 new-machine.txt to rst format.
Message-ID: <20190628103915.3ce83637@coco.lan>
In-Reply-To: <20190628132459.5409-1-bnvandana@gmail.com>
References: <20190627063347.11137-1-bnvandana@gmail.com>
        <20190628132459.5409-1-bnvandana@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 28 Jun 2019 18:54:59 +0530
Vandana BN <bnvandana@gmail.com> escreveu:

> This patch converts new-machine.txt and register-banks.txt to ReST format, No content
> change.
> Added new-machine.rst and register-banks.rst to sh/index.rst
> 
> Signed-off-by: Vandana BN <bnvandana@gmail.com>
> ---
>  Documentation/sh/index.rst                    |   6 +
>  .../sh/{new-machine.txt => new-machine.rst}   | 171 +++++++++---------
>  ...{register-banks.txt => register-banks.rst} |   8 +-
>  3 files changed, 100 insertions(+), 85 deletions(-)
>  rename Documentation/sh/{new-machine.txt => new-machine.rst} (79%)
>  rename Documentation/sh/{register-banks.txt => register-banks.rst} (90%)
> 
> diff --git a/Documentation/sh/index.rst b/Documentation/sh/index.rst
> index bc8db7ba894a..25471d3fc294 100644
> --- a/Documentation/sh/index.rst
> +++ b/Documentation/sh/index.rst
> @@ -57,3 +57,9 @@ Maple
> 
>  .. kernel-doc:: drivers/sh/maple/maple.c
>     :export:
> +
> +.. toctree::
> +   :maxdepth: 2
> +
> +   new-machine
> +   register-banks

Hmm... adding a toctree at the end doesn't seem the best thing to do.

Adding it at the beginning (just after the title) would be a little
better, but IMHO, moving the kernel-doc markups to another file
would make it to look better.

The remaining patch looks ok on my eyes.

> diff --git a/Documentation/sh/new-machine.txt b/Documentation/sh/new-machine.rst
> similarity index 79%
> rename from Documentation/sh/new-machine.txt
> rename to Documentation/sh/new-machine.rst
> index e0961a66130b..b16c33342642 100644
> --- a/Documentation/sh/new-machine.txt
> +++ b/Documentation/sh/new-machine.rst
> @@ -1,8 +1,8 @@
> +================================
> +Adding a new board to LinuxSH
> +================================
> 
> -                Adding a new board to LinuxSH
> -               ================================
> -
> -               Paul Mundt <lethal@linux-sh.org>
> +Paul Mundt <lethal@linux-sh.org>
> 
>  This document attempts to outline what steps are necessary to add support
>  for new boards to the LinuxSH port under the new 2.5 and 2.6 kernels. This
> @@ -19,65 +19,67 @@ include/asm-sh/. For the new kernel, things are broken out by board type,
>  companion chip type, and CPU type. Looking at a tree view of this directory
>  hierarchy looks like the following:
> 
> -Board-specific code:
> -
> -.
> -|-- arch
> -|   `-- sh
> -|       `-- boards
> -|           |-- adx
> -|           |   `-- board-specific files
> -|           |-- bigsur
> -|           |   `-- board-specific files
> -|           |
> -|           ... more boards here ...
> -|
> -`-- include
> -    `-- asm-sh
> -        |-- adx
> -        |   `-- board-specific headers
> -        |-- bigsur
> -        |   `-- board-specific headers
> -        |
> -	.. more boards here ...
> -
> -Next, for companion chips:
> -.
> -`-- arch
> -    `-- sh
> -        `-- cchips
> -            `-- hd6446x
> -                `-- hd64461
> -                    `-- cchip-specific files
> +Board-specific code::
> +
> + .
> + |-- arch
> + |   `-- sh
> + |       `-- boards
> + |           |-- adx
> + |           |   `-- board-specific files
> + |           |-- bigsur
> + |           |   `-- board-specific files
> + |           |
> + |           ... more boards here ...
> + |
> + `-- include
> +     `-- asm-sh
> +         |-- adx
> +         |   `-- board-specific headers
> +         |-- bigsur
> +         |   `-- board-specific headers
> +         |
> +       	 .. more boards here ...
> +
> +Next, for companion chips::
> +
> + .
> + `-- arch
> +     `-- sh
> +         `-- cchips
> +             `-- hd6446x
> +                 `-- hd64461
> +                     `-- cchip-specific files
> 
>  ... and so on. Headers for the companion chips are treated the same way as
>  board-specific headers. Thus, include/asm-sh/hd64461 is home to all of the
>  hd64461-specific headers.
> 
> -Finally, CPU family support is also abstracted:
> -.
> -|-- arch
> -|   `-- sh
> -|       |-- kernel
> -|       |   `-- cpu
> -|       |       |-- sh2
> -|       |       |   `-- SH-2 generic files
> -|       |       |-- sh3
> -|       |       |   `-- SH-3 generic files
> -|       |       `-- sh4
> -|       |           `-- SH-4 generic files
> -|       `-- mm
> -|           `-- This is also broken out per CPU family, so each family can
> -|               have their own set of cache/tlb functions.
> -|
> -`-- include
> -    `-- asm-sh
> -        |-- cpu-sh2
> -        |   `-- SH-2 specific headers
> -        |-- cpu-sh3
> -        |   `-- SH-3 specific headers
> -        `-- cpu-sh4
> -            `-- SH-4 specific headers
> +Finally, CPU family support is also abstracted::
> +
> + .
> + |-- arch
> + |   `-- sh
> + |       |-- kernel
> + |       |   `-- cpu
> + |       |       |-- sh2
> + |       |       |   `-- SH-2 generic files
> + |       |       |-- sh3
> + |       |       |   `-- SH-3 generic files
> + |       |       `-- sh4
> + |       |           `-- SH-4 generic files
> + |       `-- mm
> + |           `-- This is also broken out per CPU family, so each family can
> + |               have their own set of cache/tlb functions.
> + |
> + `-- include
> +     `-- asm-sh
> +         |-- cpu-sh2
> +         |   `-- SH-2 specific headers
> +         |-- cpu-sh3
> +         |   `-- SH-3 specific headers
> +         `-- cpu-sh4
> +             `-- SH-4 specific headers
> 
>  It should be noted that CPU subtypes are _not_ abstracted. Thus, these still
>  need to be dealt with by the CPU family specific code.
> @@ -112,18 +114,20 @@ setup code, we're required at the very least to provide definitions for
>  get_system_type() and platform_setup(). For our imaginary board, this
>  might look something like:
> 
> -/*
> - * arch/sh/boards/vapor/setup.c - Setup code for imaginary board
> - */
> -#include <linux/init.h>
> +.. code-block:: c
> +
> +    /*
> +     * arch/sh/boards/vapor/setup.c - Setup code for imaginary board
> +     */
> +    #include <linux/init.h>
> 
> -const char *get_system_type(void)
> -{
> -	return "FooTech Vaporboard";
> -}
> +    const char *get_system_type(void)
> +    {
> +        return "FooTech Vaporboard";
> +    }
> 
> -int __init platform_setup(void)
> -{
> +    int __init platform_setup(void)
> +    {
>    	/*
>  	 * If our hardware actually existed, we would do real
>  	 * setup here. Though it's also sane to leave this empty
> @@ -136,7 +140,8 @@ int __init platform_setup(void)
>  	/* And whatever else ... */
> 
>  	return 0;
> -}
> +    }
> +
> 
>  Our new imaginary board will also have to tie into the machvec in order for it
>  to be of any use.
> @@ -172,16 +177,17 @@ sufficient.
>     vector.
> 
>     Note that these prototypes are generated automatically by setting
> -   __IO_PREFIX to something sensible. A typical example would be:
> +   __IO_PREFIX to something sensible. A typical example would be::
> 
>  	#define __IO_PREFIX vapor
>     	#include <asm/io_generic.h>
> 
> +
>     somewhere in the board-specific header. Any boards being ported that still
>     have a legacy io.h should remove it entirely and switch to the new model.
> 
>   - Add machine vector definitions to the board's setup.c. At a bare minimum,
> -   this must be defined as something like:
> +   this must be defined as something like::
> 
>  	struct sh_machine_vector mv_vapor __initmv = {
>  		.mv_name = "vapor",
> @@ -202,11 +208,11 @@ Large portions of the build system are now entirely dynamic, and merely
>  require the proper entry here and there in order to get things done.
> 
>  The first thing to do is to add an entry to arch/sh/Kconfig, under the
> -"System type" menu:
> +"System type" menu::
> 
> -config SH_VAPOR
> -	bool "Vapor"
> -	help
> + config SH_VAPOR
> +	 bool "Vapor"
> +	 help
>  	  select Vapor if configuring for a FooTech Vaporboard.
> 
>  next, this has to be added into arch/sh/Makefile. All boards require a
> @@ -232,6 +238,8 @@ space restating it here. After this is done, you will be able to use
>  implicit checks for your board if you need this somewhere throughout the
>  common code, such as:
> 
> +::
> +
>  	/* Make sure we're on the FooTech Vaporboard */
>  	if (!mach_is_vapor())
>  		return -ENODEV;
> @@ -253,12 +261,13 @@ build target, and it will be implicitly listed as such in the help text.
>  Looking at the 'make help' output, you should now see something like:
> 
>  Architecture specific targets (sh):
> -  zImage                  - Compressed kernel image (arch/sh/boot/zImage)
> -  adx_defconfig           - Build for adx
> -  cqreek_defconfig        - Build for cqreek
> -  dreamcast_defconfig     - Build for dreamcast
> -...
> -  vapor_defconfig         - Build for vapor
> +
> + - zImage                  - Compressed kernel image (arch/sh/boot/zImage)
> + - adx_defconfig           - Build for adx
> + - cqreek_defconfig        - Build for cqreek
> + - dreamcast_defconfig     - Build for dreamcast
> + - ...
> + - vapor_defconfig         - Build for vapor
> 
>  which then allows you to do:
> 
> diff --git a/Documentation/sh/register-banks.txt b/Documentation/sh/register-banks.rst
> similarity index 90%
> rename from Documentation/sh/register-banks.txt
> rename to Documentation/sh/register-banks.rst
> index a6719f2f6594..acccfaf80355 100644
> --- a/Documentation/sh/register-banks.txt
> +++ b/Documentation/sh/register-banks.rst
> @@ -1,8 +1,9 @@
> -	Notes on register bank usage in the kernel
> -	==========================================
> +==========================================
> +Notes on register bank usage in the kernel
> +==========================================
> 
>  Introduction
> -------------
> +============
> 
>  The SH-3 and SH-4 CPU families traditionally include a single partial register
>  bank (selected by SR.RB, only r0 ... r7 are banked), whereas other families
> @@ -30,4 +31,3 @@ Presently the kernel uses several of these registers.
>  		- The SR.IMASK interrupt handler makes use of this to set the
>  		  interrupt priority level (used by local_irq_enable())
>  	- r7_bank (current)
> -
> --
> 2.17.1
> 



Thanks,
Mauro
