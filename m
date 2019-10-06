Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F30CC4740A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 01:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3743E222CA
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 01:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570327035;
	bh=wN7wNz4gA27GLibRdH8VOT/fbLaH+ygQiJp4aTxdamU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gQecc/9W1Sl3/HJAAqydCUqg1fQVdWcivssvnaZk1UBn/mCJovkaJzBZGyYSBo4BZ
	 QNWp71n+mc6Jq+XMhJ/oqUsb65fXKKDBempxnYUBIpbm5KPo0bu3/i0zPn1fN7MgKy
	 uYjH6hpE8J7w4JuZV81VOmmeAUd1DFgDdMfZaX6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfJFB5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 21:57:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfJFB5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 21:57:14 -0400
Received: from dragon (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D8E4218AC;
        Sun,  6 Oct 2019 01:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570327032;
        bh=wN7wNz4gA27GLibRdH8VOT/fbLaH+ygQiJp4aTxdamU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wFWayoCjgHN6i8EgC/gYVeYlgKPkP1MhCpEm3OLiZw2soOKUC8FfevBa1BWzqkOu6
         6Dcvjd526nAbZalpOmJYMkdaUtTo5+SGyIdQSvsCzIh23zUVm7m0TKyt6xtotsnKLO
         n8SkuHU8ZovZUJQOA/uQ4++5YNJUTAaQaQlrR8Sc=
Date:   Sun, 6 Oct 2019 09:56:50 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stefan-gabriel Mirea <stefan-gabriel.mirea@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 3/6] serial: fsl_linflexuart: Be consistent with the
 name
Message-ID: <20191006015647.GJ7150@dragon>
References: <20190905115803.19565-1-stefan-gabriel.mirea@nxp.com>
 <20190905115803.19565-4-stefan-gabriel.mirea@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905115803.19565-4-stefan-gabriel.mirea@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 11:58:36AM +0000, Stefan-gabriel Mirea wrote:
> For consistency reasons, spell the controller name as "LINFlexD" in
> comments and documentation.
> 
> Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>

Hi Greg,

The series looks good to me.  I assume that you will take this patch
and #5.

Shawn

> ---
>  Documentation/admin-guide/kernel-parameters.txt | 2 +-
>  drivers/tty/serial/Kconfig                      | 8 ++++----
>  drivers/tty/serial/fsl_linflexuart.c            | 4 ++--
>  include/uapi/linux/serial_core.h                | 4 ++--
>  4 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 614012a61754..23162492ea2f 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1091,7 +1091,7 @@
>  			mapped with the correct attributes.
>  
>  		linflex,<addr>
> -			Use early console provided by Freescale LinFlex UART
> +			Use early console provided by Freescale LINFlexD UART
>  			serial driver for NXP S32V234 SoCs. A valid base
>  			address must be provided, and the serial port must
>  			already be setup and configured.
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index b658589208bf..2d5115375345 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1434,19 +1434,19 @@ config SERIAL_FSL_LPUART_CONSOLE
>  	  you can make it the console by answering Y to this option.
>  
>  config SERIAL_FSL_LINFLEXUART
> -	tristate "Freescale linflexuart serial port support"
> +	tristate "Freescale LINFlexD UART serial port support"
>  	depends on PRINTK
>  	select SERIAL_CORE
>  	help
> -	  Support for the on-chip linflexuart on some Freescale SOCs.
> +	  Support for the on-chip LINFlexD UART on some Freescale SOCs.
>  
>  config SERIAL_FSL_LINFLEXUART_CONSOLE
> -	bool "Console on Freescale linflexuart serial port"
> +	bool "Console on Freescale LINFlexD UART serial port"
>  	depends on SERIAL_FSL_LINFLEXUART=y
>  	select SERIAL_CORE_CONSOLE
>  	select SERIAL_EARLYCON
>  	help
> -	  If you have enabled the linflexuart serial port on the Freescale
> +	  If you have enabled the LINFlexD UART serial port on the Freescale
>  	  SoCs, you can make it the console by answering Y to this option.
>  
>  config SERIAL_CONEXANT_DIGICOLOR
> diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_linflexuart.c
> index 26b9601a0952..ca90551384ca 100644
> --- a/drivers/tty/serial/fsl_linflexuart.c
> +++ b/drivers/tty/serial/fsl_linflexuart.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * Freescale linflexuart serial port driver
> + * Freescale LINFlexD UART serial port driver
>   *
>   * Copyright 2012-2016 Freescale Semiconductor, Inc.
>   * Copyright 2017-2018 NXP
> @@ -938,5 +938,5 @@ static void __exit linflex_serial_exit(void)
>  module_init(linflex_serial_init);
>  module_exit(linflex_serial_exit);
>  
> -MODULE_DESCRIPTION("Freescale linflex serial port driver");
> +MODULE_DESCRIPTION("Freescale LINFlexD serial port driver");
>  MODULE_LICENSE("GPL v2");
> diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
> index 63fa56b899e8..26967c2f4a4f 100644
> --- a/include/uapi/linux/serial_core.h
> +++ b/include/uapi/linux/serial_core.h
> @@ -293,7 +293,7 @@
>  /* Sunix UART */
>  #define PORT_SUNIX	121
>  
> -/* Freescale Linflex UART */
> -#define PORT_LINFLEXUART	121
> +/* Freescale LINFlexD UART */
> +#define PORT_LINFLEXUART	122
>  
>  #endif /* _UAPILINUX_SERIAL_CORE_H */
> -- 
> 2.22.0
> 
