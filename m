Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1673AC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 19:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDA25208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 19:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfE1Tff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 15:35:35 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:39243 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbfE1Tfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 15:35:34 -0400
Received: from [192.168.1.110] ([77.2.75.22]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M6UqP-1hXdgM34Cv-006t4z; Tue, 28 May 2019 21:35:27 +0200
Subject: Re: need company for kernel upgrade
To:     Pavel Machek <pavel@ucw.cz>, Theodore Ts'o <tytso@mit.edu>,
        walter harms <wharms@bfs.de>,
        Aung <aung.aungkyawsoe@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>
References: <5CE53BA9.4070906@bfs.de>
 <CABC7EG8NiiPycthdfb7Ng3MsxTvmmxk_LjcosM8ZD1F0CnuDFw@mail.gmail.com>
 <5CE64BC7.4010803@bfs.de> <20190524050116.GI2532@mit.edu>
 <20190528105853.GA21111@amd>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <585d6508-ace2-02d8-95ca-8e437d7cec05@metux.net>
Date:   Tue, 28 May 2019 21:35:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190528105853.GA21111@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:nClehSuUUcJVCI6wPwpnDaXzKbjOUKFJCrohPHq8g2lJNWjcrmn
 4byxjah3f4OKI1P1uT4/yl97+h41/Igww9DNJgUUts3xiyT/lfKpZXPUruCXk/m+H7V/fnw
 GKQqNRlMHNfkqWLOE/2iFXR1cY71KlT8Q+CbqfdX0UxqT4vtFUbWfSic85OnDz0J7ug9IOF
 QBfNDR4/Wc468YSATeFpw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kU849XzPYak=:4oa1xFZK+sMnodhbB4gJ+o
 NXBIVdtNvA1ha5rakIC0FRe/gHiYRx8E9n59VJ3DBmHlhcXCaP1zKyaU0nAj2i95G1AoBNjui
 47nta3X4ZWmfHsl+VQTrAtQTP6sYNGkTrZqJ3Nb8RJd9/t13rQR627nzh0P1eh+2wMCnbvX7b
 Se1yqKzpN8nmNShwBtt3pB6oZvoB+kBR8vRc2eVqTdIFSdLEAPJdN/ViA6joXSALWpf+BMu1e
 80/K7B1nQJsMjKL9u6HT6C3Z8rL3KpWoVziksC172kLPP9NOCfs2Og4aCk25H8pUGMqlBnsrs
 GybPHi+pCAxx6FDyIXXHFBKf802OGYLE4r32H6n2a/i26OxEaLi6sm8lI7RX2zteC9iRqDWnZ
 AurwfCXnOHd5cnQKPoxKrhXlm6TojdFHktkl4vhCwCW06ROEhU9sufnZvQeja2CLPkGoAJGpb
 q8QxG8N727m/hpPjvUPs7eEP1oJ7B6YXxmIlxXoaGJX2PoVz0kr+odMd1kpuvyNUaalkLdS+d
 s5GLJd5rBpbYBaTq5yyYTG3slJzNSdVYNhEu8oDyTnTiaoIV8R958vQC+44nUWfXExau0QuJK
 fcFAgHkf6FlgrsgnyThbL3zntuk7ZhvKvN4kDhmpsq63VmWNzx2ToQ3YMW5z7ij2FZf7EJRcY
 YjB4McQEQG3pBTOW8MWU6oV7N8zz83S30Rn6gRryG//SN016vriGeZ9Pzb8lVinYevJNWuVmC
 m76D/GeOqXVIGtXCTCRP+yfNQxWDjEUzT8nQ965zSZzO6hzpLOsWqg7UnoI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.05.19 12:58, Pavel Machek wrote:

Hi,

> On Fri 2019-05-24 01:01:16, Theodore Ts'o wrote:
>> On Thu, May 23, 2019 at 09:29:11AM +0200, walter harms wrote:
>>>
>>> No,
>>> the company i am working for has a custom build arm-board.
>>> We bought the kernel from the assembler but found it has
>>> some problems that need fixing.

basic rule: don't use vendor kernels for production, unless you
*really* *really* have to.

HW vendors usually don't have the capacities to offer any decent
kernel support. there're only few exceptions (eg. phytec) that have
their own kernel hackers and actively participate in upstreaming.

>>> Basically we want to improve the linux-kernel so it can run
>>> native on our boards.
>>>
>>>>> Hi developers,
>>>>> i am in search of a company that can help upgrading
>>>>> a running linux-kernel on custom hardware.
>>>>> Est. time 10 days.
>>
>> Have you tried contacting Linutronix (https://linutronix.de) or
>> Collabora (https://collabora.com)?
>>
>> Both have EU offices --- well Collabora does for now, until Brexit
>> happens.  :-)
> 
> www.denx.de is another option.

continuing the list w/ my own company --> info@metux.net

by the way: should we create a separate list for commercial topics ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
