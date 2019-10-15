Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0735C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9551320872
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571166302;
	bh=ZIaAvZnbtHuEZ4yVB6QTkkDmhzPaea3XJQXci8c1v1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uyPEldRmTRFINApXpP0x21DU0TA4pj8M04mr0/O+ucK/zAy/KNRKVP2a9I346f/yW
	 3kemgZakHdr7x7Av8JvRB6HuDSpI/ti78q1Z3EukWK2tKaCBS85vU7E6N0Xv2yVnhJ
	 OG+iJNwHvtFWwAEyJLJn0SKv++7Z1uB5/HsxUU20=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389262AbfJOTFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 15:05:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729457AbfJOTFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:05:01 -0400
Received: from localhost (unknown [38.98.37.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81CDC20663;
        Tue, 15 Oct 2019 19:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571166298;
        bh=ZIaAvZnbtHuEZ4yVB6QTkkDmhzPaea3XJQXci8c1v1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ysEUE+w2/SUgcm+INApP0pKGfkn+eJIxJi0wsXYoMDuLs+6Ztvx6GN0NKN8SFGtqf
         4b8liCT/Ywy9rBuFRUtBwHV8L4DFP1e6xlDxdltbzrGGrg5vlR9JPadIZVZgiyzjLr
         q4S3RCcNutRbS11kdKfgZo/W1BHLrQXFP92HiGIU=
Date:   Tue, 15 Oct 2019 21:01:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Cc:     corbet@lwn.net, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        leoyang.li@nxp.com, jslaby@suse.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 3/5] serial: fsl_linflexuart: Be consistent with the
 name
Message-ID: <20191015190155.GA1140159@kroah.com>
References: <1570726348-6420-1-git-send-email-stefan-gabriel.mirea@nxp.com>
 <1570726348-6420-4-git-send-email-stefan-gabriel.mirea@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570726348-6420-4-git-send-email-stefan-gabriel.mirea@nxp.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 07:52:26PM +0300, Stefan-Gabriel Mirea wrote:
> For consistency reasons, spell the controller name as "LINFlexD" in
> comments and documentation.
> 
> Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 2 +-
>  drivers/tty/serial/Kconfig                      | 8 ++++----
>  drivers/tty/serial/fsl_linflexuart.c            | 4 ++--
>  include/uapi/linux/serial_core.h                | 2 +-
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index c7ac2f3ac99f..666326d74415 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1101,7 +1101,7 @@
>  			mapped with the correct attributes.
>  
>  		linflex,<addr>
> -			Use early console provided by Freescale LinFlex UART
> +			Use early console provided by Freescale LINFlexD UART
>  			serial driver for NXP S32V234 SoCs. A valid base
>  			address must be provided, and the serial port must
>  			already be setup and configured.
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 4789b5d62f63..c8e11f62ea19 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1391,19 +1391,19 @@ config SERIAL_FSL_LPUART_CONSOLE
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
> index 68d74f2b5106..2d39e13176e1 100644
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
> @@ -933,5 +933,5 @@ static void __exit linflex_serial_exit(void)
>  module_init(linflex_serial_init);
>  module_exit(linflex_serial_exit);
>  
> -MODULE_DESCRIPTION("Freescale linflex serial port driver");
> +MODULE_DESCRIPTION("Freescale LINFlexD serial port driver");
>  MODULE_LICENSE("GPL v2");
> diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
> index 0f4f87a6fd54..49e61963e754 100644
> --- a/include/uapi/linux/serial_core.h
> +++ b/include/uapi/linux/serial_core.h
> @@ -290,7 +290,7 @@
>  /* Sunix UART */
>  #define PORT_SUNIX	121
>  
> -/* Freescale Linflex UART */
> +/* Freescale LINFlexD UART */
>  #define PORT_LINFLEXUART	121
>  
>  #endif /* _UAPILINUX_SERIAL_CORE_H */
> -- 
> 2.22.0
> 

This patch does not apply to my tree :(

