Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD35AC606CA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4AD217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 19:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404001AbfGHTjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 15:39:47 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:52319 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391713AbfGHTjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 15:39:46 -0400
Received: from [192.168.1.110] ([95.117.164.184]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MjPYI-1iCVN83R5W-00kvrx; Mon, 08 Jul 2019 21:39:40 +0200
Subject: Re: [PATCH 0/3] Update pcengines-apuv2 platform device
To:     Florian Eckert <fe@dev.tdt.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Eckert.Florian@googlemail.com,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190704090205.19400-1-fe@dev.tdt.de>
 <CAHp75Vcocs=9AwX32ouOWFc+wAduCFv2DT_p4JYPUVV0BumjqA@mail.gmail.com>
 <e2c50449b498c796de8258fac0b0aba6@dev.tdt.de>
 <CAHp75VdHPRXgg6YsBM8uAfuM4CBs1HHn1condus6uW5BqC5COg@mail.gmail.com>
 <226c0a14b7a662be019d02eee4695d17@dev.tdt.de>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <16c856e1-4672-4503-72ee-de70d0b5455f@metux.net>
Date:   Mon, 8 Jul 2019 21:39:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <226c0a14b7a662be019d02eee4695d17@dev.tdt.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:AF+Zdd6Y8suz5ueLOhJ0yo+NtGpAtChCRWJTmDl2z0OpPOnjvFY
 Dsg7wTDwIr/vIm7u+mPCl74sYlq63mzpIOjW8ONbYbzcbGbAEeQ2cFCEViC7y2ZhCVm6rTM
 k84nK7TP9XotKIjbiIKN9BRrA+KB1bu8lRa4xMFWLAH6Nb8/+yK/qplCl/C1EeazPpqRgHR
 zM54e/4tE6cYeXnIiRC5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:azHOgCI4NjQ=:2hbvUyEaTlje8oKixOOHc3
 6NosVgHiHVz72Ie2P3CvmzRHwTfE/GfrEmWpvkjd638/nkO2m9BYIUV+vuaLJsjaarG/JB+sW
 BJbMNhkrtIz9vXWR7twb85JAtZex8YXWVyqDAyNk5iyA7Ayb+OAEIIcoZLob0v9Gte1kLgTfp
 SARzWVbSMcWOfJUVP28EQIP4iXp82dwkQMyTUhCtpfy1PUtet8z3yUAXUN/MKbXr0pIlfmjSN
 3UDW4pNjuMzz0PM8FBfV1tHL8EdLWRNbXhwh+fov4kYtBuVgTt5dTZDtgbDBPmtkP0VqXv4tM
 dNqictu+nVn9QM25//tZsMHNQkfWfPPKyk/gLiqgXlncUtyyGYBcOhZXjOQATyCRdhZJj8A5/
 nUnCe9K8SzHwtiKk9tVehFkX+LE6rcIaZeBTtFP/bPj6G2n/Tfz0pj9eVTT9bXknZfioM8fq3
 UFBo5Oiaxbm3IKN9x33MmwhfEARqZgqIKctB7wHNXKyXBOZ6tTbcR7KHPoDe6GcSbg9prARic
 BLdx2sWLDGvxcGQ5fAkOLyveY+psuwxKDnoa74oONYPXLGvQZTqW8f1JmquYPNXIb66cDJNgi
 pAjZm7/WX2Zu73OZRE9dKahWn/fDOzlVkBIJXJ7lzj2dKaWu4ZpiKPG47mmr0JSSxxwu1UGFt
 dFGcOIUWHS595iR+8UdebGfr26s5c7BhGymHmPxhiMk2Zlcpbav43hA9FZdwdV7cMXQCGffCC
 K4mDd4ON2D2IPiY7sPUT15oCOHAJ0xdvXbLU0qUOCfqzH1Z3dA1xDh6jlj0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.07.19 13:36, Florian Eckert wrote:

Hi,

> APU1 (PC-Engines) CPU "AMD G series T40E APU":> This is also an old design and is not recommend for new design>
(deprecated).> Also not many were produced and are in the field.> See
https://pcengines.ch/apu.htm
Yes, and I haven't been able to get one yet, so I dropped my original
plan of supporting this once. The gpio device is very different.

> Platform-Device (LEDs, Button):> I have no platform device description found in the linux sources.> So
the GPIO button should not work.
Talking about the old driver ? It only supports the three front LEDs
directly and conflicts w/ anything else that wants to support other
GPIOs.

> Platform-Device (LEDs, Button):
> This Platform description is only valid for APU2/APU3 and not for APU1.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/platform/x86/pcengines-apuv2.c

Correct. If we really wanna support APUv1, that most likely become a
completely separate driver, as the chipsets are very different.

> LEDs-Driver:
> We have an additional device only for LEDs this works for APU1/APU2/APU3.
> I think we should remove the APU2/APU3 LEDs from the leds-apu device as
> mentioned above.
> So this device supports only the APU1 LEDs.

ACK.

> We could extend and/or rename the pcengienes-apuv2 device to support
> also APU3 and the newest APU4.

APUv3 already is supported. APUv4 again is pretty different, and I don't
have one yet. (if anybody convices pcengines to give me some boards,
I'll add support for them :))

> The APU3 does have an additional the simswap pin.

Already planned to add it, but not yet sorted into which subsystem it
actually belongs to.

> We should change this to the following layout and add the legacy GPIO
> numbering.

First we'll have to sort out where the new pins actually belong into.
(maybe power management / regulators for the reset pins ?)

> ALIX (PC-Engines) CPU "AMD Geode LX":
> This is an old design we have already in use and is not recommend for
> new design (deprecated)
> https://pcengines.ch/alix.htm

And it's an entirely different chipset, not related at all to apu.

> I think we should leave the driver as it is because this is a different
> design and has nothing to do with the PUs.

Yes.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
