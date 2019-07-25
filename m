Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAE5C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 19:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6D220856
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 19:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfGYTG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 15:06:27 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:55397 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfGYTG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 15:06:26 -0400
Received: from [192.168.1.110] ([77.9.64.13]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M42zo-1hqj4I0PNA-00070J; Thu, 25 Jul 2019 21:06:22 +0200
Subject: Re: [PATCH] platform/x86/pcengines-apuv2: use KEY_RESTART for front
 button
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
References: <1563795379-7521-1-git-send-email-info@metux.net>
 <CAHp75Vch3KNCkwp69a_fBtMy3B3k=NEbAmPZE2cn5HSn577HOw@mail.gmail.com>
 <332c666b-1bb3-d4bb-ad1b-98b36992de71@metux.net>
 <CAHp75Vf1pyWjK6hbrNqDjk4v=H0nZLzwKHNK51XteTCo4-QJLA@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <37af3904-7fe7-d151-c82b-252f6bcd00ff@metux.net>
Date:   Thu, 25 Jul 2019 21:06:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Vf1pyWjK6hbrNqDjk4v=H0nZLzwKHNK51XteTCo4-QJLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:OzNkqz4gZEOjwxUGnzwnKJOJTBlNFxIvQgQRL0WogJOL2mHEyRk
 toz88ggiNGPV+M+D0NATi3K46FLl0x3vQjl6UTAFAEWKyLeASt9/ECRY61GzstH2KDXe7+U
 ZB2PY82HgP+qvGXeMYJyjyf0BJDgA8Za5a4jHCA40/LBTOqINTBzLFEv5Fc+Qi8MZ5GCPKu
 aTJyAP8pZWzUeSDc6XvkA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IxcFeAWB7H4=:ZEaJ+Asa5Bkif/sVBqq9Qg
 Zo5bDZdZS1O1lc1M85//Aw+M8W0xWJz6ddme4FQj4zvwsO2nbgiREeQITKbIPxhb6xEzWxagI
 pod4fr2o2R81kZcA5sYlduWMx0TL9GbWCwzbM/LHK/TDloSG1qpHMzUuYnG4H5Cbqh4wIGnE1
 mB4StmoOQcGOQY/0QH3nY4PKIW6lyWwuCntbAx1uD/6zSvRrhSb4TVe9WpYwkO/uRLZE53Pg+
 aNb4Qiavl/T6ABI5dIeGHWgc6FthnqwbjVVVWBGcQkWCavCqTLzaUHIojkRLw8QLSDQNFFBfr
 0fLOAWVfqapxsALWGX2O5QIcrEg8Bg5QBY4D+1aHSFrm6SGu5N2l5dwKh1kzIrTz5ml4Yak6i
 bEIB5e8u/TGn5bfphSIJVDnTCIgxyRrTBrnakMzOnQyNFvHmSOJ4TmVCx5qWsIGeLs+kbPArq
 Mu4LZp9umMbYVHZrvRLgnkF1FtdkXvBxYIRGcZnf6X+iZAWbEiedMvTSShn5eN9T17fAGhGZW
 lqAv8ZmQ6/CMld4qqjVkYdMpS9+Z/n8RJHf3mW9dmclmy8aCj9B0FYTqGz2bKpWSPQnjYBtDT
 R5LoYdPsFcfcUlr2+BnCYReZc4hK8f6rLO9DgCddx0GSL7FIFjWUlAM9hpsebmcxEZrrTyoyD
 dGm11KQmPU/2o8Wzc/z6xuojAINa6ICMWdF0qpxS4U6R0XdCtc6KQRklGwl1z4Rad7VzGAE0d
 sbwpxdUFf2Y1T2MCXclsHetDJQzSrKMLF2mPcxPYkeFSaguSf2vo1/rSJkk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.07.19 20:57, Andy Shevchenko wrote:
> On Thu, Jul 25, 2019 at 9:50 PM Enrico Weigelt, metux IT consult
> <lkml@metux.net> wrote:
>>
>> On 25.07.19 19:17, Andy Shevchenko wrote:
>>> On Mon, Jul 22, 2019 at 2:36 PM Enrico Weigelt, metux IT consult
>>> <info@metux.net> wrote:
>>>>
>>>> From: Enrico Weigelt <info@metux.net>
>>>>
>>>> The keycode KEY_RESTART is more appropriate for the front button,
>>>> as most people use it for things like restart or factory reset.
>>>>
>>>
>>> Should it go as Fixes?
>>
>> I think so. Technically, the feature already worked, but the keycode
>> wasn't semantically fine.
> 
> Can you provide a Fixes tag?
> 

Okay, sent a v2.


-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
