Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2E7C10F00
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259B220840
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfCFVBF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:01:05 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:47128 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbfCFVBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:01:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 83B26608A387;
        Wed,  6 Mar 2019 22:01:02 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id MYKFNp8BqHXm; Wed,  6 Mar 2019 22:01:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 27C8F608A38A;
        Wed,  6 Mar 2019 22:01:02 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fhfYwcal_9De; Wed,  6 Mar 2019 22:01:02 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id C9B95608A387;
        Wed,  6 Mar 2019 22:01:01 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, jdike@addtoit.com,
        anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org
Subject: Re: [PATCH] arch: um: Kconfig: pedantic cleanups
Date:   Wed, 06 Mar 2019 22:01:01 +0100
Message-ID: <31062067.NyzppZ7ELz@blindfold>
In-Reply-To: <1551896897-30963-1-git-send-email-info@metux.net>
References: <1551896897-30963-1-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 6. März 2019, 19:28:17 CET schrieb Enrico Weigelt, metux IT consult:

Can we please have a changelog?

Thanks,
//richard

> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  arch/um/Kconfig | 52 ++++++++++++++++++++++++++--------------------------
>  1 file changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index ec9711d..216ee50 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -80,46 +80,46 @@ config LD_SCRIPT_DYN
>  	bool
>  	default y
>  	depends on !LD_SCRIPT_STATIC
> -        select MODULE_REL_CRCS if MODVERSIONS
> +	select MODULE_REL_CRCS if MODVERSIONS
>  
>  config HOSTFS
>  	tristate "Host filesystem"
>  	help
> -          While the User-Mode Linux port uses its own root file system for
> -          booting and normal file access, this module lets the UML user
> -          access files stored on the host.  It does not require any
> -          network connection between the Host and UML.  An example use of
> -          this might be:
> +	  While the User-Mode Linux port uses its own root file system for
> +	  booting and normal file access, this module lets the UML user
> +	  access files stored on the host.  It does not require any
> +	  network connection between the Host and UML.  An example use of
> +	  this might be:
>  
> -          mount none /tmp/fromhost -t hostfs -o /tmp/umlshare
> +	  mount none /tmp/fromhost -t hostfs -o /tmp/umlshare
>  
> -          where /tmp/fromhost is an empty directory inside UML and
> -          /tmp/umlshare is a directory on the host with files the UML user
> -          wishes to access.
> +	  where /tmp/fromhost is an empty directory inside UML and
> +	  /tmp/umlshare is a directory on the host with files the UML user
> +	  wishes to access.
>  
> -          For more information, see
> -          <http://user-mode-linux.sourceforge.net/hostfs.html>.
> +	  For more information, see
> +	  <http://user-mode-linux.sourceforge.net/hostfs.html>.
>  
> -          If you'd like to be able to work with files stored on the host,
> -          say Y or M here; otherwise say N.
> +	  If you'd like to be able to work with files stored on the host,
> +	  say Y or M here; otherwise say N.
>  
>  config MCONSOLE
>  	bool "Management console"
>  	depends on PROC_FS
>  	default y
>  	help
> -          The user mode linux management console is a low-level interface to
> -          the kernel, somewhat like the i386 SysRq interface.  Since there is
> -          a full-blown operating system running under every user mode linux
> -          instance, there is much greater flexibility possible than with the
> -          SysRq mechanism.
> -
> -          If you answer 'Y' to this option, to use this feature, you need the
> -          mconsole client (called uml_mconsole) which is present in CVS in
> -          2.4.5-9um and later (path /tools/mconsole), and is also in the
> -          distribution RPM package in 2.4.6 and later.
> -
> -          It is safe to say 'Y' here.
> +	  The user mode linux management console is a low-level interface to
> +	  the kernel, somewhat like the i386 SysRq interface.  Since there is
> +	  a full-blown operating system running under every user mode linux
> +	  instance, there is much greater flexibility possible than with the
> +	  SysRq mechanism.
> +
> +	  If you answer 'Y' to this option, to use this feature, you need the
> +	  mconsole client (called uml_mconsole) which is present in CVS in
> +	  2.4.5-9um and later (path /tools/mconsole), and is also in the
> +	  distribution RPM package in 2.4.6 and later.
> +
> +	  It is safe to say 'Y' here.
>  
>  config MAGIC_SYSRQ
>  	bool "Magic SysRq key"
> 




