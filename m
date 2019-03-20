Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BBEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29BED2077B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfCTQFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:05:01 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:58479 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfCTQFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:05:00 -0400
Received: from [192.168.1.110] ([95.115.36.242]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N2E5Q-1h0d9R1qsI-013i9b; Wed, 20 Mar 2019 17:04:43 +0100
Subject: Re: [PATCH] gpio: amd-fch: Fix bogus SPDX identifier
To:     Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-gpio@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>
References: <alpine.DEB.2.21.1903191513170.2537@nanos.tec.linutronix.de>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <4dcdcd9c-e599-5b8a-b628-4b02b7a092a1@metux.net>
Date:   Wed, 20 Mar 2019 17:04:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1903191513170.2537@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:pNDxqNxY4MYTRj22m6ZnA0Wy2dH6VXGqvDeF15P+Wpeb/RPogfg
 i8z9Hnl/R8tZpjD3QQuH1mBN/7qNi+d6KXoZFi2q98B/bMGWpdh3TUXd617+65YR2uiBIDL
 ROGOIhndOZ4o/NbH71g7bTw1sp1GmIw9bmoyL7IqaGQ0io4TNTx352HlzQ3BMdprKxzzRxI
 Fv99e/uINXQBKCY7R8FyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WQqBjdcYMMA=:Mci81vkBMA0ZWGnL3o4+Ls
 9hdDdUubDeWxK5YWhjvlqWPiX1ns1C9hjbuqWQTrI3UE4GJkEC9IIRYiaNBDti3SFyjGgzMmL
 dHj9fOs6M6Fvck5LBG8TtTlKqmwTsLVRBVnHEE7V0uqH9JKtkP1/MWF7Vbp6vaFPA6paBQshC
 +A/rZKAkHItIhfuOhTpXuDe/7uVR9RyMjeOYyzQgFdonfDP/nQwlBXlDqPkyNp7Wx2LOMZLzW
 iv9jnZ8TDIDoUPkwAEBLbk3Hmzu2BKS3zcBuAC1ssoWpWlAK4VTfFiVg91yB9Jo41eKkJ/lXY
 6HpwFn2Z4sys7DpRkskkmTNoAncFoQEVyU15owNejI9tUaXOvyXmbm0aYjklFoA+UFt4x7VFh
 bis9oCA7VuEHzLx1WImV08dxTcbRoxr5o34QTv4IdA+zj3MRGQv86Rm2Dk0YGYSnvCFZ47q0X
 ykp1UftZUNa9NOgvol6WzxCk6C9SSsdt6jA5at5JOqZxLztCBZ1j1H9xAz6+AGsXdXComvUZh
 VH1X50OpzJPmOdbvY9V6aVEGiV495V4uXjUFtttcsMcQiflp6fLCoB41k5opEbrjME1K0ytJ/
 CRVjekcK/veGnfiK1syxDyP2K+GwZ6pjqdzwbLFpcExeAw4jzWapP6SqyoxMeZlPmDeRYzheE
 4mRVjCBKPyJhHzjwSrGXXe1lne0cZAgeQ/mJWSLNtaux82BYQ/1ufIXZGSs7uJAlRGzA8aWGG
 c9LtomrrFWQhUoLT54VZRQBh5OhngB+9cQ3n5p8UHikNhQRh17mSjrV3Prc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.03.19 15:28, Thomas Gleixner wrote:
> spdxcheck.py complains:
> 
>  include/linux/platform_data/gpio/gpio-amd-fch.h: 1:28 Invalid License ID: GPL+
> 
> which is correct because GPL+ is not a valid identifier. Of course this
> could have been caught by checkpatch.pl _before_ submitting or merging the
> patch.
> 
>  WARNING: 'SPDX-License-Identifier: GPL+ */' is not supported in LICENSES/...
>  #271: FILE: include/linux/platform_data/gpio/gpio-amd-fch.h:1:
>  +/* SPDX-License-Identifier: GPL+ */
> 
> Fix it under the assumption that the author meant GPL-2.0+, which makes
> sense as the corresponding C file is using that identifier.

Your assumption is correct.

Acked-By: Enrico Weigelt <info@metux.net>

I just wonder, why checkpatch.pl didn't bleat me.

Thanks for the fix.


--mtx


-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
