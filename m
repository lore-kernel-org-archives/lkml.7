Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9528CC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6775220882
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfEJQWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 12:22:24 -0400
Received: from ivanoab6.miniserver.com ([5.153.251.140]:52274 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfEJQWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 12:22:24 -0400
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1hP8Hs-0007I4-MT; Fri, 10 May 2019 16:22:20 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.89)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1hP8Hq-0002GX-9D; Fri, 10 May 2019 17:22:20 +0100
Subject: Re: [RESEND PATCH 4/4] um: irq: don't set the chip for all irqs
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Richard Weinberger <richard@nod.at>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        Jeff Dike <jdike@addtoit.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-um@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20190411094944.12245-1-brgl@bgdev.pl>
 <20190411094944.12245-5-brgl@bgdev.pl>
 <CAFLxGvwb8YzNiXCXru8Tw9pxH9qoc7gAO4sk0MXK1Xmp7fm-2g@mail.gmail.com>
 <0e8fbdf3-c40d-e4e8-6235-c744ec7317c3@cambridgegreys.com>
 <684874198.48863.1557299587958.JavaMail.zimbra@nod.at>
 <CAMRc=MdsA7A1DdS1ZJ8NS8xtuCjgc_7WZD1797H3oZ=2w+fOBA@mail.gmail.com>
 <CAMRc=McCxvwHgk-3wYE0e+qxJNoHK0AmpJWjNsOZBmGF2yFT6Q@mail.gmail.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <c5918fa9-ec37-9636-5230-57260f7e8427@cambridgegreys.com>
Date:   Fri, 10 May 2019 17:22:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAMRc=McCxvwHgk-3wYE0e+qxJNoHK0AmpJWjNsOZBmGF2yFT6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/05/2019 17:20, Bartosz Golaszewski wrote:
> pt., 10 maj 2019 o 11:16 Bartosz Golaszewski <brgl@bgdev.pl> napisał(a):
>> śr., 8 maj 2019 o 09:13 Richard Weinberger <richard@nod.at> napisał(a):
>>> ----- Ursprüngliche Mail -----
>>>>> Can you please check?
>>>>> This patch is already queued in -next. So we need to decide whether to
>>>>> revert or fix it now.
>>>>>
>>>> I am looking at it. It passed tests in my case (I did the usual round).
>>> It works here too. That's why I never noticed.
>>> Yesterday I noticed just because I looked for something else in the kernel logs.
>>>
>>> Thanks,
>>> //richard
>> Hi,
>>
>> sorry for the late reply - I just came back from vacation.
>>
>> I see it here too, I'll check if I can find the culprit and fix it today.
>>
>> Bart
> Hi Richard, Anton,
>
> I'm not sure yet what this is caused by. It doesn't seem to break
> anything for me but since it's a new error message I guess it's best
> to revert this patch (others are good) and revisit it for v5.3.

Can you send me your command line and .config so I can try to reproduce it.

Brgds,

>
> Bart
>
-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

