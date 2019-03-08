Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F7FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 10:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E3720811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 10:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfCHKmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 05:42:19 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:46343 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfCHKmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 05:42:19 -0500
Received: from [192.168.1.110] ([95.117.97.241]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M3lgJ-1h1vpv1xwJ-000q85; Fri, 08 Mar 2019 11:42:04 +0100
Subject: Re: [PATCH 1/3] x86: apuv2: remove unused variable
To:     Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86 <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190304200918.1444050-1-arnd@arndb.de>
 <CACRpkdZmNbPcSQXU6mosQJk1j9k+vQfJbs2KUZcXTUo172_cCQ@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <fbc13c2b-1c9d-54d7-e29b-c279a5a42e33@metux.net>
Date:   Fri, 8 Mar 2019 11:42:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdZmNbPcSQXU6mosQJk1j9k+vQfJbs2KUZcXTUo172_cCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:RZRqxZ2yW29XYpK8+MYGTRcduVErfj5IlZb6oR3sFxegwisGBdb
 AqhY/TBQUpMoYR0WNaGlXkVIUqREQEqRwl0TwV8J9nY0p2YiCrxSNW5J/D7khz4kF9FD0eD
 InsrQRu2MgsauqRXuSz02VajZBVCgSb8b/O2NMlwXWp6qQQQ7qX9aN1qsdjzH7f8VDXTZKk
 S3+LvptUBrT+hbAtnUocg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P5RKNXSxuMM=:bwCzz+DN9b+wfbeuNDA0C0
 ZIbcULty0FwX1S/jDDa1chutP10ckL7Mka2TK4D5dA5Rz3ZmKMUjuMQ6WJY31TSeLcUbxw/yl
 /uX9RRgDNO6wpo8FK12Q4E1YBwRrOxQ+jaJNXXsoDakea7yL/cmI/9QFc796jvv/8N2G2nrAf
 F71vtfc5U8B0G92Pw2Fh9weFolFZEXv88+z01iyziQc4OKV77mLBeyCQXXYhMHECgYjutlgDD
 6hjFz7UwBx3F0uOmU8u+ti1DLpINpuluXW51F0P3IskBiMxEeKCW1gCgASsMZQh5pKlrn5LMV
 0Q6hZagact04gYbxUoDOm7o7ExV6ih6hzwHCs1NXdPVNm4KQ5YYkGo3ZFeNvHtuIMcpyjunD1
 ZUr04TXBWYGXR/DgHmsK9GaM49TA7i8ukVkk3mQZYQS1q579gsV79IpSk46HlEsupM6e+rcp7
 CCQJZqzzv5/dFN3JZk+PUl6HtOiGLCstJ9k9ryzmpwSu+4MXGNhRXhFQw+INPWg+lJ88zAIJ5
 G+6JldOZ3eRRQekOI1l66QtuVg5OBPv8JEkoiP57WSIkvjP8Jhbl7TyJmoBqo5lNXQtBJY/mB
 tNR+GURwO2GxXC3QMnmIhpqsgmAXrEDOeI17AjM9XTwDLLv7tL3HijxZM4VMbHfaRCTtZE+c9
 vOcWPotxJRMQ95k5AD6buXYpABcG0V0brkqDizPED/GirFvsRzz2B/g1lFi6GY/twrPf/B7jC
 SruK6wSLX+Xq4IIsdi2QHi4niYSTp3UzrUQSoWNzHzuFBCJH/hCPb/bZ5Yk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.03.19 10:11, Linus Walleij wrote:

> As Torvalds did not yet pull the GPIO tree (maybe because of this
> and other bugs, who knows) I applied this to my GPIO tree for
> now.

Great. I actually like it better this way, so his pull will be clean
and consistent.

Did you also apply the kconfig fixes ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
