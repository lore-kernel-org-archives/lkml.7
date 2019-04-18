Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF18C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E8C2183E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388259AbfDRIRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:17:41 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:33269 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfDRIRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 04:17:40 -0400
Received: from [192.168.1.110] ([77.9.47.20]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MEVmm-1h28mv31Hm-00G37N; Thu, 18 Apr 2019 10:16:03 +0200
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
 <bd36b798-d129-c81a-ab2d-22a5b46567f6@metux.net>
 <CAGngYiUaUoRUAiGUGbJEWGRj0bszeSsDDBfZMwoWokQRrMUhfA@mail.gmail.com>
 <3103f45a-facf-89a3-8a36-84507c570909@metux.net>
 <CAGngYiXd34hTriDsKvhOWogaF0uLfVbUn5BzJc3cUnZcWpFXAg@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <1e1c3bc4-a429-14cc-1516-199d253430f8@metux.net>
Date:   Thu, 18 Apr 2019 10:15:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAGngYiXd34hTriDsKvhOWogaF0uLfVbUn5BzJc3cUnZcWpFXAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:8qsoXvQnXTmrak0Fh1Xel0Vx7Nx7XUMoTaCgNOqdtwM8851Qyrj
 ++bTxXhwDLaF/BKomeQ6keNSZu6sY5ze+YhocemdRq9yvf9gm2mWZpR0m9UVIMbkMNnGGqb
 fUARWmPzhKxFWBV7ucncZTMcb4SUGFEB4TyofwOs/6qKTNml9Ko0gclzly/HWiNZfSgLHRs
 Yxoi/pQBi0cPJd1/tI8Ug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z79Opu7sBKo=:AhNz//jJX1uWHa1V7jzTxo
 naIMw49DVtkF5jYeeZnM/F6ExfTea/75sert7ccHx4ryOFWRTyvLyh4dfQcfCDEnauiJl2qer
 MY5WeFw85Zfn+0oQ4ww38a2xIBKzWbxE8kQAY9NuqCdqO6kqZ9xgSmhK3cTjqjB1B9CfwcaSx
 WUi+t8Vp+TcOIXFxm+oUPvACvq25HOVdwxOVphdhOQ0z2GG4wDpqBj74VTDiReM5CGOQU9cuJ
 r+Vw/yYwd7vEhWAkNORBOfbk7gJFU2UogNMuyc1N8AE9OQod5RsQlhv5xUARbGmEMNlPqWI1f
 ArEGEP80aqtNEDx/CvmjD8DaWeBJWmDJ7dz1cY1rkCew70eFkHkuh9kolMnBypCC1Qup59O86
 Ah7tyRvvwUwqOsbkazmIPkP3jGbbKq3uLilHmY0WYGxEVroiAqwGzEoYA9BQhTm3paKrn1LQW
 AUQKjJjAkPTIiQL++mhIWNE/CYjL++Ttl+kW9RIKIRM5fQ/K97V45tMfGcDyAWp5OSZGaNWZQ
 Wv1dGt4qH9cV02SoRLCm5rWA5bkcR4xjExhmEFQskEqDzGk9YaJYvjIqvk3vHVp+iPuMactL0
 X1nNlGDxmdV/oNUzr1EhPSSlX+L+rpkWmg0tSqNDOxYOnjB8BUnwCWu/Tx1o7PA1WjK1jU9ks
 qc804eWlR/lAZJQkw6C9wLpPjbLYFKXw2bqKP7cWOsCcB0N8acUixqWb0PxPlkty2B3hXrtwy
 MGBeu4UZQmGSM2yjXDPekCXW01BNY7HeLbg3YKhVpYqFulxPfSVXHH71SQw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.04.19 16:17, Sven Van Asbroeck wrote:

<snip>

> The input subsystem is concerned with input from humans?
Not necessarily.

> But in this case, it's really a power output from an external card
> on a PCB assembly. Regulator seemed the kernel abstraction
> closest to what this actually represents.

IMHO, regulator framework is for actually controlling power supplies
and things like some device driver asking for powering it's device.

Let's recap what the regulator framework was invented for:

* on many boards, some devices need to be explicitly powered
  (or are powered off for power saving) via external regulators
* these regulators usually are generic chips, just wired up
  differently on the individual boards

If I understood you correctly, your controller has an generic
digital input, which you just use for monitoring that external
power supply in your specific usecase - while other folks might
attach completely different things here.

The really "formally correct" way, the pure doctine, IMHO would
be having that line as a generic input, and in case that there
really is this some power readback connected here, bind it to
a generic driver. (of course, pure doctrine isn't necessarily
the best way to do things)

> I'm honestly not fully satisfied by the use of the regulator
> abstraction here. If you know of a different abstraction
> which seems better, I'll definitely consider it.

hmm, maybe we should talk about what is actually done with
this information.

can you give some practical usecases ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
