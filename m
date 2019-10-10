Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD405C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 11:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE03E206A1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 11:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732993AbfJJLux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 07:50:53 -0400
Received: from mail.thorsis.com ([92.198.35.195]:35543 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727653AbfJJLux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 07:50:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id 3E825468F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 13:51:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mail.thorsis.com
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9G9L2AIR2rR5 for <linux-kernel@vger.kernel.org>;
        Thu, 10 Oct 2019 13:51:22 +0200 (CEST)
Received: by mail.thorsis.com (Postfix, from userid 109)
        id CD25F4789; Thu, 10 Oct 2019 13:51:19 +0200 (CEST)
From:   Alexander Dahl <ada@thorsis.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: configs: at91: unselect PIT
Date:   Thu, 10 Oct 2019 13:50:43 +0200
Message-ID: <1920271.Hgx7Y6QaZs@ada>
In-Reply-To: <20191009194814.15034-1-alexandre.belloni@bootlin.com>
References: <20191009194814.15034-1-alexandre.belloni@bootlin.com>
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 9. Oktober 2019, 21:48:14 CEST schrieb Alexandre Belloni:
> The PIT is not required anymore to successfully boot and may actually harm
> in case preempt-rt is used because the PIT interrupt is shared.
> Disable it so the TCB clocksource is used.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Alexander Dahl <ada@thorsis.com>

> ---
>  arch/arm/configs/at91_dt_defconfig | 1 +
>  arch/arm/configs/sama5_defconfig   | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/at91_dt_defconfig
> b/arch/arm/configs/at91_dt_defconfig index 63d09e61b6dc..7e5ffdab47da
> 100644
> --- a/arch/arm/configs/at91_dt_defconfig
> +++ b/arch/arm/configs/at91_dt_defconfig
> @@ -18,6 +18,7 @@ CONFIG_ARCH_MULTI_V5=y
>  CONFIG_ARCH_AT91=y
>  CONFIG_SOC_AT91RM9200=y
>  CONFIG_SOC_AT91SAM9=y
> +# CONFIG_ATMEL_CLOCKSOURCE_PIT is not set
>  CONFIG_AEABI=y
>  CONFIG_UACCESS_WITH_MEMCPY=y
>  CONFIG_ZBOOT_ROM_TEXT=0x0
> diff --git a/arch/arm/configs/sama5_defconfig
> b/arch/arm/configs/sama5_defconfig index 7255709d46ea..ee7db6cedaa6 100644
> --- a/arch/arm/configs/sama5_defconfig
> +++ b/arch/arm/configs/sama5_defconfig
> @@ -20,6 +20,7 @@ CONFIG_ARCH_AT91=y
>  CONFIG_SOC_SAMA5D2=y
>  CONFIG_SOC_SAMA5D3=y
>  CONFIG_SOC_SAMA5D4=y
> +# CONFIG_ATMEL_CLOCKSOURCE_PIT is not set
>  CONFIG_AEABI=y
>  CONFIG_UACCESS_WITH_MEMCPY=y
>  CONFIG_ZBOOT_ROM_TEXT=0x0


