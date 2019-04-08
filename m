Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C422C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BA82087F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 11:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfDHLsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 07:48:38 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:9016 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfDHLsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 07:48:38 -0400
X-IronPort-AV: E=Sophos;i="5.60,325,1549954800"; 
   d="scan'208";a="26949445"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 08 Apr 2019 04:48:37 -0700
Received: from localhost (10.10.76.4) by CHN-SV-EXCH01.mchp-main.com
 (10.10.76.37) with Microsoft SMTP Server id 14.3.352.0; Mon, 8 Apr 2019
 04:48:36 -0700
Date:   Mon, 8 Apr 2019 13:48:15 +0200
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
CC:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: at91: remove HAVE_FB_ATMEL for sama5 SoC as they
 use DRM
Message-ID: <20190408114815.du4yurugclssjzre@M43218.corp.atmel.com>
Mail-Followup-To: Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190328153307.24689-1-nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190328153307.24689-1-nicolas.ferre@microchip.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 04:33:07PM +0100, Nicolas Ferre wrote:
> SAMA5 devices use the newer DRM driver for LCD. They don't need
> the older FB driver: remove the Kconfig option for them.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Applied to at91-defconfig.

Thanks.

> ---
>  arch/arm/mach-at91/Kconfig | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index 903f23c309df..01b1bdb4fb6e 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -21,7 +21,6 @@ config SOC_SAMA5D2
>  	depends on ARCH_MULTI_V7
>  	select SOC_SAMA5
>  	select CACHE_L2X0
> -	select HAVE_FB_ATMEL
>  	select HAVE_AT91_UTMI
>  	select HAVE_AT91_USB_CLK
>  	select HAVE_AT91_H32MX
> @@ -36,7 +35,6 @@ config SOC_SAMA5D3
>  	bool "SAMA5D3 family"
>  	depends on ARCH_MULTI_V7
>  	select SOC_SAMA5
> -	select HAVE_FB_ATMEL
>  	select HAVE_AT91_UTMI
>  	select HAVE_AT91_SMD
>  	select HAVE_AT91_USB_CLK
> @@ -50,7 +48,6 @@ config SOC_SAMA5D4
>  	depends on ARCH_MULTI_V7
>  	select SOC_SAMA5
>  	select CACHE_L2X0
> -	select HAVE_FB_ATMEL
>  	select HAVE_AT91_UTMI
>  	select HAVE_AT91_SMD
>  	select HAVE_AT91_USB_CLK
> -- 
> 2.17.1
> 
