Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9527C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14092189E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562176301;
	bh=EGXfb/6cHMf6wJSuJ7lGb050Mx2Aw8wb2exJGYv+98M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z3lj3MBc4TUBaQVup7Ia1IcJzH9TSmlOGuzFpWIX5nBlEXuGmuvuJTNttYwj0rRAc
	 A/laZ9bam6vf3BaAcQKCezpwxOZkafjE9lGmozBtIWPcMK0KNqf4C0FeDE61AnfTF2
	 8oKk/gH2hkTjdrUqFx6Tr3PaW58nqDeMF14i8nnU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfGCRvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 13:51:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbfGCRvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 13:51:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1117A21881;
        Wed,  3 Jul 2019 17:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562176299;
        bh=EGXfb/6cHMf6wJSuJ7lGb050Mx2Aw8wb2exJGYv+98M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ICzTfyYsPeVLnYxwAiX7U9VKMyn9Mm2GyQkMtmzA/GSDc1amQzaPj8zaSAA4OG21G
         nqXa8TLPk4SqWtaghgd6q+LdkIZH2HCcMoyjv11wWh3LFkE2wDf7iL8Bu7RXUUoFHD
         nHWnp66z4QogRE5pTZxR0229I6Eg9HLtL0BiMgvM=
Date:   Wed, 3 Jul 2019 19:51:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "sudheer.v" <open.sudheer@gmail.com>
Cc:     jslaby@suse.com, joel@jms.id.au, andrew@aj.id.au,
        benh@kernel.crashing.org, robh+dt@kernel.org, mark.rutland@arm.com,
        shivahshankar.shankarnarayanrao@aspeedtech.com,
        shivahshankar@gmail.com, sudheer.veliseti@aspeedtech.com,
        sudheer veliseti <sudheer.open@gmail.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: Re: [patch v3 4/5] defconfig and MAINTAINERS updated for AST2500 DMA
 UART driver
Message-ID: <20190703175137.GD12813@kroah.com>
References: <1561459476-14268-1-git-send-email-open.sudheer@gmail.com>
 <1561459476-14268-5-git-send-email-open.sudheer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561459476-14268-5-git-send-email-open.sudheer@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 04:14:35PM +0530, sudheer.v wrote:
> From: sudheer veliseti <sudheer.open@gmail.com>
> 
> defconfig changes to add DMA based UART in AST2500
> Maintainers File updated.
> Signed-off-by: sudheer veliseti <sudheer.open@gmail.com>

Blank line needed before signed-off-by.


> ---
> 
> Changes in v3:
> - Added changes logs 
> 
>  MAINTAINERS                          | 13 +++++++++++++
>  arch/arm/configs/aspeed_g5_defconfig |  1 +
>  2 files changed, 14 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 997e27ab492f..c9a9790b97f6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1347,6 +1347,19 @@ F:	drivers/crypto/axis
>  F:	drivers/pinctrl/pinctrl-artpec*
>  F:	Documentation/devicetree/bindings/pinctrl/axis,artpec6-pinctrl.txt
>  
> +ARM/ASPEED DMA UART DRIVER
> +M:	sudheer v <sudheer.open@gmail.com>
> +M:	ShivahShankar <shivahshankar.shankarnarayanrao@aspeedtech.com>
> +R:	Joel Stanley <joel@jms.id.au>
> +R:	Andrew Jeffery <andrew@aj.id.au>
> +R:	Vinod Koul <vkoul@kernel.org>
> +L:	dmaengine@vger.kernel.org
> +L:	openbmc@lists.ozlabs.org
> +L:	linux-aspeed@lists.ozlabs.org
> +S:	Maintained
> +F:	drivers/tty/serial/8250/8250_aspeed_uart_dma.c
> +F:	Documentation/devicetree/bindings/serial/ast-sdma-uart.txt
> +
>  ARM/ASPEED I2C DRIVER
>  M:	Brendan Higgins <brendanhiggins@google.com>
>  R:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
> diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
> index 1849cbc161b4..25bf26630939 100644
> --- a/arch/arm/configs/aspeed_g5_defconfig
> +++ b/arch/arm/configs/aspeed_g5_defconfig
> @@ -144,6 +144,7 @@ CONFIG_SERIAL_8250=y
>  CONFIG_SERIAL_8250_CONSOLE=y
>  CONFIG_SERIAL_8250_NR_UARTS=6
>  CONFIG_SERIAL_8250_RUNTIME_UARTS=6
> +CONFIG_AST_SERIAL_DMA_UART=y

This shows that the config option should be:
	CONFIG_SERIAL_AST_DMA_UART
right?

thanks,

greg k-h
