Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0CEC749E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 13:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4DDE20838
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 13:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfGJNHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 09:07:22 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:41471 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfGJNHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 09:07:21 -0400
Received: from [192.168.1.110] ([95.117.121.26]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N0Ip5-1ifNjy1aHn-00xHFL; Wed, 10 Jul 2019 15:07:13 +0200
Subject: Re: [PATCH 2/3] platform/x86/pcengines-apuv2: add legacy leds gpio
 definitions
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     Eckert.Florian@googlemail.com, info@metux.net,
        dvhart@infradead.org, andy@infradead.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190704090205.19400-1-fe@dev.tdt.de>
 <20190704090205.19400-3-fe@dev.tdt.de>
 <bf9c82c3-bc6e-b701-afd4-b4e657cb09be@metux.net>
 <e4583be44ddaa1453c0caea37d73d57d@dev.tdt.de>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <b029d90c-06b6-a261-5cde-8034de052d7c@metux.net>
Date:   Wed, 10 Jul 2019 15:07:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <e4583be44ddaa1453c0caea37d73d57d@dev.tdt.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:QedsUTmfx+jQYnQQMP1Zi2x49ZHzHbFgmrQho7VsqsJIETm+NdU
 /zZSE//ROnKc8cenG5nqgJiMsb02qT8jUwGkEF6ontILnuHrXDU82aeodYoeH4Ymuu2dfDk
 xv4SglFn3Ctow1ZY4t31fOSGEumeSyr0mxpF5hvsMpkz6uvHGCQHrdgDIce1uqcNuaibPrY
 DIJJfNHwUG+zvWOJI5H8A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0Q7gNDk6p6I=:n34cJjHE6SMgU0GnzxdH8/
 3GopdLl59BRFSB8o3owh0TCTAjj8fQjBhcVrCJqGAdLEnuT0GAafqOJIbDiiOw5xy4mHG0/64
 D2bsG7P1upu3+1zwcfKzzbPBXpDUfv6Rg5FIc454deglVPqtjLpLEm9Uz2gopJx5HWkMTtQn4
 TOHggMlr02Wwn7Oe+zYTmEyKmJGI0sH/jCsZhk2zRCuqR8hzOIx6x5UwwsfI7ATgzpfCmQpTc
 MQ6j7qHGUVnVRY0Jn3Sa9Z18Qi+eEOlXEFuwk7Jh4TL8qxN4r7ApPndH2f+ZNrtMUIKbemmAQ
 QUwLT8STFScnFqgvXKIOTvY3S3LPWC9wSvmEh1Hgy2VGwYrZe3S59tbugqErO07gU5etPQCke
 JC2i0e4IV9N2PElGbqTALqkqh37tCOeWxV9z3BDO59f/5fBxwEk46L6RdL4O3w58nl7TpuLx7
 w9ITCJyral69KxhMtMhdDdBImjdv0xqr9r5T2wuZ6YdSPwwZf/VLFrtfMAiY+5C5ee9UHaw+n
 Sa+6HH2rI/Qr5iwmg2/o+AvzRUXOYwCA0j1XpwhtluQbWX0vMYZRIPR2iOJd+/lhvimL5vT2K
 yH5ZIA9lZDNZjG6TVO6ygPjChqgOi1LJ7cFMsV4UXaXplMXKz/WJZE+zOMAp0ojbuyTWoAmEK
 fWsiqhBEsLCsk4C1rlcw5T7mZkLnQExLUN6JN6ECQQ2p/xZegf5+ICW2050nLCp/Ca0L4DNfN
 CVu2s41qNrAAz5xJyDHKm7O1QUA4CAEYqCbPWpIV3N2cTyOpdw0tU3m8uA8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.07.19 14:03, Florian Eckert wrote:

> I have back ported your pcengines-apuv2 device and gpio-amd-fch GPIO
> driver to the kernel version 4.19 on OpenWrt.
> If I compile and load this without the change no LEDs are visible in
> "/sys/class/leds"!

Maybe this old kernel just ignored all entries w/o gpio ID. Note that
these IDs are deprecated for quite a while and shouldn't be used in new
code anymore.

> From my point of view the connection between the GPIO and the LEDs
> subsystem is missing.
> How should the LED subsystem know which GPIO to use?

See gpiod_lookup_table.

> If I add the change to the pcengines-apuv2 device then the LEDs will be
> visilbe under "/sys/class/leds"
> and could be used, by OpenWrt userland.
> 
> Mybe I miss something.

Your patch is only valid for your backport onto this old kernel, not for
recent mainline.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
