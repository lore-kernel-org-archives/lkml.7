Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1282AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF97B214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 09:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfCLJa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 05:30:28 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:52621 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfCLJa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 05:30:27 -0400
Received: from [192.168.1.110] ([77.4.190.91]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N7xml-1gyR740CBP-014xUx; Tue, 12 Mar 2019 10:30:25 +0100
Subject: Re: [PATCH v2] drivers: gpio: sprd: use
 devm_platform_ioremap_resource()
To:     Baolin Wang <baolin.wang@linaro.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
References: <AMz4kuKC5haGbhyVJ4gQ6nMRzdaxJnd3SmeCSM-096p7TAp8cA@mail.gmail.com>
 <1552378134-3678-1-git-send-email-info@metux.net>
 <CAMz4kuJaFtsmk1sWw_cSc+b0tdNabt_1jZB8hjrJrOgdQkqzmA@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <6c7f2f6c-abda-e552-79e7-fa36951bb670@metux.net>
Date:   Tue, 12 Mar 2019 10:30:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAMz4kuJaFtsmk1sWw_cSc+b0tdNabt_1jZB8hjrJrOgdQkqzmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:k68bwLAdQNC/4wO4wpNSgDK07X16kPwXQ7VRHcafMAptTzS2LET
 7s+dl8I7l+45oHFsDBWuQekuU10zB1caW8t5qjNI3hkIygVHK6yQFjeca1+03VPqG+1zR+S
 fxaBu+0ns0Rh1KTNLjAkS5dbaD0hfIMsMpb9zdp7LCQf8XDoDPJNaN7BM8WvI2zhNpTlS39
 NqXDrs1r+sJq67vfNrWTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QbVBJ5y4pUc=:Pa5658YTJsKv8+9mdE08dx
 6To5SIqhR6JmUOuLj6JYTQ9mNrNtiGFnKihz6qTMzwO7bD9WmylzSqkTHzswa2nig7rEP0ggo
 N/ZMEd294ha51kVnEFTfz0F6Hrjs12kpzS0uCAG85/FjFfNiHxR6NDFPWo8ilt0EcvNCx6U6q
 pFa3VXc+2I/sKy2VeEIIRS7uLBwZoUsOcrsc5FjfRn9L7RRizyyLu1PyB/KKqCj9wC9l1XhIy
 OhoYQNN1nCyb0LRmU+5uwwpM35yECB+a9OUOUhqnbfDhtHymeFlZ1s2hJywpmq6/miZqmOonU
 eVTkOB8jgn6jCVhnFkOF4Zz3HeAOErFrZpjxyBokw6e3MLZ2t0lJpg3SS738raQib/ZTq3YYk
 zp31FTC5yzxmvDyK4scFY17gYjWnMQYy+cgX8L7goFbyahQ3MMejuiKCuf/G4t3GcwQVvcNlq
 JJqcUJnrTBsjK/nN5Ioc15YfXU/oeyQoIL2f+YNuNOIQHPYUAEQ0FaPjMq7ISPVKWB+e3AR84
 BkMbr37ijmqEbclnZ8ZvNnJj78JahIsdGMxvhtNhm8iCJzWrKZIzjymRI7Ot10z2MIYkCXVtI
 MAsr/voGt/8GgwfHdZMnKL09v3ESfRbUfMUUgnCDEo3/XKrYlce0zHqj8epveUYAK9UucDt+c
 ckC0V//4jwXWnt8cKN5uPhCepCjHx9r2Pn1u4R+zDoAamC/dPMfwIzFNyrCDdqg0IeWlWqNlV
 tucXOBvBH3NBepm8XrwYL6g6TKYgwTzusr6055F5f2ziuiJbT7dWC6m7fjY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.03.19 09:49, Baolin Wang wrote:

> I still do not think the new API is suitable for this case. Since we
> can have optional multiple IO resources, so the original code will not
> return errors if we did not get the IO resources, but we must cast
> errors if we failed to do ioremap. But you ignore the errors of
> ioremap, which is not good.

hmm, maybe we can differenciate on the error code ?

patch up devm_platform_ioremap_resource() so it returns -ENOENT if
there's no such resource defined. I suppose, ioremap() doesn't have
a valid case for -ENOENT (but haven't checked yet).


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
