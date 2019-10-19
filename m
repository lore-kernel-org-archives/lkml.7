Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D58CA9EAB
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 20:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F4F21925
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 20:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfJSUI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 16:08:59 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:60727 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfJSUI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 16:08:59 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MI59b-1iHm2Q3BH5-00F9X2 for <linux-kernel@vger.kernel.org>; Sat, 19 Oct
 2019 22:08:57 +0200
Received: by mail-qt1-f170.google.com with SMTP id n7so14388286qtb.6
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2019 13:08:57 -0700 (PDT)
X-Gm-Message-State: APjAAAVOABfGDnbdHMyp8gcogyVlYu8czxNhQ34UBeIHyswhYb61ZCRZ
        iy6pZQ2e5ZkOuqFVtHQge0wBJiRFc5q9WYHgc9w=
X-Google-Smtp-Source: APXvYqweKdxjH3580CJWEb/rgw/f/C+LWxOFtdDRFBMALRPPhfdYI119qJ6bZXMKGuz5toZAsMGVIOKx15wuv5eebv0=
X-Received: by 2002:a0c:c70a:: with SMTP id w10mr16645869qvi.222.1571515736628;
 Sat, 19 Oct 2019 13:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <20191018163047.1284736-1-arnd@arndb.de> <20191018163047.1284736-2-arnd@arndb.de>
 <20191019184234.4cdb37a735fe632528880d76@gmail.com>
In-Reply-To: <20191019184234.4cdb37a735fe632528880d76@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 19 Oct 2019 22:08:40 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0LWeGJshr=AdeE3QXHYe2jVmc90K_2prc=4=ZFk0hr=g@mail.gmail.com>
Message-ID: <CAK8P3a0LWeGJshr=AdeE3QXHYe2jVmc90K_2prc=4=ZFk0hr=g@mail.gmail.com>
Subject: Re: [PATCH 2/6] ARM: ep93xx: enable SPARSE_IRQ
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     Hubert Feurstein <hubert.feurstein@contec.at>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Lukasz Majewski <lukma@denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ozB6Ncw7kH0ON3q7hFu7i3qAcGTDD9KA6TIUX9336Vwni9OOdmi
 gZh+9GP+rTn4PxXCniJa7gu/VSBJN7NLHppEIM5CQP0SZrr/AdpRYWEb/7mTQdlNeBhE26D
 QWtR74iHI0pjiQS7DTvCTmmTzewcY640UP4Wc9xftzuVqrzHk0I7o9umiUtN3xdu1UHaRwl
 vaGRNGkmwmhRRg5ql2g9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XBIujc50bc8=:UemfaWDnPlMxCAj7Qs+I36
 MKGZoerE27DYU9rSkON1wOgtUPum1aZcB8ge9obevWIwy5StqCO3UTRiwAIQBGrHOcqOokmFO
 nS4QURq+CMGUBRBGOwFDvy1gAGereheVEgqm4P9fUuNmQDr9JNk6uy5pDDlhXwprdg+OZ2FzM
 NGOj0scMlAXym+0uSgbRfRzVrRHENCrIvyUl0/qkkNJI+v+b6Si1hQPYodV6xzBaGTpcAUWHh
 mCocEgMKgYZlAi3r3yB14kT0hBKPFOL+vkc5jZDThMlYZwRKw/K/jGisdQLp31312QkVhucCN
 3AfZGZ+H7HmnPkUfK6RFMlO6DQjyWVMWuPZIOzjiY5P6AQALHOUjfFOdOpv8YwhTcXmkcYCPh
 Uj/rZYtCheJS6qBQWbwxsKpVbu5TwquKVs1euclunJ8nohpS4asJZx7XQ3TeS1vijGLoenYhG
 W8d98S/YaOKVCtoquBnspt//EH7wcUaaRKNtCcj/u5NLpXV7v9cnG7qwvAhpS1Jv++ek24A5R
 3oOOAqzGxNYhaQuqFMNJydfTyQ/59PZEGf2DqbQJP1kWppqt85kSDQOZ3BaA0A9cpY9a8lbk5
 N7lXLa7qD/+SDMpsBM6P/8AFoQf0rFnzog+F96OjKrTVe9nkCa+aEbk9wrX7bPMuD71l7ve64
 4Rnv8R+j3BeQA/GNKbOJqpWZfE7tXcWV55+3V5/qbl2InSL+86VBb3oaMx9K50nzkzGktywSy
 QXrAOXx4iKiltUXJW206TJmPHs5Tey9DmhUhjVOPkwCJdgcAVy2rRcgH7nBn45AAuTKxTHMes
 5j5+qbSgXq5Dc5t1c06Aa1I9Y+eocnUOl2KVQEo/KPYwjbW4yiVaKR+HwFsFZe4W5F/AVNWpw
 oNDXVz7mis9qD4K+cgZQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2019 at 6:43 PM Alexander Sverdlin
<alexander.sverdlin@gmail.com> wrote:
> On Fri, 18 Oct 2019 18:29:15 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
>
> > Without CONFIG_SPARSE_IRQ, we rely on mach/irqs.h to define NR_IRQS
> > globally. Do the minimal conversion by setting .nr_irqs in each
> > machine descriptor.
> >
> > Only the vision_ep9307 machine has extra IRQs for GPIOs, so make
> > .nr_irqs the original value there, while using the plain NR_EP93XX_IRQS
> > everywhere else.
>
> This patch causes multiple problems on EDB9302:
>
> 1. WARNINGs during gpiochip registration, for instance:
>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at kernel/irq/chip.c:1013 __irq_do_set_handler+0x94/0x188
> CPU: 0 PID: 1 Comm: swapper Tainted: G        W         5.4.0-rc3 #1
> Hardware name: Cirrus Logic EDB9302 Evaluation Board
> [<c000e878>] (unwind_backtrace) from [<c000d574>] (show_stack+0x10/0x18)
> [<c000d574>] (show_stack) from [<c0335e28>] (dump_stack+0x18/0x24)
> [<c0335e28>] (dump_stack) from [<c001cf1c>] (__warn+0xa4/0xc8)
> [<c001cf1c>] (__warn) from [<c001cfe8>] (warn_slowpath_fmt+0xa8/0xb8)
> [<c001cfe8>] (warn_slowpath_fmt) from [<c0055668>] (__irq_do_set_handler+0x94/0x188)
> [<c0055668>] (__irq_do_set_handler) from [<c005647c>] (irq_set_chained_handler_and_data+0x48/0x7c)
> [<c005647c>] (irq_set_chained_handler_and_data) from [<c01ab440>] (gpiochip_add_data_with_key+0x6d4/0xabc)
> [<c01ab440>] (gpiochip_add_data_with_key) from [<c01ab868>] (devm_gpiochip_add_data+0x40/0x88)
> [<c01ab868>] (devm_gpiochip_add_data) from [<c01ae554>] (ep93xx_gpio_probe+0x1ac/0x280)
> [<c01ae554>] (ep93xx_gpio_probe) from [<c01e0f34>] (platform_drv_probe+0x28/0x6c)
> [<c01e0f34>] (platform_drv_probe) from [<c01df588>] (really_probe+0x1c8/0x340)
> [<c01df588>] (really_probe) from [<c01ddfe4>] (bus_for_each_drv+0x58/0xc0)
> [<c01ddfe4>] (bus_for_each_drv) from [<c01df904>] (__device_attach+0xb4/0x104)
> [<c01df904>] (__device_attach) from [<c01de1d4>] (bus_probe_device+0x8c/0x94)
> [<c01de1d4>] (bus_probe_device) from [<c01db5e4>] (device_add+0x3d0/0x59c)
> [<c01db5e4>] (device_add) from [<c01e16d8>] (platform_device_add+0x100/0x20c)
> [<c01e16d8>] (platform_device_add) from [<c03f50b0>] (ep93xx_init_devices+0x16c/0x20c)
> [<c03f50b0>] (ep93xx_init_devices) from [<c03f53a0>] (edb93xx_init_machine+0xc/0x84)
> [<c03f53a0>] (edb93xx_init_machine) from [<c03f1984>] (customize_machine+0x20/0x38)
> [<c03f1984>] (customize_machine) from [<c03f0e54>] (do_one_initcall+0x78/0x1a0)
> [<c03f0e54>] (do_one_initcall) from [<c03f1080>] (kernel_init_freeable+0x104/0x1b8)
> [<c03f1080>] (kernel_init_freeable) from [<c034c358>] (kernel_init+0x8/0xf8)
> [<c034c358>] (kernel_init) from [<c00090d0>] (ret_from_fork+0x14/0x24)
> Exception stack(0xc4433fb0 to 0xc4433ff8)
> 3fa0:                                     00000000 00000000 00000000 00000000
> 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> ---[ end trace 8f9e35e2d6224882 ]---

My first guess would be that this is just the missing irq domain code:

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 38e096e6925f..7c195af6f75d 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -205,6 +205,7 @@ config GPIO_EP93XX
        depends on ARCH_EP93XX
        select GPIO_GENERIC
        select GPIOLIB_IRQCHIP
+       select IRQ_DOMAIN_HIERARCHY

 config GPIO_EXAR
        tristate "Support for GPIO pins on XR17V352/354/358"

But most likely there are more changes required to the gpio code.

> 2. Broken sound (I2S), this looks like below in the log:
>
> ep93xx-i2s ep93xx-i2s: Missing dma channel for stream: 0
>  CS4271: ASoC: pcm constructor failed: -22
> edb93xx-audio edb93xx-audio: ASoC: can't create pcm CS4271 HiFi :-22
>
> And /proc/interrupts has two entries less. Without patch:
>
> # cat /proc/interrupts
>            CPU0
>   7:          0       VIC   7 Edge      i2s-pcm-out
>   8:          0       VIC   8 Edge      i2s-pcm-in
>  39:          2       VIC   7 Edge      eth0
>  51:       7532       VIC  19 Edge      ep93xx timer
>  52:        144       VIC  20 Edge      uart-pl010
>  53:          4       VIC  21 Edge      ep93xx-spi
>  60:          0       VIC  28 Edge      ep93xx-i2s
> Err:          0
>
> With patch:
>
> # cat /proc/interrupts
>            CPU0
>  39:        146       VIC   7 Edge      eth0
>  51:     162161       VIC  19 Edge      ep93xx timer
>  52:        139       VIC  20 Edge      uart-pl010
>  53:          4       VIC  21 Edge      ep93xx-spi
>  60:          0       VIC  28 Edge      ep93xx-i2s
> Err:          0

I guess that is partial success: some irqs do work ;-)

The two interrupts that did not get registered are for the
dmaengine driver, and that makes sense given the error
message about the DMA not working. No idea how
that would be a result of the irq changes though.

> I will try to look into I2S problem...

Thanks!

       Arnd
