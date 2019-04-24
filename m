Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18147C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F1C21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbfDXK1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:27:14 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:37459 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfDXK1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:27:13 -0400
Received: from [192.168.1.115] ([95.114.95.254]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MpCz1-1h1S0L1Blv-00qkwh; Wed, 24 Apr 2019 12:25:54 +0200
Subject: Re: [PATCH v11 2/7] anybus-s: support HMS Anybus-S bus
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
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
 <20190416155618.1369-3-TheSven73@gmail.com>
 <4aecef30-0d64-c5f7-c4de-43b0754e2fdd@metux.net>
 <CAGngYiX3QP25MLupsc-=gfb6CAh5wK49eGs2xqHh_5LxrKtaAA@mail.gmail.com>
 <34a70ef9-4bb2-98f6-2344-3a0482b5cb7f@metux.net>
 <CAGngYiUroMwErLugXeVXwHc37Nm+Bw4Tv5i1VUv8=qVcNbaSQQ@mail.gmail.com>
 <2630e582-cc4b-764e-9f20-f5a2905fa4ab@metux.net>
 <CAGngYiUWnFeHLee5c1=E6gS1mZtL9ferzaTdm0txFaG2wVCxpg@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <32fc1e18-ebd3-3c60-282d-0f8f94cdf5da@metux.net>
Date:   Wed, 24 Apr 2019 12:25:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAGngYiUWnFeHLee5c1=E6gS1mZtL9ferzaTdm0txFaG2wVCxpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:0fAhs91tmO3/tXRtQ9PLPh1EAxIobZEZW8JfqSLzQeB3Pj4gbWl
 0pOtIZb6gWrl9AwMPE/VZpUAFYZbVkioBNYefR8n+2wdIMsNz+Xf412kjuOvKCOuv26U9sp
 tgFA49ftUuEwglN0Nao3LGlv9a0+xakFR9jTchjTZMjpD+Orgc5ft1AJPKA2QPLIRR+eLZQ
 nyHkkgd99DCCFMirusKMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Aahsg1OlxT0=:ZRiimcjHBoDpZAbn8XL3C4
 W2LYuSGVLdoIVNb+GxunYDDuysAEkvjenFSuH7lMAzquNzFuoMzWr6CuVwFRVMvFb3f5Y70Zl
 n1BRI4q9BLmvurfDuapUMlPb98eOZ7x2liffb4vk5Qnw8mVITnAQlh1VHvfOrT0/DPrbEzorp
 OK5MCxGZUKDF8kEjF7bIF48/iUADAUgojjIqkt6iiNYqeodbAd+oijaDttoAbgX7P39cOb8iM
 Frf9Dx/EJ3yOwOs6xw11NOUxp6hDE3YRpo13ufPmB5WE4QGB9cu5khxLHefyKCcDAAuvtYfH/
 ij9O4zimufe1acYU+0OyPY2BfrfxjDtKOM/gTulmABw3UB45aIOjAh6Vs3UQkgLoUP1RBe7Rz
 Akg7HXDKEGX3fn/xQEuzigp43jYSBcRc4osm8FgwpjJfVF9nWa1Rvobz3U7xTRZsmfAa9jcu9
 VAEkjk4SFf6+CBJgrj108Ns1JW31wz9xEJz3+ThqFNzoeVlXXrxcoDu4HYZ3G3kU43+K7v7KC
 6yzuJw5OfrrRhfmHfIZAUCZ9zytAQDRMI7hmwOIKpBMFIjuTV8kPSZ8iBNtJ7r7hL3XyDHDq2
 asMavlJL1b0j2RI+Or5Oi2T0N34A84b4+KC9ZOXDKiYgomyGQuX7/B9xICkuDKmz3BVd+9lT3
 eW92Py1n2KvHRC9zfs7DGhCgSKCTh62BMz1qXT9VRirKfY5//L+woVdORfZjDImVrsTzSOtZS
 3e+fnUuJZTYkZUetMfHRlTOS9wJ3RhQQK0jap69je1QV76Fz/qCFhwlUdIk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.04.19 19:44, Sven Van Asbroeck wrote:

> At this point we don't know yet where the API might possibly go.
> It might evolve into something broader that includes IEC61158 as
> just one aspect.

I doubt that, because:

* All the devices (at least those I've seen somewhere) that follow
  semantics similar to IEC61158, are actually IEC61158. (maybe not
  everybody fully spec compatible or some dialects). Because that's
  exactly the industry standard for anything that works on that shared
  process memory model.
* the other fieldbus'es I've mentioned have completely different
  semantics and just fit in here.

Therefore: we should call things exactly what they are. We don't call
grapefruits apples, even though both are round and tend to contain a
lot of sugar.

> If and when we mature and get more users/stakeholders, we can then
> look at changing to more specific naming. Definitely before coming out
> of staging/.

I don't like the idea of name changing *after* this went to mainline
and people are actually using it. At that point, people might even
already written their own drivers, so they'd have to change them, too.

Please let's do that ASAP. It doesn't cost us much at this stage.

> Greg KH has accepted the v11 patch set, so at this stage we can make
> changes only by circulating patches on the mailing list. 

@Greg: is that already in your tree ? What do you think about doing
the name change now ?

> Would you like me to post patches for anybus-s documentation / making the
> regulator optional? Or would you like to have a go at that yourself?

If your patches haven't been taken by in Grek yet, it IMHO would be good
to rework the queue w/ the missing pieces (-> v12). Otherwise separate
patches ontop of the already applied queue probably would be better.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
