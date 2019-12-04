Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D38C2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF2120803
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 13:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kalray.eu header.i=@kalray.eu header.b="GcPvVXHC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbfLDNal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 08:30:41 -0500
Received: from zimbra2.kalray.eu ([92.103.151.219]:36786 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbfLDNal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 08:30:41 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id ACF7527E06C1;
        Wed,  4 Dec 2019 14:30:39 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0qikLOkuYp-c; Wed,  4 Dec 2019 14:30:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 3FD8E27E0E3A;
        Wed,  4 Dec 2019 14:30:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 3FD8E27E0E3A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1575466239;
        bh=tSLqHvB0qnrd8OVcbvn2X2AXUID5Nh56glFAyn927+E=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=GcPvVXHC/K11EuTi9ADAQobQECkkmIurKOFQUFP0uk32OyKxS6tQ5Paeu4J/tJDGG
         tB6mVKJP6+MbFDrNeaa1DJ3gDNQneBsuX7sIWidbsDNBOxZCScwaKefoApSqzPhZJg
         7jdjIOFb+ls+vxHuQLgs5rGWSnQmZJstp+M2YAjc=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ohZvBbAWfMrt; Wed,  4 Dec 2019 14:30:39 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 283CE27E06C1;
        Wed,  4 Dec 2019 14:30:39 +0100 (CET)
Date:   Wed, 4 Dec 2019 14:30:38 +0100 (CET)
From:   =?utf-8?Q?Cl=C3=A9ment?= Leger <cleger@kalray.eu>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <2116673293.95313020.1575466238935.JavaMail.zimbra@kalray.eu>
In-Reply-To: <CAHp75VcMm3PPAgfFPLzVwg_RN7_vQfRmufvWiPOkYaErdGiNsw@mail.gmail.com>
References: <20191204101042.4275-1-cleger@kalray.eu> <CAHp75VcMm3PPAgfFPLzVwg_RN7_vQfRmufvWiPOkYaErdGiNsw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Add pinctrl support for dwapb gpio driver
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.40.202]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - GC75 (Linux)/8.8.12_GA_3794)
Thread-Topic: Add pinctrl support for dwapb gpio driver
Thread-Index: r1p3somX97dhEg8W1GZwXsd76Eey8Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- On 4 Dec, 2019, at 13:24, Andy Shevchenko andy.shevchenko@gmail.com wrote:

> On Wed, Dec 4, 2019 at 12:13 PM Clement Leger <cleger@kalray.eu> wrote:
>>
>> Synopsys DWAPB IP includes support for pin control. This control is basic
>> and allows to switch between a hardware and a software function.
>> Software function is when driving GPIOs from IP and hardware is controlled
>> by external signals.
>> This serie export necessary interface to be able to move the driver to
>> pinctrl folder and then implement the pinctrl support which is based on the
>> digicolor driver. The idea is to avoid hardcoding pins in driver since
>> this IP is a generic one available on multiple SoC.
>>
> 
> This series misses at least GPIO ACPI maintainers to be Cc'ed to for
> the certain changes.
> Moreover, I would like to see entire series in the future in my mailbox.

Sorry, I messed up with get_maintainer.pl while sending the serie.
I can resend it properly if needed.

> 
> I will look at v1 closer anyway.
> 
>> Clement Leger (5):
>>   gpio: export acpi_gpiochip_request_interrupts in gpio/driver.h
>>   pinctrl: dw: move gpio-dwapb.c to pinctrl folder
>>   pinctrl: dw: use devm_gpiochip_add_data
>>   pinctrl: dw: add pinctrl support for dwapb gpio driver
>>   dt-bindings: pinctrl: dw: move sps,dwapb-gpio.txt to pinctrl
>>
>>  .../bindings/{gpio => pinctrl}/snps-dwapb-gpio.txt |  21 +-
>>  MAINTAINERS                                        |   6 +-
>>  drivers/gpio/Kconfig                               |   8 -
>>  drivers/gpio/Makefile                              |   1 -
>>  drivers/gpio/gpiolib-acpi.h                        |   4 -
>>  drivers/pinctrl/Kconfig                            |   1 +
>>  drivers/pinctrl/Makefile                           |   1 +
>>  drivers/pinctrl/dw/Kconfig                         |  11 +
>>  drivers/pinctrl/dw/Makefile                        |   4 +
>>  .../gpio-dwapb.c => pinctrl/dw/pinctrl-dwapb.c}    | 277 +++++++++++++++++++--
>>  include/linux/gpio/driver.h                        |  12 +
>>  include/linux/platform_data/gpio-dwapb.h           |   1 +
>>  12 files changed, 310 insertions(+), 37 deletions(-)
>>  rename Documentation/devicetree/bindings/{gpio => pinctrl}/snps-dwapb-gpio.txt
>>  (76%)
>>  create mode 100644 drivers/pinctrl/dw/Kconfig
>>  create mode 100644 drivers/pinctrl/dw/Makefile
>>  rename drivers/{gpio/gpio-dwapb.c => pinctrl/dw/pinctrl-dwapb.c} (77%)
>>
>> --
>> 2.15.0.276.g89ea799
>>
> 
> 
> --
> With Best Regards,
> Andy Shevchenko
