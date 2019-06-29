Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13EBC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 14:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A31F5214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 14:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561819827;
	bh=p06EEZw/16J98SHHIG2V2jv3ve9wq/5v7TP+jNfOyEU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=1ZLX0KgiUYM1044RaG/GVwq+uTjmGV2aBh9mPk5g5bpEF2YFSTDIgK5orgqR7OAjv
	 yvuWw29ivbP7Bypc63ba8p2TfKD5Y/jl5Vbn1GiCT5cZiuTAUZMnB1uclH2MAVlEXP
	 3jY2tz+1s12eo8mhZHOmhcJydEg32qbwk/CBG0Pk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfF2Ou0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 10:50:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40444 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfF2Ou0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 10:50:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HR9sUUtadeDa6dTUCIaVdVppvJqC20s36AY/DBTi9LQ=; b=S6buaDLcudLTL4Hz/02AJglhi
        s6oQpKQM7se/4kXJ1qPjTkUBPAXZp/p7CY/Ofylg97YhZOVcG/2FcWH/PdgrTgeVjMMPLndXwCwza
        DE1p7Y4H9U57Mw0doLWEMZBOa3R8r37MGy4gZL30RhXl561WkPNhBSUSLSkOeFWuKLjsGrHpDTH8G
        z1C0SnaDe8H+u7FD2VkvDTaxFjO5sgT0bkfmZOU1YHEgQ1OzgKjw9MFR2HQtZT3KWe6f7gclBhTuU
        MHFbcj18XWe35uuxTgCl3XVjoz97zCOJd628pdPFwXpPTHtTP7zk7FSnvkkXeMEjVprpZS6RYWQey
        DWlAlH4DA==;
Received: from [187.113.3.250] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hhEgG-00086H-BB; Sat, 29 Jun 2019 14:50:20 +0000
Date:   Sat, 29 Jun 2019 11:50:14 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Vandana BN <bnvandana@gmail.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-sh@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v4] Documentation:sh:convert register-banks.txt  and
 new-machine.txt to rst format.
Message-ID: <20190629115014.4aec058d@coco.lan>
In-Reply-To: <20190629143245.3580-1-bnvandana@gmail.com>
References: <20190627063347.11137-1-bnvandana@gmail.com>
        <20190629143245.3580-1-bnvandana@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, 29 Jun 2019 20:02:45 +0530
Vandana BN <bnvandana@gmail.com> escreveu:

> This patch converts new-machine.txt and register-banks.txt
> to ReST format, No content change.
> Added interfaces.rst to contain kernel-doc markups from index.rst
> Added interfaces.rst,new-machine.rst and register-banks.rst to sh/index.rst
> Added SPDX tag in index.rst
> 
> Signed-off-by: Vandana BN <bnvandana@gmail.com>

Looks good to me. Just a final thing to do.

Be sure to run:

	./scripts/documentation-file-ref-check

in order to check that you're not breaking any references to the file.
If it breaks, please adjust the reference to reflect the file
rename.

After fixing the broken reference, feel free do add:

Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>

> ---
>  Documentation/sh/index.rst                    |  65 +------
>  Documentation/sh/interface.rst                |  59 ++++++
>  .../sh/{new-machine.txt => new-machine.rst}   | 171 +++++++++---------
>  ...{register-banks.txt => register-banks.rst} |   8 +-
>  4 files changed, 163 insertions(+), 140 deletions(-)
>  create mode 100644 Documentation/sh/interface.rst
>  rename Documentation/sh/{new-machine.txt => new-machine.rst} (79%)
>  rename Documentation/sh/{register-banks.txt => register-banks.rst} (90%)
> 
> diff --git a/Documentation/sh/index.rst b/Documentation/sh/index.rst
> index bc8db7ba894a..fec3c405b6b9 100644
> --- a/Documentation/sh/index.rst
> +++ b/Documentation/sh/index.rst
> @@ -1,59 +1,14 @@
> -=======================
> -SuperH Interfaces Guide
> -=======================
> +.. SPDX-License-Identifier: GPL-2.0
> 
> -:Author: Paul Mundt
> -
> -Memory Management
> -=================
> -
> -SH-4
> -----
> -
> -Store Queue API
> -~~~~~~~~~~~~~~~
> -
> -.. kernel-doc:: arch/sh/kernel/cpu/sh4/sq.c
> -   :export:
> -
> -SH-5
> -----
> -
> -TLB Interfaces
> -~~~~~~~~~~~~~~
> -
> -.. kernel-doc:: arch/sh/mm/tlb-sh5.c
> -   :internal:
> -
> -.. kernel-doc:: arch/sh/include/asm/tlb_64.h
> -   :internal:
> +====================
> +SuperH Documentation
> +====================
> 
> -Machine Specific Interfaces
> -===========================
> -
> -mach-dreamcast
> ---------------
> -
> -.. kernel-doc:: arch/sh/boards/mach-dreamcast/rtc.c
> -   :internal:
> -
> -mach-x3proto
> -------------
> -
> -.. kernel-doc:: arch/sh/boards/mach-x3proto/ilsel.c
> -   :export:
> -
> -Busses
> -======
> -
> -SuperHyway
> -----------
> -
> -.. kernel-doc:: drivers/sh/superhyway/superhyway.c
> -   :export:
> +:Author: Paul Mundt
> 
> -Maple
> ------
> +.. toctree::
> +   :maxdepth: 2
> 
> -.. kernel-doc:: drivers/sh/maple/maple.c
> -   :export:
> +   interface
> +   new-machine
> +   register-banks
> diff --git a/Documentation/sh/interface.rst b/Documentation/sh/interface.rst
> new file mode 100644
> index 000000000000..bc8db7ba894a
> --- /dev/null
> +++ b/Documentation/sh/interface.rst
> @@ -0,0 +1,59 @@
> +=======================
> +SuperH Interfaces Guide
> +=======================
> +
> +:Author: Paul Mundt
> +
> +Memory Management
> +=================
> +
> +SH-4
> +----
> +
> +Store Queue API
> +~~~~~~~~~~~~~~~
> +
> +.. kernel-doc:: arch/sh/kernel/cpu/sh4/sq.c
> +   :export:
> +
> +SH-5
> +----
> +
> +TLB Interfaces
> +~~~~~~~~~~~~~~
> +
> +.. kernel-doc:: arch/sh/mm/tlb-sh5.c
> +   :internal:
> +
> +.. kernel-doc:: arch/sh/include/asm/tlb_64.h
> +   :internal:
> +
> +Machine Specific Interfaces
> +===========================
> +
> +mach-dreamcast
> +--------------
> +
> +.. kernel-doc:: arch/sh/boards/mach-dreamcast/rtc.c
> +   :internal:
> +
> +mach-x3proto
> +------------
> +
> +.. kernel-doc:: arch/sh/boards/mach-x3proto/ilsel.c
> +   :export:
> +
> +Busses
> +======
> +
> +SuperHyway
> +----------
> +
> +.. kernel-doc:: drivers/sh/superhyway/superhyway.c
> +   :export:
> +
> +Maple
> +-----
> +
> +.. kernel-doc:: drivers/sh/maple/maple.c
> +   :export:
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
