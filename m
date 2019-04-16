Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45581C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1C720821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbfDPVHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:07:10 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:33899 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfDPVHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 17:07:09 -0400
Received: from [192.168.1.110] ([95.117.99.70]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MHmuE-1h1hxX3V7W-00EsBJ; Tue, 16 Apr 2019 23:05:46 +0200
Subject: Re: [PATCH v11 3/7] anybus-s: support the Arcx anybus controller
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>,
        "J. Kiszka" <jan.kiszka@siemens.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
References: <20190416155618.1369-1-TheSven73@gmail.com>
 <20190416155618.1369-4-TheSven73@gmail.com>
 <2caf5f92-164a-3723-e2ef-42e4045d2ec3@metux.net>
 <CAGngYiXZSaUwrCiqavMGDRb5Vuo2x8fTjDetT00PAjjtrYW+NA@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <bd36b798-d129-c81a-ab2d-22a5b46567f6@metux.net>
Date:   Tue, 16 Apr 2019 23:05:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAGngYiXZSaUwrCiqavMGDRb5Vuo2x8fTjDetT00PAjjtrYW+NA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:N0VxcQu82aAgMiEqC4L+bfbIsBSqRwOxoMy01xoQIaOGixpdLmu
 66N0T6Qygcujlv6RWaQEb0ayUiFq6l/i2pS91aI7lDeZFSaybc15aAbJAfXYAn/Yr7QoGWZ
 qPbBehORZwxM2X1g2oNFxnf58nO0Ux/3JttiVgxo3CNjwZ8T80/SroNzsG8wj/8reeIFIzz
 p1DgF3B7phcqKSL0X4Y6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qh5Ackg+LjA=:NggQbzG/2NNVewG9Xip3AM
 GFw86HOzNqDXSYSGj5aiGhPU1vMYONKfIYgz18wQuZf4/eZ3lg6C0plc97LwU+eN8wr/tOpma
 9S9XO7RdKSFZnt3/lGxp22iWfgpVjSm6dUkoEHI9mJzzZjO/4Q5sjZH+9Q7VziueQR7Ru5zLj
 c+wgsM1GLIDRf6moxugh+ueCtLf2liXzt+JNYD44xbbMgxSxFdBWWC2/Ht5E71W29MZiRyI5X
 CdXpDLVhivwxtbz1zAs15UTN+5U/d2x2lkdvs5CPashV1x8UhF1MzeHLb1m5BT71FiOl0InTy
 Vl+Yjmlr2VAXTnBhyobnUcgXnnQR5E87fSXsecr331VaSy4oT+NjWUdDP6mjeOZCme1SFxzU0
 ylC8hWzxYqxwm8WLuiE3+qpUreku2l/KCF12aq8CC37d/XNsOx16R6jjEDL+G6ZDJy3/tnyJs
 H/2de2VlUVas0suAH4Jjet0WkHwLAzcp4gItIqPXJYwUCCtin//U7lF4rAjNBkwJpSkImzVCL
 AWdcUTPW8d7x9gYaZVE9FHwo7QJqUjqgMjPCAJvgaOfp0Fwxy9sOtG9wIwQR4hL5TMccy3IEx
 x2JB3AYYIAyub24No1/GNU8T9buZPoC2VAEP/gEX87QTbsJ/BrMRvSpKwMBdIm2hfWRYImuYv
 OMpqb/TpU+rvt0RtKnaBtJhqnv/mRW5HioMKGDW0tS98wfFbi34l0Pdy134YSDfyEf2lssl1W
 nd/nzGcbVreEnDD0uCa5rEZDMn8pTeFgwlFxYKOEffxvRpyhTjeUFIyafhg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.04.19 20:35, Sven Van Asbroeck wrote:

Hi,

> The "CAN stuff" is just a binary power read-out, routed from an external CAN
> card, which may or may not be present. The CAN card is not accessed from
> within this driver. This situation arises because our h/w developer team
> decided to integrate various unrelated pieces of functionality into the
> same hardware card (even into the same 8-bit register).

BRRR!

> This arcx-anybus controller card has two unrelated pieces of functionality:
> 1. implements an anybus-s slot
> 2. implements a power read-out from an external CAN card

So, it's an mfd (multi function device) ... hmm.

By the grey theory it would be better to split it into two separate
drivers. But obviously, they need need a common part (a third piece).

Does it ever make sense to only use one of two functionalities ?

Does this power read-out involve some CAN traffic, or is it just
fetching from some card that just happens to be some CAN interface ?
(IOW: is cansocket needed for that ?)


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
