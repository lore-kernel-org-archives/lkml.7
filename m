Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851A4C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D88C206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 11:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfDZLVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 07:21:23 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:49317 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfDZLVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 07:21:22 -0400
Received: from [192.168.1.110] ([95.117.100.117]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MGi6k-1hWcEn2BCk-00Dovr; Fri, 26 Apr 2019 13:20:47 +0200
Subject: Re: [PATCH v17 1/3] proc: add /proc/<pid>/arch_status
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Li, Aubrey" <aubrey.li@linux.intel.com>, mingo@redhat.com,
        peterz@infradead.org, hpa@zytor.com, ak@linux.intel.com,
        tim.c.chen@linux.intel.com, dave.hansen@intel.com,
        arjan@linux.intel.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, aubrey.li@intel.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>
References: <20190421183529.9141-1-aubrey.li@linux.intel.com>
 <alpine.DEB.2.21.1904242310040.1762@nanos.tec.linutronix.de>
 <da1fcb4f-e856-d31f-7c72-76c969af3935@linux.intel.com>
 <6a9e6bd9-8e1a-9fe5-135d-c7a49697b5a4@metux.net>
 <4456cc68-5120-e820-90ed-cb5b5dfcd760@linux.intel.com>
 <ee1620d5-9650-5bfa-c458-fa2d051522b1@metux.net>
 <alpine.DEB.2.21.1904251249200.1960@nanos.tec.linutronix.de>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <c6977015-094f-ad28-bdfa-7d350247fa46@metux.net>
Date:   Fri, 26 Apr 2019 13:20:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1904251249200.1960@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:6iu2UDUJXIjEOUJT0Cq807pTiz8aNtPHO0/Nd2SmjG8k7DvYbKT
 p6RgWLM2jRCkeOFR7gdAgSVbX3R+QNc9EEfy7HbBOgpDLCD4zOniV0zYWZBSX9vwDrx07mb
 q9EMfEKgWacnR/Gz+hnKhO8Yf+ThwCpw2Gfpnyv87xukXD3pXkEJfmaZqwK+iS8gGfD/H6U
 FGuvdZ8mnErnqVFSLYfOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XOai0o3jdag=:F+q7rwQXZ2HjIdJDqpDJjN
 mB7uwN43x9ka94h1p3FlkN012z4POQKkkmsgombvKdVsFh6K81bxKctOrOn3mN3biL/nwkwq7
 XDBgAOTiRdXMGbCn/9pwY8c0XAuqwNcUEkEr48hiVRhWTKgFRPoltT4ijaYDZPbWE6d+Gs9fK
 TGjPU6aPEqqH38mtZ70IEkoliuCG867HK3vTa7bQysYKroeJDZtgVe80aXe1fRZslUqUWdCXk
 XHPimo27XVLGt09IokG/J6EGkX3GYxrlBoCHM3ZSGaTslSQ3UtUiECrB2koPYvEjlKgT39h8P
 dLh7Qwqv2kAZn1Ros36qczzz/h/+YoRqiQacC7YPjxEARMGsPt8MfvP0+bDaZWIWLeEj0j3LR
 5cGbiDoWIhEI2KTlyPPgq/jN/U6qgjyw5NNYVahE34aK0uk7jlbaX4XH1NN1jpi1EN5K424VA
 nc3Oy6TSA89nshXErp0zEMIR6CrnEdnRwrNF547085R1ZWDP4xKkGoPZY5POjhZ+/X1hXKcoA
 Y/DTzPWmxAlx/YGxYVFyttQz/2G4pvL5a020R3WcExOFwfNl7UCTOZ+oeG39J+8lP4WOMqmBR
 o/+kSi8t9iFvfix8OorggIgDdt//g9v8g5f2Thk4YJuypMlcxtjmEwKgsC5n0wN3aCeYC+V5e
 tqBfIc14tAURoiAUGHdiahBGjM3uT5phXQhfvCMgvNd1+ARmE9GLHDEo2NZFyY8wxlQXeY0Ka
 S95dIv7ijMVaiaV2fZ0qojmpLnnddUfsujtvYWu6qY8rZfuEjC5M43CHe6c=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.04.19 12:50, Thomas Gleixner wrote:
> On Thu, 25 Apr 2019, Enrico Weigelt, metux IT consult wrote:
> 
>> On 25.04.19 12:42, Li, Aubrey wrote:
>>>
>>> Yep, I'll make it disabled by default and not switchable and let arch select it.
>>>
>>
>> That's not quite what I've suggested. Instead:
>>
>> #1: make the switch depend on the arch's that support it
> 
> No. That's what select is for.

Just for clarification: I've proposed the depend, because not only some
archs will support it - and avoid masses of #ifdef's in the code.
Therefore, it can only be enabled, when the archi supports it.

But if you insist in not having it configurable, letting the arch just
select this feature, your approach makes sense.

>> #2: still leave it selectable to the user, so somebody who doesn't need
>>     it, can just disable it.
> 
> Well, the number of knobs is exploding over time and the number of people
> actually tweaking them is close to 0. So no, we don't want to have the
> extra tunable for everything and the world.

The great configurability often is one of the major arguments for using
Linux in the first place.

Would you propose killing all the CONFIG_EMBEDDED/CONFIG_EXPERT
related knobs ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
