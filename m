Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410B0C2BD09
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 23:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18926206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 23:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfLIXpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 18:45:51 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:51121 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfLIXpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 18:45:50 -0500
X-Originating-IP: 195.39.63.77
Received: from localhost (unknown [195.39.63.77])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 67FB2E0002;
        Mon,  9 Dec 2019 23:45:48 +0000 (UTC)
Date:   Tue, 10 Dec 2019 00:45:46 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux@armlinux.org.uk, nicolas.ferre@microchip.com,
        ludovic.desroches@microchip.com, sre@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 0/9] SoC and defconfig support for SAM9X60
Message-ID: <20191209234546.GD1463890@piout.net>
References: <1575035505-6310-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575035505-6310-1-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2019 15:51:36+0200, Claudiu Beznea wrote:
> Hi,
> 
> This series enables proper support for SAM9X60 in Kconfig and
> defconfig.
> 
> Thank you,
> Claudiu Beznea
> 
> Changes in v3:
> - move patch "ARM: at91: Kconfig: add config flag for SAM9X60 SoC" before
>   the patches that uses CONFIG_SOC_SAM9X60
> - sqash defconfig patches (except the savedefconfig one)
> 
> Changes in v2:
> - cahnged cover letter title; previously it was:
>   "add defconfig support for SAM9X60"
> - have new entry in arch/arm/mach-at91/Kconfig for SOC_SAM9X60
>   independent of SOC_AT91SAM9 to be able to select only necessary
>   config flags for SAM9X60 (patches 02/17, 03/17)
> - select POWER_RESET_AT91_RESET and POWER_RESET_AT91_SAMA5D2_SHDWC
>   as for SAMA5D2 (patches 04/17, 05/17)
> - select DEBUG_AT91_RM9200_DBGU (patch 06/17)
> - shaped a bit the patches titles and commit desciptions for defconfig
>   patches (patches 09-17/17)
> 
> Claudiu Beznea (9):
>   ARM: at91: Kconfig: add sam9x60 pll config flag
>   ARM: at91: Kconfig: add config flag for SAM9X60 SoC
>   ARM: at91: pm: move SAM9X60's PM under its own SoC config flag
>   drivers: soc: atmel: move sam9x60 under its own config flag
>   power: reset: Kconfig: select POWER_RESET_AT91_RESET for sam9x60
>   drivers: soc: atmel: select POWER_RESET_AT91_SAMA5D2_SHDWC for sam9x60
>   ARM: debug-ll: select DEBUG_AT91_RM9200_DBGU for sam9x60
>   ARM: at91/defconfig: use savedefconfig
>   ARM: at91/defconfig: enable config flags for sam9x60 SoC
> 
>  arch/arm/Kconfig.debug             |  6 ++---
>  arch/arm/configs/at91_dt_defconfig | 55 ++++++++++++++++++--------------------
>  arch/arm/mach-at91/Kconfig         | 24 +++++++++++++++--
>  arch/arm/mach-at91/Makefile        |  1 +
>  arch/arm/mach-at91/at91sam9.c      | 18 -------------
>  arch/arm/mach-at91/pm.c            |  2 +-
>  arch/arm/mach-at91/sam9x60.c       | 34 +++++++++++++++++++++++
>  drivers/power/reset/Kconfig        |  4 +--
>  drivers/soc/atmel/soc.c            |  5 ++--
>  9 files changed, 92 insertions(+), 57 deletions(-)
>  create mode 100644 arch/arm/mach-at91/sam9x60.c
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
