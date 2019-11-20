Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAF9C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A15A224C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731634AbfKTOCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:02:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:57062 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727794AbfKTOCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:02:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6482BB0B6;
        Wed, 20 Nov 2019 14:02:48 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH] xen: Fix Kconfig indentation
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
References: <20191120133822.12909-1-krzk@kernel.org>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <82f7c786-c240-66bd-895a-d71cd6977807@suse.com>
Date:   Wed, 20 Nov 2019 15:02:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191120133822.12909-1-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.11.2019 14:38, Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/xen/Kconfig | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> index b71f1ad1013c..cba949c0f8b3 100644
> --- a/drivers/xen/Kconfig
> +++ b/drivers/xen/Kconfig
> @@ -110,12 +110,12 @@ config XEN_COMPAT_XENFS
>         depends on XENFS
>         default y
>         help
> -         The old xenstore userspace tools expect to find "xenbus"
> -         under /proc/xen, but "xenbus" is now found at the root of the
> -         xenfs filesystem.  Selecting this causes the kernel to create
> -         the compatibility mount point /proc/xen if it is running on
> -         a xen platform.
> -         If in doubt, say yes.
> +	 The old xenstore userspace tools expect to find "xenbus"
> +	 under /proc/xen, but "xenbus" is now found at the root of the
> +	 xenfs filesystem.  Selecting this causes the kernel to create
> +	 the compatibility mount point /proc/xen if it is running on
> +	 a xen platform.
> +	 If in doubt, say yes.

Here and ...

> @@ -123,7 +123,7 @@ config XEN_SYS_HYPERVISOR
>         select SYS_HYPERVISOR
>         default y
>         help
> -         Create entries under /sys/hypervisor describing the Xen
> +	 Create entries under /sys/hypervisor describing the Xen
>  	 hypervisor environment.  When running native or in another
>  	 virtual environment, /sys/hypervisor will still be present,
>  	 but will have no xen contents.

... here you end up with a tab and one space, whereas ...

> @@ -271,7 +271,7 @@ config XEN_ACPI_PROCESSOR
>  	depends on XEN && XEN_DOM0 && X86 && ACPI_PROCESSOR && CPU_FREQ
>  	default m
>  	help
> -          This ACPI processor uploads Power Management information to the Xen
> +	  This ACPI processor uploads Power Management information to the Xen
>  	  hypervisor.
>  
>  	  To do that the driver parses the Power Management data and uploads
> @@ -280,7 +280,7 @@ config XEN_ACPI_PROCESSOR
>  	  SMM so that other drivers (such as ACPI cpufreq scaling driver) will
>  	  not load.
>  
> -          To compile this driver as a module, choose M here: the module will be
> +	  To compile this driver as a module, choose M here: the module will be
>  	  called xen_acpi_processor  If you do not know what to choose, select
>  	  M here. If the CPUFREQ drivers are built in, select Y here.
>  
> @@ -313,8 +313,8 @@ config XEN_SYMS
>         depends on X86 && XEN_DOM0 && XENFS
>         default y if KALLSYMS
>         help
> -          Exports hypervisor symbols (along with their types and addresses) via
> -          /proc/xen/xensyms file, similar to /proc/kallsyms
> +	  Exports hypervisor symbols (along with their types and addresses) via
> +	  /proc/xen/xensyms file, similar to /proc/kallsyms

... everywhere else you have a tab and two spaces, as I would
have expected.

Furthermore in various cases you leave space indented the
directives other than "help". With a title like the one this
patch has I'd expect all indentation issues to be taken care of.

Jan
