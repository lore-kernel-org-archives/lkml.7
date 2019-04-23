Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C045C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C5A20652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfDWHmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:42:00 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:45401 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbfDWHl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 03:41:57 -0400
Received: from [192.168.1.115] ([95.114.123.200]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MHmuE-1h43090xkc-00Ew9u; Tue, 23 Apr 2019 09:41:39 +0200
Subject: Re: [RESEND PATCH 0/7] Introduce bus domains controller framework
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        s.hauer@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>,
        Loic PALLARDY <loic.pallardy@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-imx@nxp.com, kernel@pengutronix.de,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20190318100605.29120-1-benjamin.gaignard@st.com>
 <20190318104343.GA15574@e107155-lin>
 <CA+M3ks6bsiGXCKEQmaFmzBRhWPVhV5wBjVhgyfCa-25DohnsOg@mail.gmail.com>
 <CA+M3ks6g474AAVoVAvno6sJ7b7Hw4f1+bqod74dtrR9fULqsYw@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <beb32eab-3c63-f792-5421-1bcf65adc558@metux.net>
Date:   Tue, 23 Apr 2019 09:41:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CA+M3ks6g474AAVoVAvno6sJ7b7Hw4f1+bqod74dtrR9fULqsYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:YJJ1+/ynbg0NWOQtIlsOLoEkur676RF/vHwq0gjzZIakwASUbDb
 1N+c5X4l9XplqTD3lnRaho1CwiGl7Sxkp67q8roNPzKpn4PrmMMsd1E949+lg89DDFiG3RN
 6AHDi/tCF19QW7CboLxG0LTqjACRveEqFQWxxrfk/XGHHrCdx4P1qRS5HCb1lnmGaG1rcYW
 BVr6YIMNHYRQLv4jo7+Aw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sB7iajcgXuE=:38WkWOzJYTXCc7IGlWEYit
 cfdJoQvl7OJB6tQNjylux+AjfBZ2MtYnMjxxstVwpeKrWAtc4Uc7TEZDw9fCvIvEy5/SIJIU4
 TpRRNehrC33KGmpa8ryUlDf8HNY7PjSK9DLyWYm3EShHi2aQ51FrG0JO5EsnIdTdV+z0ztnZ2
 p6FXgYXrVs8hLyeu1Tqu2KwfTIKiYIxFZBcButaGbbg+v5nbC5VLolOGVEMaj86mZ/hCaIPE1
 0PHyscblaeWGzGMXyqCVAkhkZS9jgbuJSRWwY52Os3rMc+0wLkLlviQylQjOYaQ/Q/FMjbDUi
 w0yDxKBkm2myAQF6ds9aJjXqXwi1w2qfTo5iNQ4bE8MMHs/lo/LmCkXtn0G5sl52DLfANwNcv
 q8OP7w/bVf5zh3utAEdRZL4FIGSDXNJNVPgqbUmMU4BZjFfw7XXFgpP0mu8uegmG4ZQGrV/bF
 25AoJ7/3Ixm0l77rs8N87XNhc04bAi/e5sDwjdMx3r2Rxw8wi4EbA1c9J7PWu9HbWD5H8ugOH
 OInOuZz6AJCWCVO/za7EAQYshzkZ+cN6VQF91dAfaHWf1oejqGMcih4dhMcyCsAVhvvubTT8H
 7TxUZMlx8fSHDOEnU4YAL9wuIxF8VEerCToTuwfAT+Dm32qu1kBO3+pJ7TmnQt4KETBz1KyNw
 38ARe7V7epCa5xksQNR6DeBMtlNYb7ncrjkqBjGSGRcYPt1xZmKPXMm7XbWrJburQ63txKBRu
 zihECgFc0AWa29RQqu1I4U9HkZT83l6f7cZ+8jtc2/8O3fhTb1MXZosokh0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.04.19 14:36, Benjamin Gaignard wrote:

Hi folks,

I've missed most of the thread, but just some comments:

>>> On Mon, Mar 18, 2019 at 11:05:58AM +0100, Benjamin Gaignard wrote:
>>>> Bus domains controllers allow to divided system on chip into multiple domains
>>>> that can be used to select by who hardware blocks could be accessed.
>>>> A domain could be a cluster of CPUs (or coprocessors), a range of addresses or
>>>> a group of hardware blocks.
>>>>
>>>> Framework architecture is inspirated by pinctrl framework:
>>>> - a default configuration could be applied before bind the driver
>>>> - configurations could be apllied dynamically by drivers
>>>> - device node provides the bus domains configurations
>>>>
>>>> An example of bus domains controller is STM32 ETZPC hardware block
>>>> which got 3 domains:
>>>> - secure: hardware blocks are only accessible by software running on trust
>>>>   zone.
>>>> - non-secure: hardware blocks are accessible by non-secure software (i.e.
>>>>   linux kernel).
>>>> - coprocessor: hardware blocks are only accessible by the corpocessor.
>>>> Up to 94 hardware blocks of the soc could be managed by ETZPC and
>>>> assigned to one of the three domains.

Haven't had a look at the code (missed that part), but think the general
idea is a good thing. In some way this seems kinda semantic superset of
pinctrl ;-) We have similar cases w/ things like audio routing in
complex codex. Maybe we could find some common ground on these specific
areas that could be generalized.

>>> You fail to explain why do we need this in non-secure Linux ?
>>> You need to have solid reasons as why this can't be done in secure
>>> firmware. And yes I mean even on arm32. On platforms with such hardware
>>> capabilities you will need some secure firmware to be running and these
>>> things can be done there. I don't want this enabled for ARM64 at all,
>>> firmware *has to deal* with this.

Actually, I'm I read words like "secure firmware", I think of crap code
from chip/board/bios vendors (which is anything but secure and even
likely to have backdoors - if these aren't already on-chip, eg. ME)
Something I really do *NOT* wanna have on my machines - and if I can't
get the board/soc w/o it, I wanna kick that firmware out of the way,
as much as I can.

Therefore, he *does* have *good* reasons.

This whole idea of "secure firmware" is bogus anyways. I'd appreciate
MMU improvements for things like better/stricter isolation (to defeat
side channel attacks), really fast switches to kernel space, at least
for interrupts (eg. reserve cache banks for kernel, so we don't need
to flush here), hw support for nested VMs and hw assisted int->vm
routing, etc, etc. ... there's a lot that could be done here.

But: introducing something daemonish that sits in the background,
can do whatever it likes, controlling OS and HW, w/o the user/device
owner knowing, is completely inacceptable for me. It's really bad that
this x86 crap concepts are pushed over to arm world.

>> We use ETZPC to define if hardware blocks can be used by Cortex A7 or Cortex M4
>> (both non-secure) on STM32MP1 SoC, this new framework allow to change hardware
>> block split at runtime. This could be done even on non-secure world
>> because their is nothing critical to change hardware blocks users.

Sounds like a good usecase. For now, we have to do application specific
hacks for that - a generic solution for configuring that (eg. via dt)
is highly appreciated.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
