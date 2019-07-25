Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5C8C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 19:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD01214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 19:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfGYTMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 15:12:49 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:50557 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfGYTMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 15:12:49 -0400
Received: from [192.168.1.110] ([77.9.64.13]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M8hlZ-1hm2Cz1QRd-004kGV; Thu, 25 Jul 2019 21:12:44 +0200
Subject: Re: [PATCH 0/3] Update pcengines-apuv2 platform device
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Florian Eckert <fe@dev.tdt.de>
Cc:     Eckert.Florian@googlemail.com,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190704090205.19400-1-fe@dev.tdt.de>
 <CAHp75Vcocs=9AwX32ouOWFc+wAduCFv2DT_p4JYPUVV0BumjqA@mail.gmail.com>
 <4b43316c-3e05-0ce9-3ada-db22996205b9@metux.net>
 <cc5bbcd7148ece53a075948f240bc66b@dev.tdt.de>
 <CAHp75Vct4O+P62vUo02e5iJy9JMFBDjijFf-JUxjRrMhf1XTEg@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <a453da4b-b5ab-2b30-5ab7-6214980baf7e@metux.net>
Date:   Thu, 25 Jul 2019 21:12:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Vct4O+P62vUo02e5iJy9JMFBDjijFf-JUxjRrMhf1XTEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:xtoZTVXhxKKzbSKRgROfuYu8SsntAyy8Ke/HhDt3rB1AGAXU3C8
 qpwVNJiRrYT6E0kL0MHdEMY1LNer2lZc6f+F9cqL/WQ9+8v0sgrr0tf972JRBDlmescdkYm
 Z4YbEfb9+f9xDK+iyVTsGA6XXz9nsJ0PUi7MpvWJiBZM4DDYytF+1CkUT0eGj84uRFQHmRW
 gVD3lTXc10b6cFAB6nJRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rtNxlECWR+E=:eFpoyS7kQadOvMs2DFumPo
 MggGu9S7CiUzA7VXNIFQzPGqXfrBtktRWpFSddURdG07+EvwmV1dz0zagjd/2X/aHJIrUj73c
 vU5uAHv8ZQhmP12MphML9GWmcpwk++LKDYgQu2EwAYCMCpBh2n943Eqqe8c9DDJi/paP3Gf0D
 2naaaC9/6Pcnzs9ny3h9XbxAoNhdcMwRK94KtCV+YooekYSQAl+RJuIpalJtDAeoeEUsx5d/B
 imzk1+cBvlyfqKtWHJ7Ox00mYccVWXvNyIRvHNYnyWNQWg1URkiij8/W2dWzbzGUFe1i4Ogdq
 /vV+hqBRidyuwvwGGg/PTDmIVyIOGbwtv5z8QobIKSDYwYaXIYkalCgZsCiqVx3MV/h85EWWc
 jEUwtMQFJibpSDUwhovxn7twDNKnbvSVKZ/lNtCgWohrHmC0c4Ytd3xDljDKGaBLRW6VhUHp2
 zauBqIwFq7V8snRyuE2TzdkOc4G4PkY1iRZHLfmEhxrzJfdh/XOJvzmYZ53sj6yOIGNSULdBv
 cYIaTeAvvXeGCOBU1pps9lTn0kvwn4avgvSmCTpsIN8mMKeWgo2Be43Rh2A8b0yxNBsXpsCoD
 fOzwxnuy6t8SMPKyTGoNeTeZqtlqx4XqSrDOe+PXJeJ6ZH643chHaKJo1mdUTohUT87ltH0Hc
 CQAZdpxP6ZZgzN3O1NuC7J6q8KZ7H1i2mdbukt84omHmJat+0lZ3npQENRFWsAePruRlTVw+T
 ManOTRVIEC9LPpQdeM/CoMS5kqVD1IBRp9LAlOB+/awewUUvH7R+34gb0mM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.07.19 19:49, Andy Shevchenko wrote:

Hi,

> On Wed, Jul 10, 2019 at 3:54 PM Florian Eckert <fe@dev.tdt.de> wrote:
>>
>> On 2019-07-08 21:45, Enrico Weigelt, metux IT consult wrote:
>>> On 04.07.19 15:39, Andy Shevchenko wrote:
>>>> On Thu, Jul 4, 2019 at 12:02 PM Florian Eckert <fe@dev.tdt.de> wrote:
>>>>>
>>>>> This patchset adds the following changes to this pcengines-apuv2
>>>>> platform device.
> 
> Guys, I'm lost with this series.
> So, for now I dropped them from queue, if needed, please resend a new version.

@Andy: please take my patch for the keycode change, which I sent
separately. (Florian's version also added raw gpio numnber).

@Florian: could you resend your patch for the reset pin addition ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
