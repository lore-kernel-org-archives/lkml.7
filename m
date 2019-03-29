Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09232C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60F32075E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 13:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbfC2NWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 09:22:05 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:14570 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729614AbfC2NWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 09:22:05 -0400
X-IronPort-AV: E=Sophos;i="5.60,284,1549954800"; 
   d="scan'208";a="29094547"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Mar 2019 06:22:04 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch07.mchp-main.com
 (10.10.76.108) with Microsoft SMTP Server id 14.3.352.0; Fri, 29 Mar 2019
 06:22:03 -0700
Date:   Fri, 29 Mar 2019 14:21:27 +0100
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: at91: remove HAVE_FB_ATMEL for sama5 SoC as they
 use DRM
Message-ID: <20190329132127.agd2iaejovu3djr2@M43218.corp.atmel.com>
Mail-Followup-To: Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20190328153307.24689-1-nicolas.ferre@microchip.com>
 <20190329130538.77iwsdzc7spgbng4@M43218.corp.atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190329130538.77iwsdzc7spgbng4@M43218.corp.atmel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 02:05:38PM +0100, Ludovic Desroches wrote:
> On Thu, Mar 28, 2019 at 04:33:07PM +0100, Nicolas Ferre wrote:
> > SAMA5 devices use the newer DRM driver for LCD. They don't need
> > the older FB driver: remove the Kconfig option for them.
> > 
> > Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com> 
> 
> CONFIG_FB_ATMEL should be removed from at91_dt_defconfig. Do you want me
> to handle it?

Sorry for the noise, I confused at91_dt_defconfig and sama5_defconfig.
So nothing to do.

Ludovic

> 
> > ---
> >  arch/arm/mach-at91/Kconfig | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> > index 903f23c309df..01b1bdb4fb6e 100644
> > --- a/arch/arm/mach-at91/Kconfig
> > +++ b/arch/arm/mach-at91/Kconfig
> > @@ -21,7 +21,6 @@ config SOC_SAMA5D2
> >  	depends on ARCH_MULTI_V7
> >  	select SOC_SAMA5
> >  	select CACHE_L2X0
> > -	select HAVE_FB_ATMEL
> >  	select HAVE_AT91_UTMI
> >  	select HAVE_AT91_USB_CLK
> >  	select HAVE_AT91_H32MX
> > @@ -36,7 +35,6 @@ config SOC_SAMA5D3
> >  	bool "SAMA5D3 family"
> >  	depends on ARCH_MULTI_V7
> >  	select SOC_SAMA5
> > -	select HAVE_FB_ATMEL
> >  	select HAVE_AT91_UTMI
> >  	select HAVE_AT91_SMD
> >  	select HAVE_AT91_USB_CLK
> > @@ -50,7 +48,6 @@ config SOC_SAMA5D4
> >  	depends on ARCH_MULTI_V7
> >  	select SOC_SAMA5
> >  	select CACHE_L2X0
> > -	select HAVE_FB_ATMEL
> >  	select HAVE_AT91_UTMI
> >  	select HAVE_AT91_SMD
> >  	select HAVE_AT91_USB_CLK
> > -- 
> > 2.17.1
> > 
