Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85579C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582F62087F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbfG3NBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 09:01:02 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34355 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbfG3NBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 09:01:01 -0400
Received: by mail-qk1-f194.google.com with SMTP id t8so46498054qkt.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 06:01:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FvIiTYmAfg/DHTIwmGRII9mYuGnoOkroa8gAl2zUp2E=;
        b=fYnype6ggfP7EGCADQSd8RGjlVeZ13PEdwph6mNbCkLrbWuHoxJYt9hT0uymyxlXQx
         1ZQYzjPGxdx9r0q7VhzL/E2U5eR5schErqmiEA/lZGlfEIaPJ3+PeN6Wjq6bTMlqGvAb
         y9ihepbR3aOGN4cA1bHekc0iStL10U9XRc+4jpHGvyLxyjBIhorjtJzd1giXO3wTtQxn
         xMolAvZoQ+VImWbDOA8NYEEw6zY8clJeo5uqGT/uDcfLxYkEx0pCw233lwd1e2LhNvEf
         gb/0AtYExCW9whvSmnY4svVIaZMheSqiTTdL29gknAYdi9DyQqWsGup6SboD5KjlShQP
         vwzA==
X-Gm-Message-State: APjAAAV+UrllIrWOdS2FiO4W6poBmKVSRHzAIzxmek44aEUOnXvxgT2l
        FJnJkoUyb0MgIHqLdqc77BzDR8F9I+yvfe0m5j0=
X-Google-Smtp-Source: APXvYqzrlT3Ug5ATEIZ68uAupnmIb49p1sP9YCyeGn/RRLxjG48Th8Y3rQU5jW+lPwRc7Hi0ix6N35cN5y5YCSO5WL8=
X-Received: by 2002:a37:5f45:: with SMTP id t66mr77440187qkb.286.1564491660273;
 Tue, 30 Jul 2019 06:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a3jjDh6aEVf0bBFYc=8GtB38kL6sWVZGJiUe427A7m2ng@mail.gmail.com>
 <CAK8P3a1ss9-G_mr48-UMOenrA0XDGWUFik4TC=m0WFfimoFdnQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1ss9-G_mr48-UMOenrA0XDGWUFik4TC=m0WFfimoFdnQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 30 Jul 2019 15:00:43 +0200
Message-ID: <CAK8P3a3VsArSUgMwoPVxm8JcTPAQDoztg22MGqX4Vj5cjtADZg@mail.gmail.com>
Subject: Re: RFC: remove Nuvoton w90x900/nuc900 platform?
To:     "Wanzongshun (Vincent)" <wanzongshun@huawei.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That wasn't it either, sorry for spamming the rest. I found one more
address for Zongshun at Huawei.

On Tue, Jul 30, 2019 at 2:34 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Trying Wan Zongshun <Vincent.Wan@amd.com> instead of
> the bouncing Wan ZongShun <mcuos.com@gmail.com>.
> (I assume you are the same person, sorry if not).
>
> On Tue, Jul 30, 2019 at 2:09 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > As the mach-netx and mach-8695 platforms are being removed now,
> > I wonder whether we should do the same with w90x00: Here is what
> > I found after looking at the git history and external material for it.
> >
> >     - The supported chips (nuc910/950/960) are no longer marketed
> >       by the manufacturer
> >
> >     - Newer chips from the same family (nuc97x, nuc980, n329x)
> >       that are still marketed have Linux BSPs but those were never
> >       submitted for upstream inclusion.
> >
> >     - Wan ZongShun is listed as maintainer, but the last patch he wrote
> >       was in 2011.
> >
> >     - All patches to w90x900 platform specific files afterwards
> >       are cleanups that were apparently done without access to
> >       test hardware.
> >
> >     - The http://www.mcuos.com/ website listed in the MAINTAINERS
> >        file is no longer reachable.
> >
> > We do support the newer NPCM platform from Nuvoton. I don't think
> > there are any shared drivers between the two, but I've added its
> > maintainers to Cc anyway, in case they still (plan to) use one of
> > those drivers.
> >
> > If we decide that it's time to let go, I'll would the patches below.
> >
> >       watchdog: remove w90x900 driver
> >       spi: remove w90x900 driver
> >       ASoC: remove w90x900/nuc900 platform drivers
> >       fbdev: remove w90x900/nuc900 platform drivers
> >       Input: remove w90x900 keyboard driver
> >       Input: remove w90x900 touchscreen driver
> >       mtd: rawnand: remove w90x900 driver
> >       net: remove w90p910-ether driver
> >       rtc: remove w90x900/nuc900 driver
> >       usb: remove ehci-w90x900 driver
> >       ARM: remove w90x900 platform
> >
> >  Documentation/watchdog/watchdog-parameters.rst   |   10 -
> >  MAINTAINERS                                      |   16 -
> >  arch/arm/Kconfig                                 |   21 +-
> >  arch/arm/Makefile                                |    1 -
> >  arch/arm/configs/nuc910_defconfig                |   51 -
> >  arch/arm/configs/nuc950_defconfig                |   67 --
> >  arch/arm/configs/nuc960_defconfig                |   57 --
> >  arch/arm/mach-w90x900/Kconfig                    |   54 --
> >  arch/arm/mach-w90x900/Makefile                   |   20 -
> >  arch/arm/mach-w90x900/Makefile.boot              |    4 -
> >  arch/arm/mach-w90x900/clksel.c                   |   88 --
> >  arch/arm/mach-w90x900/clock.c                    |  121 ---
> >  arch/arm/mach-w90x900/clock.h                    |   40 -
> >  arch/arm/mach-w90x900/cpu.c                      |  238 -----
> >  arch/arm/mach-w90x900/cpu.h                      |   56 --
> >  arch/arm/mach-w90x900/dev.c                      |  537 -----------
> >  arch/arm/mach-w90x900/gpio.c                     |  150 ---
> >  arch/arm/mach-w90x900/include/mach/entry-macro.S |   26 -
> >  arch/arm/mach-w90x900/include/mach/hardware.h    |   19 -
> >  arch/arm/mach-w90x900/include/mach/irqs.h        |   82 --
> >  arch/arm/mach-w90x900/include/mach/map.h         |  153 ---
> >  arch/arm/mach-w90x900/include/mach/mfp.h         |   21 -
> >  arch/arm/mach-w90x900/include/mach/regs-clock.h  |   49 -
> >  arch/arm/mach-w90x900/include/mach/regs-irq.h    |   46 -
> >  arch/arm/mach-w90x900/include/mach/regs-ldm.h    |  248 -----
> >  arch/arm/mach-w90x900/include/mach/regs-serial.h |   54 --
> >  arch/arm/mach-w90x900/include/mach/uncompress.h  |   43 -
> >  arch/arm/mach-w90x900/irq.c                      |  212 -----
> >  arch/arm/mach-w90x900/mach-nuc910evb.c           |   38 -
> >  arch/arm/mach-w90x900/mach-nuc950evb.c           |   42 -
> >  arch/arm/mach-w90x900/mach-nuc960evb.c           |   38 -
> >  arch/arm/mach-w90x900/mfp.c                      |  197 ----
> >  arch/arm/mach-w90x900/nuc910.c                   |   58 --
> >  arch/arm/mach-w90x900/nuc910.h                   |   17 -
> >  arch/arm/mach-w90x900/nuc950.c                   |   52 --
> >  arch/arm/mach-w90x900/nuc950.h                   |   17 -
> >  arch/arm/mach-w90x900/nuc960.c                   |   50 -
> >  arch/arm/mach-w90x900/nuc960.h                   |   17 -
> >  arch/arm/mach-w90x900/nuc9xx.h                   |   22 -
> >  arch/arm/mach-w90x900/regs-ebi.h                 |   29 -
> >  arch/arm/mach-w90x900/regs-gcr.h                 |   34 -
> >  arch/arm/mach-w90x900/regs-timer.h               |   37 -
> >  arch/arm/mach-w90x900/regs-usb.h                 |   31 -
> >  arch/arm/mach-w90x900/time.c                     |  168 ----
> >  drivers/input/keyboard/Kconfig                   |   11 -
> >  drivers/input/keyboard/Makefile                  |    1 -
> >  drivers/input/keyboard/w90p910_keypad.c          |  264 ------
> >  drivers/input/touchscreen/Kconfig                |    9 -
> >  drivers/input/touchscreen/Makefile               |    1 -
> >  drivers/input/touchscreen/w90p910_ts.c           |  331 -------
> >  drivers/mtd/nand/raw/Kconfig                     |    8 -
> >  drivers/mtd/nand/raw/Makefile                    |    1 -
> >  drivers/mtd/nand/raw/nuc900_nand.c               |  304 ------
> >  drivers/net/ethernet/Kconfig                     |    1 -
> >  drivers/net/ethernet/Makefile                    |    1 -
> >  drivers/net/ethernet/nuvoton/Kconfig             |   29 -
> >  drivers/net/ethernet/nuvoton/Makefile            |    6 -
> >  drivers/net/ethernet/nuvoton/w90p910_ether.c     | 1082 ----------------------
> >  drivers/rtc/Kconfig                              |    7 -
> >  drivers/rtc/Makefile                             |    1 -
> >  drivers/rtc/rtc-nuc900.c                         |  271 ------
> >  drivers/spi/Kconfig                              |    7 -
> >  drivers/spi/Makefile                             |    1 -
> >  drivers/spi/spi-nuc900.c                         |  429 ---------
> >  drivers/usb/host/Kconfig                         |    6 -
> >  drivers/usb/host/Makefile                        |    1 -
> >  drivers/usb/host/ehci-w90x900.c                  |  130 ---
> >  drivers/video/fbdev/Kconfig                      |   14 -
> >  drivers/video/fbdev/Makefile                     |    1 -
> >  drivers/video/fbdev/nuc900fb.c                   |  760 ---------------
> >  drivers/video/fbdev/nuc900fb.h                   |   51 -
> >  drivers/watchdog/Kconfig                         |    9 -
> >  drivers/watchdog/Makefile                        |    1 -
> >  drivers/watchdog/nuc900_wdt.c                    |  303 ------
> >  include/Kbuild                                   |    2 -
> >  include/linux/platform_data/keypad-w90p910.h     |   16 -
> >  include/linux/platform_data/spi-nuc900.h         |   29 -
> >  include/linux/platform_data/video-nuc900fb.h     |   79 --
> >  sound/soc/Kconfig                                |    1 -
> >  sound/soc/Makefile                               |    1 -
> >  sound/soc/nuc900/Kconfig                         |   29 -
> >  sound/soc/nuc900/Makefile                        |   12 -
> >  sound/soc/nuc900/nuc900-ac97.c                   |  391 --------
> >  sound/soc/nuc900/nuc900-audio.c                  |   73 --
> >  sound/soc/nuc900/nuc900-audio.h                  |  108 ---
> >  sound/soc/nuc900/nuc900-pcm.c                    |  321 -------
> >  86 files changed, 1 insertion(+), 8433 deletions(-)
> >
> >           Arnd
