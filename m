Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A22AC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 11:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5AFA2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 11:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfK2LYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 06:24:06 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:41303 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfK2LYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 06:24:04 -0500
Received: from 79.184.255.242.ipv4.supernova.orange.pl (79.184.255.242) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 69300783449412aa; Fri, 29 Nov 2019 12:24:02 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH] acpi: Fix Kconfig indentation
Date:   Fri, 29 Nov 2019 12:24:02 +0100
Message-ID: <2871482.TlNyQbTRmB@kreacher>
In-Reply-To: <20191120134310.16355-1-krzk@kernel.org>
References: <20191120134310.16355-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, November 20, 2019 2:43:10 PM CET Krzysztof Kozlowski wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/acpi/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 4fb97511a16f..002838d23b86 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -104,9 +104,9 @@ config ACPI_PROCFS_POWER
>  	depends on X86 && PROC_FS
>  	help
>  	  For backwards compatibility, this option allows
> -          deprecated power /proc/acpi/ directories to exist, even when
> -          they have been replaced by functions in /sys.
> -          The deprecated directories (and their replacements) include:
> +	  deprecated power /proc/acpi/ directories to exist, even when
> +	  they have been replaced by functions in /sys.
> +	  The deprecated directories (and their replacements) include:
>  	  /proc/acpi/battery/* (/sys/class/power_supply/*) and
>  	  /proc/acpi/ac_adapter/* (sys/class/power_supply/*).
>  	  This option has no effect on /proc/acpi/ directories
> @@ -448,7 +448,7 @@ config ACPI_CUSTOM_METHOD
>  config ACPI_BGRT
>  	bool "Boottime Graphics Resource Table support"
>  	depends on EFI && (X86 || ARM64)
> -        help
> +	help
>  	  This driver adds support for exposing the ACPI Boottime Graphics
>  	  Resource Table, which allows the operating system to obtain
>  	  data from the firmware boot splash. It will appear under
> 

Applying as 5.5 material with a slightly modified subject, thanks!



