Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E13C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 18:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F482077B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 18:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556389221;
	bh=jYDbFg9v6v3NqBHdqxKLcwv1RTVrTwrhdU8zyz0K1DQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=y9/guZygu5C9LWPCXi4sZhhBN3VRtQlCIouRQHxVnjWZTiBO1osPg6O8pPbUb2YTh
	 dnopJydq6omwk5neVmlSzGCEeXSImvw2J2BKtvrzVGFgZi/K0b/KxNpRrNhm5GZCpQ
	 /cZ1mYGwgD4xMzo6d0l5yu6lzOq07PM29TQY3Wi0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfD0SUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 14:20:20 -0400
Received: from casper.infradead.org ([85.118.1.10]:51696 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfD0SUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 14:20:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3Xo/wFURptg1/R9xaYCaS8cab1bjkCZmJ2WZkkYZ+Bs=; b=DBDh541QaJybGNYWuPD8RD79kt
        657wADthuUIUBdW3GUGQBxaRGDJ4uOWTYhYC+Xr84sEwojdntJ2tFYiUOciW43epffquQIgVCLPmm
        0SFKVnk4n1yI4SNDHcq5sed+SoPGBJiYKSIoWJ5og1OyUins055SBeikjtn5fxvjgoF7dA45urK8K
        qQ4LTld4Rw8ST5T9Tck4GxUzRb4FD+8N43lmKIggm3zlaie4+R9NJZf5nCbVSfV0YW7BypOyJLWrq
        1ARqLA5YB/LTfsc+bE+w3fvIXctAGqG+JQt7DY8ewNAwdyqi+I7bDBxujgCRA0fJ0l7BQKbP1eadw
        YbIKTDHQ==;
Received: from 177.17.250.151.dynamic.adsl.gvt.net.br ([177.17.250.151] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hKRvp-0004PK-Lx; Sat, 27 Apr 2019 18:20:14 +0000
Date:   Sat, 27 Apr 2019 15:20:08 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/27] Documentation: x86: convert
 usb-legacy-support.txt to reST
Message-ID: <20190427152008.7fb85b81@coco.lan>
In-Reply-To: <20190426153150.21228-20-changbin.du@gmail.com>
References: <20190426153150.21228-1-changbin.du@gmail.com>
        <20190426153150.21228-20-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 26 Apr 2019 23:31:42 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  Documentation/x86/index.rst                               | 1 +
>  .../{usb-legacy-support.txt => usb-legacy-support.rst}    | 8 ++++++--
>  2 files changed, 7 insertions(+), 2 deletions(-)
>  rename Documentation/x86/{usb-legacy-support.txt => usb-legacy-support.rst} (92%)
> 
> diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> index c41c17906b6d..526f7a008b8e 100644
> --- a/Documentation/x86/index.rst
> +++ b/Documentation/x86/index.rst
> @@ -25,3 +25,4 @@ Linux x86 Support
>     pti
>     microcode
>     resctrl_ui
> +   usb-legacy-support
> diff --git a/Documentation/x86/usb-legacy-support.txt b/Documentation/x86/usb-legacy-support.rst
> similarity index 92%
> rename from Documentation/x86/usb-legacy-support.txt
> rename to Documentation/x86/usb-legacy-support.rst
> index 1894cdfc69d9..19abead7f1a8 100644
> --- a/Documentation/x86/usb-legacy-support.txt
> +++ b/Documentation/x86/usb-legacy-support.rst
> @@ -1,7 +1,11 @@
> +
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==================
>  USB Legacy support
> -~~~~~~~~~~~~~~~~~~
> +==================
>  
> -Vojtech Pavlik <vojtech@suse.cz>, January 2004
> +:Author: Vojtech Pavlik <vojtech@suse.cz>, January 2004
>  
>  
>  Also known as "USB Keyboard" or "USB Mouse support" in the BIOS Setup is a

While your conversion is fine, I would do this change:

-Problem 1) can be solved by loading the USB drivers prior to loading the
-PS/2 mouse driver. Since the PS/2 mouse driver is in 2.6 compiled into
-the kernel unconditionally, this means the USB drivers need to be
-compiled-in, too.
-
-Problem 2) can currently only be solved by either disabling HIGHMEM64G
-in the kernel config or USB Legacy support in the BIOS. A BIOS update
-could help, but so far no such update exists.
-
-Problem 3) is usually fixed by a BIOS update. Check the board
-manufacturers web site. If an update is not available, disable USB
-Legacy support in the BIOS. If this alone doesn't help, try also adding
-idle=poll on the kernel command line. The BIOS may be entering the SMM
-on the HLT instruction as well.
+Problem 1)
+  Can be solved by loading the USB drivers prior to loading the
+  PS/2 mouse driver. Since the PS/2 mouse driver is in 2.6 compiled into
+  the kernel unconditionally, this means the USB drivers need to be
+  compiled-in, too.
+
+Problem 2)
+  Can currently only be solved by either disabling HIGHMEM64G
+  in the kernel config or USB Legacy support in the BIOS. A BIOS update
+  could help, but so far no such update exists.
+
+Problem 3)
+  Is usually fixed by a BIOS update. Check the board
+  manufacturers web site. If an update is not available, disable USB
+  Legacy support in the BIOS. If this alone doesn't help, try also adding
+  idle=poll on the kernel command line. The BIOS may be entering the SMM
+  on the HLT instruction as well.

As it would make easier for those reading this document in html.

In either case:

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Thanks,
Mauro
