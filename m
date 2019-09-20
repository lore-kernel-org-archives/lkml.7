Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE66C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 07:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B6B207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 07:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404807AbfITHnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 03:43:10 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35351 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403879AbfITHnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 03:43:09 -0400
Received: by mail-qk1-f194.google.com with SMTP id w2so6396440qkf.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 00:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3lKk+zwO3ztRJxmFWZdj4M4We36PKrcFNdQxMw/wFCw=;
        b=dL5pk6fk9pnGohgEAkcCZB9PH3ybx6ltgPxZt1xQ2P+2DlmiHSD5QjYWLuSLbBpx0r
         SoQ0CeOm3juEX7rI93R3GFVVdTfDuOFAoyNdM6c69IY8f5//i1cGMEE3buKr2f/pVwS+
         VjC6I0UHJwAK2bvPs+ndB5kskLIriIxLvAHSSG4nouTR9uS+GovhkI6N3clRtYAsUX2M
         vLm6EWGEAYsp31dU9FFHwPrWzhVZnHOKBDki54i9LE1d7oL/wZVhiuYBQpYVlaU+TaDL
         n1Kzs01cX7HamrERt+tC2tuzmTmu9/ByQooPNSVUPKGmlCB5UeuzKSAun7fAYAQoaW3/
         Qurg==
X-Gm-Message-State: APjAAAWEPnp7nSS/sweKjbimYoGrA7vpOiFgZ9s9dd0Uir1+BN409znz
        Bl7Pt6Hxu72r9yBo4XThXsdl6ChorfA9BPUgpHLQjysMAs8=
X-Google-Smtp-Source: APXvYqzBHupHID5t8krankJiBM+2cD1x69FWvFH32XCalJNyUJQ3f3NQ0ko9RSVCp48Pj9I3P/V020rv8gspzcooDJE=
X-Received: by 2002:a37:a858:: with SMTP id r85mr2318323qke.394.1568965387375;
 Fri, 20 Sep 2019 00:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190919142654.1578823-1-arnd@arndb.de> <CACPK8XcsegR5R0nkiZ-UEMgCqNMggCXjAr2N-6J1S6mEhGLrBQ@mail.gmail.com>
In-Reply-To: <CACPK8XcsegR5R0nkiZ-UEMgCqNMggCXjAr2N-6J1S6mEhGLrBQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 20 Sep 2019 09:42:51 +0200
Message-ID: <CAK8P3a17ReGKk70YoS72OvV=9KfDJBwDQkFDKx_1imdEbTboZQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: aspeed: ast2500 is ARMv6K
To:     Joel Stanley <joel@jms.id.au>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 7:51 AM Joel Stanley <joel@jms.id.au> wrote:
> On Thu, 19 Sep 2019 at 14:27, Arnd Bergmann <arnd@arndb.de> wrote:

> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/arm/mach-aspeed/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/arm/mach-aspeed/Kconfig b/arch/arm/mach-aspeed/Kconfig
> > index a293137f5814..163931a03136 100644
> > --- a/arch/arm/mach-aspeed/Kconfig
> > +++ b/arch/arm/mach-aspeed/Kconfig
> > @@ -26,7 +26,6 @@ config MACH_ASPEED_G4
> >  config MACH_ASPEED_G5
> >         bool "Aspeed SoC 5th Generation"
> >         depends on ARCH_MULTI_V6
> > -       select CPU_V6
> >         select PINCTRL_ASPEED_G5 if !CC_IS_CLANG
>
> I can't find any trees with !CC_IS_CLANG here. Is there a problem
> building our pinmux driver with Clang?

This was an unrelated change from my local randconfig tree.

Your driver uncovered a bug in clang that is now fixed, the driver
itself is fine, see https://bugs.llvm.org/show_bug.cgi?id=43243

> I tested with this patch:
> --- a/arch/arm/mach-aspeed/Kconfig
> +++ b/arch/arm/mach-aspeed/Kconfig
> @@ -25,8 +25,8 @@ config MACH_ASPEED_G4
>
>  config MACH_ASPEED_G5
>         bool "Aspeed SoC 5th Generation"
> +       # This implies ARMv6K which covers the ARM1176
>         depends on ARCH_MULTI_V6
> -       select CPU_V6
>         select PINCTRL_ASPEED_G5
>         select FTTMR010_TIMER
>         help
>
> If you want to apply that as a fix for 5.4 I would be happy with that.
>
> Fixes: 8c2ed9bcfbeb ("arm: Add Aspeed machine")
> Reviewed-by: Joel Stanley <joel@jms.id.au>

Applied to arm/fixes now.

      Arnd
