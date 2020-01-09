Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D10C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 12:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 836E42067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 12:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbgAIM5K convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 07:57:10 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:47059 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbgAIM5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 07:57:10 -0500
Received: by mail-oi1-f196.google.com with SMTP id 13so3860014oij.13;
        Thu, 09 Jan 2020 04:57:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=39RtL8rk7bDV6g9PvKUtpmQ7zFMxOJOdNZ+12WIVKnY=;
        b=h1XxKiBStXHpHoGM1c3e1YqFMdLu9BjUv5GwYB3oDS9oMRhi+aVVgj45Q++/tkiZ7T
         LnI7UEH5iaWXxiRbodolJi0sidQguoubJREoJ9MQvjAOo7Yw4D2FZ1ql24U14iqCdNfj
         oD6wz4QxbDWR2ocKdPK7pN8VxA0EQoKP70sNEL8xDsq+1873rhhDEm66UAniY3o4YR9k
         /sELO9rmaxNJtEPY/56GxGQjX6Ia1CYNfaL+dY1Y30Z7x9Ucj4RJPRG1AQb56xSrgu/Z
         JLupZa4PvRl2xyJss9mfJoKkO+uYT4JXhmnuhAGwMy0vYIRyXZ71aN61qbiGZGCQEIfe
         oWCg==
X-Gm-Message-State: APjAAAWnLJUswRdHPgTrNHObaOAUSSmQ9tOoBuUeErBfgP+bVpjeZ8kL
        6O4mwmXEDaCWU9VCKnFnP94R4oLIV3vy54pcw8g=
X-Google-Smtp-Source: APXvYqzXIeHRSEaojF1m+3afdoHrMEVdpGnWdqm+Ic8pQMZKUJ2siNc76OEtMGXSFfhO06nJEdD1sPQJKoj5PuXTjfg=
X-Received: by 2002:a05:6808:292:: with SMTP id z18mr2863814oic.131.1578574629374;
 Thu, 09 Jan 2020 04:57:09 -0800 (PST)
MIME-Version: 1.0
References: <20200108194520.3341-1-krzk@kernel.org>
In-Reply-To: <20200108194520.3341-1-krzk@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 9 Jan 2020 13:56:58 +0100
Message-ID: <CAMuHMdULhY=_GF2MsX-h_j=eLKL+2x3=YcgmFRsAy1_LUOdZ+g@mail.gmail.com>
Subject: Re: [PATCH] sh: sh4a: Remove unused tmu3_device
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Wed, Jan 8, 2020 at 8:45 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Remove left-over from previous cleanups to silence the warning:
>
>     arch/sh/kernel/cpu/sh4a/setup-sh7786.c:243:31:
>         warning: ‘tmu3_device’ defined but not used [-Wunused-variable]
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/sh/kernel/cpu/sh4a/setup-sh7786.c | 21 ---------------------
>  1 file changed, 21 deletions(-)
>
> diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
> index 4b0db8259e3d..22d1c38f742f 100644
> --- a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
> +++ b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
> @@ -229,27 +229,6 @@ static struct platform_device tmu2_device = {
>         .num_resources  = ARRAY_SIZE(tmu2_resources),
>  };
>
> -static struct sh_timer_config tmu3_platform_data = {
> -       .channels_mask = 7,
> -};
> -
> -static struct resource tmu3_resources[] = {
> -       DEFINE_RES_MEM(0xffde0000, 0x2c),
> -       DEFINE_RES_IRQ(evt2irq(0x7c0)),
> -       DEFINE_RES_IRQ(evt2irq(0x7c0)),
> -       DEFINE_RES_IRQ(evt2irq(0x7c0)),
> -};
> -
> -static struct platform_device tmu3_device = {
> -       .name           = "sh-tmu",
> -       .id             = 3,
> -       .dev = {
> -               .platform_data  = &tmu3_platform_data,
> -       },
> -       .resource       = tmu3_resources,
> -       .num_resources  = ARRAY_SIZE(tmu3_resources),
> -};
> -
>  static const struct sh_dmae_channel dmac0_channels[] = {
>         {
>                 .offset = 0,

Looks like the previous cleanup accidentally removed one too many tmu
device pointers.  The old style used one device per timer, the new style
uses one device per 3 timers, i.e. 4 devices for 12 timers.

So the correct fix would be to re-add "&tmu3_device" to
sh7786_early_devices[].

Fixes: 1399c195ef5009bf ("sh: Switch to new style TMU device")

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
