Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E130FCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8C020B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732661AbfJVQKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 12:10:20 -0400
Received: from muru.com ([72.249.23.125]:39000 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727152AbfJVQKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:10:20 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9C3C580FA;
        Tue, 22 Oct 2019 16:10:54 +0000 (UTC)
Date:   Tue, 22 Oct 2019 09:10:16 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: OMAP1: ams-delta FIQ: Fix a typo ("Initiaize")
Message-ID: <20191022161016.GS5610@atomide.com>
References: <20191002145301.11332-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191002145301.11332-1-j.neuschaefer@gmx.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jonathan Neuschäfer <j.neuschaefer@gmx.net> [191002 07:54]:
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  arch/arm/mach-omap1/ams-delta-fiq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap1/ams-delta-fiq.c b/arch/arm/mach-omap1/ams-delta-fiq.c
> index 0254eb9cf8c6..4eea3e39e633 100644
> --- a/arch/arm/mach-omap1/ams-delta-fiq.c
> +++ b/arch/arm/mach-omap1/ams-delta-fiq.c
> @@ -110,7 +110,7 @@ void __init ams_delta_init_fiq(struct gpio_chip *chip,
> 
>  		/*
>  		 * FIQ handler takes full control over serio data and clk GPIO
> -		 * pins.  Initiaize them and keep requested so nobody can
> +		 * pins.  Initialize them and keep requested so nobody can
>  		 * interfere.  Fail if any of those two couldn't be requested.
>  		 */
>  		switch (i) {
> --

Thanks applying into omap-for-v5.5/omap1.

Regards,

Tony
