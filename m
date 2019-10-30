Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD55CA9EAF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C95420717
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="S0MHmKcW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfJ3IN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 04:13:28 -0400
Received: from mout.web.de ([212.227.17.11]:57121 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfJ3IN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 04:13:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1572423188;
        bh=adt5cshj7tdRkd/8kT15ltxZaEG8T8RAHqla1SWf0VU=;
        h=X-UI-Sender-Class:Subject:Cc:References:To:From:Date:In-Reply-To;
        b=S0MHmKcWM4F5FSkJtRRhgcnS/WTuI3caFzPequgR5MnUrHwvCA9O/3L2R04JYpOCy
         hUqeW6cTbgn+I4uli0mD+2IMcKIeVo9OEoNkbnG4fMmcou2aLWiHZw8RTLHV5Safjo
         KoBrQyJf9esZLDNxu2lRdUh0zVmfyk9FJ61Z3riU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.104.79]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LlF9O-1hsJIA0hio-00b5vT; Wed, 30
 Oct 2019 09:13:08 +0100
Subject: Re: [v4] coccicheck: Support search for SmPL scripts within selected
 directory hierarchy
Cc:     linux-kernel@vger.kernel.org,
        Cheng Shengyu <cheng.shengyu@zte.com.cn>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Xue Zhihong <xue.zhihong@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>
References: <201910301043292761157@zte.com.cn>
To:     Zhong Shiqi <zhong.shiqi@zte.com.cn>, cocci@systeme.lip6.fr,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <be9a9da7-f4b6-d7de-77d2-31bfe9a5f470@web.de>
Date:   Wed, 30 Oct 2019 09:13:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <201910301043292761157@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0Rpl9feHuvhelvex7aZWHdRTbNDfb2RuQCD4yyQ5aqoDjP1EtmB
 0d7bUbvaacyvLY7vlCBY3MhfjlX/XuYwhchg8YmM7L/jh3EXx6PzNiRPlQVd9fSie0LF5ns
 GvPYoE9UkxTNvamv/ZBG+LSukgmDxEFEDDl1HsWEgFR7QHsozrt9luKhx0WUKANNJrNNKb7
 MntUMzdm4+/ogTRkAkk4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nd2FDDr86WM=:72EmFImN//6f5LTsADwzTI
 vPjbqe0dF3HRSrg1TefnpWOLKNotNoNkL86Iw+ub+GYGnO0ZNaOuhmgwk3f1KHvGn4Pb/XdkW
 KMK5BPA3GxuTry01tIAWQjDyRPvg2w8fLNCe2M7yZoVi8D1RI+zLT9jtxTmqnKpTN5BOI98xw
 1Rnz910TmhCvZ44cM32X+zpGNJzdcjv5N8BQxeojWbCxNLIKVxSWKQoDjERXvd8kO0/YMz4te
 Xndh0pFmNTs+0YizWsuRwHfmA5+aZ5de4iDI+wJH2uAgae43cbWqyBV2NZqLyoqzg+54Y0HIS
 Kie1knOLvJAkl+5UV+xfpovQ241OFthAH9xbh5x0TjhsnsP5uWpVwtuG0o6d2mnPreo4zNYNz
 HLzpBODidhdPZZUuT8kmAxFdx7RMubvadXrUMWoFvSwLDZFlG8Y1e29S5JcYICQQ6nXh7zrGn
 LQmpX+aRlQfPCrWJJudWrraw3B1togI4z4Fb3FSpJTJmcWTejPljwe3XhJzgLH0AuB82g6hym
 Ld0tllIYtZsPr0UKdOyx/IoudI2ziOiEPTw1lHvmHIin/zShwJXxgQ3d/e60qa4jcqqfY4SY9
 vfZXp05hpLdyYInD1srH1Z6xhHaxeY19QVgbhZxWhNyRlCROU2yBCxyA/PMN3bA1hchqkmfq9
 NBiLGC/sprKySdneunnSOTQO2MQIe+nP9TPVj+cgou4jkqS0zw0p2mPdPwB2eRQNZ6liTKFTq
 gFQbY3sEIzFPJxqEYaBUHYqdcyBOpHGC0yNZpqSL0g8Cedim9mVxLirPO3rcrNfuMyMn7bvud
 eeNCyIqsplx9EgnCB6HsU6e+yg36HIopQJa5yYOSnGxqYlmvZA+Vc/boHZhPiPLBg/JZa+WMt
 V1By7LiP2tNkFYpcS1Zxzx4LGCCbSBmASSR02nENJu9q9j5kbqkuE3NVclaxVcYwvEM57K7Ih
 ua00c7tnJro29P45ARlcrq3frj04Nq+T4w+62WdVYiVg2tMArZORT7yKr5iF2pytQp7EVp4iG
 LxXbmEVo7PjhLCjId0XyjhwlIV5QWcLP8e5ZboapcnW47e8CjIISoOYDtH+aftakk3YrJYCoW
 zvl7nx1RBgMR2pZx2YgvcmInzCGhBiqHiDF2OKqLrqETWbIqE5gyVqHPcSkbX4P6LpUT2VMtr
 K0n57fQIH1M7+RyYU23VoUz0YGJ7IDXDZojvJMtGzzN7wAcik2SlxGxel4VPcBvOZykxAeHHv
 p+rOVMhBOkTsWmjibKDInRgx/xbjVLryN0dlUNKmJUp8CG+86jrhwroGXIuw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Would you like to update the provided software documentation together w=
ith
>> the small extension of this bash script?
>
> I'd like to but i don't have rights to update.

I suggest to take another look at change possibilities for affected docume=
nts.


>> Update candidates:

* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/dev-tools/coccinelle.rst?id=3D23fdb198ae81f47a574296dab5167c=
5e136a02ba#n189

This file can be directly edited in a corresponding development branch
for your contribution, can't it?


>> * https://bottest.wiki.kernel.org/coccicheck#controlling_which_files_ar=
e_processed_by_coccinelle

Are going to try any of the supported login options out for this wiki?

Would you like to choose any other data synchronisation method?

Regards,
Markus
