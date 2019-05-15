Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774E7C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2785D2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="B24YmH+U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfEORKj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 13:10:39 -0400
Received: from mout.web.de ([217.72.192.78]:54115 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbfEORKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 13:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1557940210;
        bh=7yH6XBoD1LqUrBdJUCnrnn+KygvIGP5Yo2n4rvG5Usw=;
        h=X-UI-Sender-Class:Subject:Cc:References:From:To:Date:In-Reply-To;
        b=B24YmH+UECMbQPDEgSdsjFK94ct24lAzaqAiI08goi4x4PT0JktH7Z5gQLkgEEx30
         r5IYtNqciBO+qJEi89g0K2qJX4Os0LxatSKdAbG5gZkwwVer8MGWifX/lhPqiSuHVk
         gTbYlHR449YKt9zz1tL3POID3dpJocZbxkl2fbUY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.244.73.153]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MA5v3-1hXsEK3A4X-00BI2G; Wed, 15
 May 2019 19:10:09 +0200
Subject: Re: [4/5] Coccinelle: put_device: Extend when constraints for two
 SmPL ellipses
Cc:     Julia Lawall <julia.lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Yi Wang <wang.yi59@zte.com.cn>,
        Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>
References: <201905141718583344787@zte.com.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Wen Yang <wen.yang99@zte.com.cn>
Message-ID: <eb66b997-fe0f-3118-126a-118de9530720@web.de>
Date:   Wed, 15 May 2019 19:09:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <201905141718583344787@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:1X8c9sX4zUd1qrc41m3Cw67a4Cy+j3P5lKKTgBa9xoAyUneJvn1
 kE74m2UgmbbJm1+sS/4CreDRC/FMnzYPMHZyQUuDrtj7sL7w3281DP4gFg0qkmpPdbTC1ue
 sZYiXBdAttId7dBz5o4vIf9nxk38P4z0FIfMLudfy+pDGIoHnXl3JCETCkoZoX35D8WKLBY
 qZ4ySNoWNWZa5ZRgRJMsg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DpsGEru74WY=:08hchDUNV3p+o+mu0rR2Fy
 nzJkmw8nB30vr/j4xdQi3cFqUSl6v5vk/Y2LUXSAfvKFMrXlrCPHxy3gXxpYdsAQ/JCYMnTZB
 gazRRT2c+/Dro1MXJMcoUogIEWfCEsyg8n2AI6UkVArotdbx8gbkZUpAw8j3ciTinJrNdYoJN
 9b97lVSErkRcdHajObiNEgPL4t3L3SPNDGog+zqNauE/awU1Ief3BKMU/iXJ7tdf6GOj6hwZU
 Nh0fdwsUesK4reIxyVYZe8IBNlaY8fUJ4Br7ymKaQ4QsUDEB6ljzAzl3Fz15o5gcbQY1LJMO1
 PvixuUQnmRQcQ0f3rB8Oqq2biAfdT11SghrshhPWIlDv6LVA4B/Rwc6JYqpDV8AkqS0sl/fpF
 ETFugTSqHE4enAENQ0zYlKlfpqAzsgZBnNLpbgTpcO/t7SCHrTeri1uJ8fN/XsPHiu6zzuoJa
 jaI5zH4eGfR3latnFGR/YZ/YOZHy6tXKHFfe5WA0+mXusZySNzzBrKfUVCjpBPXd39VGo5s+c
 I7+7aHBLTuZTZxZ4As1cM0Hmf5cptuYYXmaQ/nP7CV6dsBVWhdyZXuNfPg+Vt2RnNC2k5l9DG
 SkEATNsshJnyU9a/iBoocRLEhXemEDnrccpeCijPlT7KLcXNNGCiyeRNUm1V+jz1oz28dV/7v
 PsNBIlWcKwGcvtkocvm8eAsA44bQvi9t30awfsYx8ozAMMvlJB15tQvxIddzVfDTS6dFxV9QL
 ypb8VSph0svoOETcj8R1ocjiwVxNTkLrW5i7bzZjBKc2S6cFxAgplek90YBfxcosnesGEJ887
 /iqHMBq11ubOSbv4wsGr2Md9VuCdeM9Ew/NP04kcDL73b/a/zVrad0/ZArSNWQ03Dft6SY0ZR
 ezrU0gjPZQ9xkqi/9ZAMTI8rCf1N3ab34A5Z0/nZt5QPR0EZMKE4RKgYcL2/sQAkomNvAxyIq
 p4Y7U884h+w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Could we use it to find out as many bugs as possible in the current kernel

How do you think about to work with any more source code analysis approaches?


> and then modify it?

I guess that you do not need to wait for a solution so long.

Variables which get reassigned in unwanted ways (before the desired call
of a resource release function in the discussed use case) can be found also
with the help of the semantic patch language (Coccinelle software).

Regards,
Markus
