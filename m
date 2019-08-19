Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE728C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3E02086C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfHSL1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 07:27:55 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44088 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfHSL1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:27:54 -0400
Received: by mail-ot1-f65.google.com with SMTP id w4so1300397ote.11;
        Mon, 19 Aug 2019 04:27:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uMUy9HNheFvwhhF3MADVvVYEpMXC6JEt3gWUCnpdKDA=;
        b=td3uxq5d/qQFX4wmwAuChzuPe5T+4vwhxsqnOuidZND1TDYxy0FGovx1DAihx8vN7f
         RXZ6cOSF0r/gCVeVl+bjUGOn4yK0TQywNSBrFSft3EHfNfbPhLOS+QCy5eIM5Wq92wnb
         W/QuVJlk4g+hedhIyLXktGA71OWaR/8w4aOpHbgmuEo7R7Y+ez9sxmdmTRC2jJ5oPG1q
         IPNn95dl1uHWM5i2hdu/KnZMKDCSZCCNPgiOQwU5Nqd6fn4EE9LOD+UGm3s6D7ZiWaH8
         xKq8ID2Zzgmn1yrxQllkaR6B0a67PZjaMb2oOpc7WwtjjFnUjdooX5+t+LbX4wAJ93wZ
         Abtg==
X-Gm-Message-State: APjAAAUN0nJtMP1GQkCUaGq5Xw8uxCsphZPEhj+NPd/e3kSSr6c/TG+q
        NoQ4aL/lWXU3O9XefRMBxlcf1Wzc6pQ21tFg38k=
X-Google-Smtp-Source: APXvYqxrOczXTrII7JUM0WsLXJcGzNChGOnjbL1P4OV4KmdM204hxVGZqXFBc07ZeeAjByx07XUyWRQtuVerMvQqAI4=
X-Received: by 2002:a9d:7a90:: with SMTP id l16mr18460120otn.297.1566214073839;
 Mon, 19 Aug 2019 04:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190812073020.19109-1-geert@linux-m68k.org> <CACRpkdZAA8N6igrNaXcT5m62Fz2irRL-tyRZnjWgsxfacB2aow@mail.gmail.com>
In-Reply-To: <CACRpkdZAA8N6igrNaXcT5m62Fz2irRL-tyRZnjWgsxfacB2aow@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 19 Aug 2019 13:27:41 +0200
Message-ID: <CAMuHMdVv=i5nffbN2vZjvHfeV_w74PvZD7ZLuf623H9pnyK14A@mail.gmail.com>
Subject: Re: [PATCH] m68k: atari: Rename shifter to shifter_st to avoid conflict
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        kbuild test robot <lkp@intel.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 10:28 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Aug 12, 2019 at 9:30 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > When test-compiling the BCM2835 pin control driver on m68k:
> >
> >     In file included from arch/m68k/include/asm/io_mm.h:32:0,
> >                      from arch/m68k/include/asm/io.h:8,
> >                      from include/linux/io.h:13,
> >                      from include/linux/irq.h:20,
> >                      from include/linux/gpio/driver.h:7,
> >                      from drivers/pinctrl/bcm/pinctrl-bcm2835.c:17:
> >     drivers/pinctrl/bcm/pinctrl-bcm2835.c: In function 'bcm2711_pull_config_set':
> >     arch/m68k/include/asm/atarihw.h:190:22: error: expected identifier or '(' before 'volatile'
> >      # define shifter ((*(volatile struct SHIFTER *)SHF_BAS))
> >
> > "shifter" is a too generic name for a global definition.
> >
> > As the corresponding definition for Atari TT is already called
> > "shifter_tt", fix this by renaming the definition for Atari ST to
> > "shifter_st".
> >
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Suggested-by: Michael Schmitz <schmitzmic@gmail.com>
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Finally we can use the sh pfc pin controller on our m68k Atari.
>
> Now if I can only resolder the capacitors on my Atari TT ST
> before the board self-destructs I will one day test this.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks, applied and queued for v5.4.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
