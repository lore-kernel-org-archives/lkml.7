Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE2DC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1453A2070D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfE2Mbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 08:31:42 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:57097 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfE2Mbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 08:31:42 -0400
Received: from [192.168.1.110] ([77.4.0.132]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N0F9t-1giF8h3RZ9-00xGP2; Wed, 29 May 2019 14:31:28 +0200
Subject: Re: need company for kernel upgrade
To:     wharms@bfs.de
Cc:     Pavel Machek <pavel@ucw.cz>, Theodore Ts'o <tytso@mit.edu>,
        Aung <aung.aungkyawsoe@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>
References: <5CE53BA9.4070906@bfs.de>
 <CABC7EG8NiiPycthdfb7Ng3MsxTvmmxk_LjcosM8ZD1F0CnuDFw@mail.gmail.com>
 <5CE64BC7.4010803@bfs.de> <20190524050116.GI2532@mit.edu>
 <20190528105853.GA21111@amd> <585d6508-ace2-02d8-95ca-8e437d7cec05@metux.net>
 <5CEE3D24.8000700@bfs.de>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <d814a076-5f83-6c54-615b-80159108e63c@metux.net>
Date:   Wed, 29 May 2019 14:31:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5CEE3D24.8000700@bfs.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:1xPGAH/2Sn+WIsUcIuW5q1A3xNWMnkkIpFXpk7EIDJE324bVPpc
 GDHQmgGhoZNeg1FkQz6zx+sTPLjHuANUloIfzRyEy6RWawsEDLM4tsMsROt555smWbMQRpY
 9wsBIUC9ZEznSBf4L5DPK+pbOLAIDUzQNrwr9uvm3c7EKmENwb8Hgreya2cjbLMNTRDi6Z1
 /q1736ecXmfy8SgLoGciA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8kSDJpYnGnI=:UlrJE9wyY1H01YfZvQECjx
 igIYZ7quUOxIsNHB6fxSqR5ZnHQ8ly1G52idwv866TcW0iLXWBMxA/CYZc3hNIs93d/f1i4Dw
 7xl4QFz4F72TIFBSuAbpxcOhzvyi+jC+LOLdmFSZsZ55kqcRK47w0E3JwOiVSHeoqHyYWEP/+
 S/9Ie/ZtPXDHEqiqZ7btCk6JblhbrrHFq7jotib5uzVCl+M0ZiNeMYO/YiuX/Uv9UaN9Tiivc
 xR5uhMCbWGkoIJiS+mcEuKDYPxIv27EOSx88g8et6QwowTMS4UzX5urtjtvaaOLu4GNfDA787
 ZEbsnvRvXhpBLCmeV2H7C/FSIE+7957ygBvigVyWY3AQVgWAhg1X/OsLcevYqhpTcDyvn443D
 joAh2aDdtzKg6V1n5peztFtw+hYOs5JxDdyhZbcyb9zPeAGrOq5gi8x8kligePB08TPIVFVVH
 e8elVsLJWFFUESS8OervOZ3PbhFiULt5hemeibv/vWPf8Y71aUn4nTh0xk2BEEdVq3qCZDJ3A
 tCs3cxdeM61pU5YBJNK6xyMn076QdxGb75wWJXf+Xn9dfZ6auu2Fi9q4VUCUlusCHoSsCuDtg
 Bt0TwME8RXzzNByENxnL6CkqznPDzyi9LIFXdmYjj+iw5Eq0z8juJVkttmwMw/3mPuhisSav7
 1B1XpTp8sOoEjc74xOHNvdYxWsOMbhb5/PifPq72sDuaq7Nd5MyEwJctQbOTODwwgxODuHQJ0
 sRfmxk62fNMhJiNxMwwHQ5CRk7P/o+nkTEXOkOnGjM6T0qd07F2G6pu3ag0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.05.19 10:04, walter harms wrote:

Hi,

>> basic rule: don't use vendor kernels for production, unless you
>> *really* *really* have to.
> 
> we have custom hardware, so this was needed. 

Custom hardware doesn't necessarily need a vendor kernel. Most cases
should be happy w/ board specific DTS, possibly some extra drivers,
sometimes perhaps a few extra tuning patches.

But: such development, IMHO, should always happen on recent mainline
and things that aren't really customer specific should be upstreamed
as early as possible.

Vendor kernels are a different thing: usually they pick some older
base versions, do lots of strange things to get their hw somehow
working, and - one of the worst things one could do - merge down things
from mainline into their fork. After a few iterations, the code gets
pretty much unmaintainable. Such things are probably nice for a sales
demo, perhaps emc tests, but certainly not for production.

Just have a look at typical android vendor kernels. Horrible.

>> HW vendors usually don't have the capacities to offer any decent
>> kernel support. there're only few exceptions (eg. phytec) that have
>> their own kernel hackers and actively participate in upstreaming.
> 
> We have noticed that also, *active* is a big point.

Yes, but most hw vendors even never have been active in the first place.

Even if a particular company is doing that in *some* area, it doesn't
necessarily mean they're doing it for your particular product. Just
look at Intel, and what mess the produced for their flopped sofia soc.

>> by the way: should we create a separate list for commercial topics ?
>>
> 
> I used linux-arm and it worked surprisingly well (not all mails went truh the list)
> but it look very silent and i was unsure if they were still alive. 

IIRC, linux-arm is for arm specific development. Sure, the chance of
finding some consultant there is better there, as arm just has a huge
market share in embedded world.

> A big win
> for everyone would be a FAQ/Lessons-learned something you can take to check a contract.
> the customer will know what to expect and the contractor will know what to offer.

hmm, if anybody else here is interested in that, let's start with that.
maybe these discussions might be better off-list ?

> Having something a list of minimum requirements like that FAQ would improve the stand of
> the hardware developed to support linux. Not everyone has a big budget or need to
> produce in millions like the raspi guys did, and even they have sometimes troubles.

Well, one of the basic rules, IMHO, would be: if you're going to do some
linux embedded project, you should do a proper evaluation:

* check whether the board is already supported by mainline kernel
  (try to get a running mainline kernel built by yourself)
* never use vendor kernels at all
* check whether your supplier has active kernel hackers and actually
  does mainline integration
* if you run into any problems here, call in a linux embedded and kernel
  export - *soon* in the project

You spend a few extra bucks for the consultant, but he'll protect you
from the wrong choices, eg. buying unsupported / badly supported
hardware.

In recent years, I had many clients that called me in far too late.

One eg. was trying to build a medical device, using custom boards (very
high hw development costs and long timeline, due to qualifactions, etc),
with fancy HMI, but picked imx53, where no *usable* gpu driver exists.
When I brought the bad news, the project already ran for several years
and nobody dared to restart board development. (in the meantime, long
after i've gone, they indeed create a new board w/ mx6).

Such things could easily prevented if people just wouldn't trust the
hw vendor at all and ask us (kernel hackers) early.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
