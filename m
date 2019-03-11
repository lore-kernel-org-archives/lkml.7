Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6444AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4348D206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbfCKT1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:27:55 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:50551 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfCKT1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:27:54 -0400
Received: from [192.168.1.110] ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M4ahC-1h1ltX0Bmw-001hVV; Mon, 11 Mar 2019 20:27:45 +0100
Subject: Re: [PATCH 2/4] Add SUNIX Multi-I/O card device driver
To:     Arnd Bergmann <arnd@arndb.de>, Morris Ku <saumah@gmail.com>
Cc:     gregkh <gregkh@linuxfoundation.org>, morris_ku@sunix.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190308123432.20520-1-saumah@gmail.com>
 <CAK8P3a2yKZqB1CtYSSrhHQmRDdE-GpwdHMifgPB5Ledv-UJzWw@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <28e10b9b-630f-b3bf-4119-39c43459d665@metux.net>
Date:   Mon, 11 Mar 2019 20:27:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2yKZqB1CtYSSrhHQmRDdE-GpwdHMifgPB5Ledv-UJzWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Jxso8Mmk1EWbLX+Bgmk+sx6b/JahjIrZzNa02G+7c808E1SkWkp
 ydAY2oeELMlD6rHSZN2/QeOXMXAh8yrZOjN3BVm8LOLKygEe4xKu2eKyP2dC3UAUs2NfFad
 07+c1Y4yYUFtF5/kT993oI3TLWLMeAM+XUAb4g01r6qhOHTGAQBKy567re8yZ+1D0EvxK0d
 yCRTGnNnbRJucSVoalzig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L36OGo6WqkE=:Nsnsk/8hYpN3B6Sjfwedch
 xxFRikOjhVccNYQ5lDLXBJg0czbnaFBOykCIg7UFJhaGX5+1Mj1iKwZMKLoZKPeCgqxwVM25h
 gJFA/a32tyakOIx9r6qoChPrE28SA1S2cDkwrP9wdL7ja7LZrWjj3i/jhbRFfJ/OLpcEGsCPd
 Ci7QV/jgsvsqppcQToc88N470WZKRqZ9cmipR2SgO+qeRCPIcV8GbBny0KiNOU378sWV+7/yH
 kNwfWUsG2fjV0xFRvP3z5NggWDNpBZb5KgftrfWWs9PQjuryty3U1auitKX4O0kKXScxv88j4
 iWoXDeVyeOgsrych32rgupW7HGxYyFTWd1AZoEJsRh3EAOuCOTm511bHXfZhYf4QmhQhGbTLV
 x8P0wwxFkKShyrT+IuDXtG+29JF4T0/efLfWvvgylf6lUOXu3jfDX+YhEhtR8/2UFVweHmjq1
 OeDki5gwr+TFKEuhlUUzByCb1oH98xSS+tqnrZAzTsV94hPL2u5XTRd6XOWFcc8nokD3BA8/R
 Xpyj0WqfTG20lnDdR/ikn7Kmw0brNoDbEhELC0egskZCkITgOKVwpP6fHVrdrULFv9K120LUk
 5bQyZ6b0b8ymVyRSqyXLPjKNkJgbKn296fnzuF82T7Fqy/0UNrTFSacR2AuI9EzVfiiJcBjMY
 dyG/Fp4PKzwUs3M1BIw4Uz0ttp/0C1Ta5flDAeZFvfVC0esqRNfkjJtwulpdPMOUkmGqXcc0R
 Mxaic93XXfQgYdLXPGVyk4DZYxzNoVdkLg5szC2JLz9lFf2n5+3818JBKOo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.03.19 16:05, Arnd Bergmann wrote:

Hi,

> Enrico has already replied with the most important comments. Here> are just some more high-level thoughts from me:
I'll try to make things a bit more clear to newcomers:

> * We want the functionality to be present in subsystem specific>   standalone drivers, i.e. drivers/tty/serial/, drivers/parport/,
drivers/gpio>   etc, as Enrico said
That means we'd have completely separate drivers for the uart, parport,
gpio, etc. These might share some common code (eg. some board config
data which is used by all drivers), in a separate module.

>   If this is not possible, what you may need to do here is to have a>   small driver in drivers/mfd/ that handles the PCI function and
creates>   platform_device instances that the individual drivers can
bind to.

'bind to' here means, the mfd driver will prepare the platform data
(platform specific config struct) for the actual drivers and creates
instances of them (see platform_device_register*() functions). The
kernel will then load the corresponding modules (if not compiled-in)
and calls these drivers with the platform data passed in to it's
probe() callback.

An example could be my recent gpio-amd-fch and pcengines-apuv2 drivers.
Here, the gpio-amd-fch drives the gpio's in the SoC, while the
pcengines-apuv2 driver one is just binding drivers together - the
actual config (register addressed, etc) is in the pcengines-apu2 driver:

See:
drivers/gpio/gpio-amd-fch.c
drivers/platform/x86/pcengines-apuv2.c

Maybe it would be a good start, spliiting out the gpio stuff into
it's own driver. If the gpio subdevice can't be probed individually
(eg. has it's own pci function), you could do it the way I did it
w/ gpio-amd-fch and pcengines-apuv2.

> * do not implement your own ioctl handlers. If you need a custom>   interface for something hardware specific, split that out into>   a
separate patch, so the base support can be reviewed>   independently.
You really should try to get around w/o adding any special ioctl()s
or other userland interfaces. If you *really* believe you can't do that,
please let's talk about this first. Such cases usually indicate a
missing generic functionality in one of the subsystems.

Let me stress some very important point here (which also I frequently
have to explain to my clients): in Linux, the kernel is *the*
"hardware abstraction layer". Applications can just use generic APIs
and never care about the actual underlying hardware - the kernel just
presents everything by a uniform interface. That's why drivers really
just dock into the corresponding subsystems and not introduce their
own APIs.

There're only few exceptions from that, eg. DRI subsystem, because these
devices tend to be so specific, that it just doesn't make sense to
create a uniform interface (unless we'd want to move entire gallium
into the kernel ;-)).

From what I can see in your patches, your cards provide pretty standard
uart, parport, gpio.

> * If the functions (in particular serial and parport) have a similar>   register layout to existing drivers, try to reuse the existing code>
  and extend it, rather than duplicating the implementation.
Yes, please have a closer look into the corresponding subsystems,
which generic drivers already exist, that might fit to your device.

For example, in gpio, we've got a generic driver for devices that map
all the direction flags into one, and the line statii into another
register (see bgpio_*() functions). We're yet lacking another generic
one that puts everything for one line into one register (and then has
an array of those) - that's still on my todo list.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
