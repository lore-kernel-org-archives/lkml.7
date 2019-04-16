Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6777C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B4C12087C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 16:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbfDPQvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 12:51:15 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:51663 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbfDPQvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 12:51:15 -0400
Received: from [192.168.1.110] ([95.117.99.70]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N7yuz-1glcVq24Wp-014yzk; Tue, 16 Apr 2019 18:49:41 +0200
Subject: Re: [PATCH v10 0/7] Add Fieldbus subsystem + support HMS Profinet
 card
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
References: <20190409144250.7237-1-TheSven73@gmail.com>
 <982e69c6-4e68-6f62-8bed-cd5a1802272b@metux.net>
 <CAGngYiUTHZFFY=H7xXHzZnN4pS0jAqWBTrcw04hjf5S-ykxC9w@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <c1831703-a476-8870-0a5f-9060bda0f669@metux.net>
Date:   Tue, 16 Apr 2019 18:49:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAGngYiUTHZFFY=H7xXHzZnN4pS0jAqWBTrcw04hjf5S-ykxC9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:O0x2OuRM6kiodTE2G5aSvYRTa9orAQ+PFTZmXSNZ7ZuBBxKzyPw
 0hGOejDHvSJREFYMIPwTwDJgJ1EV8PCBiyP0vi6XEPIgmCE7xpFFYx2daHR5v4jCN2F/QFD
 p0wXT47fxFQPRFaNtru65VhUWbLkjPQTHa/8AHmFj5owQkKqJYOTnxlNi06Jmq2M0o8LNqg
 PnLcDTyYEilqxmJDalXNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4396dSH1tgI=:35rZHxqU6bLGPb6SnxxHDP
 /q34MxU6V6q467StiEGJ4y1pDy6OOduvaPYAP+mb7uY64dt7hTxozFFfg6ezHRMIWUIqedeDK
 HNPfPBu9In02G1mX96KqwEEINs722xURScl7C6DX4Oe2h+vuvEM8qnGGuhfXNflA3ThDyzgeT
 uzefndGv4Rb9MQ1bd6t1gJ4TAOuvTTRBjYCMPGtzq3g2YqyPlj0jfNsNxNMPrlMisESRVRueB
 mNXq3PbC9kEWZ3sCBBexPr5QukxBhSEA9Zm/w0Ku+Y/X+XV/kJfB/UJBSlI4Ubiqb3tnsD5YS
 byTbvQ2wGmopZH6IaIZ1t24DuAsa7oHahSUvoY6pIKKZpx3GsanpEm9yFEsXsj8I5scJY0ERK
 ym28XnsfEK8NiMjtJ/BqID160YMnPsnATHdw49F96A5wJqESlBHiFklGmnu56b1O8WMvMsgyT
 Mq/Pf5/ulsH0OUaaxpyftENG2dnxEH8ZF5pESLfZtNYkirbpSIQgw/NvEuNOYf5dWoMbkjmeO
 jiTG7n6hnJyrQQQlVDUVZXOf9J2Dp5/Rqzxh86HONy3X/ueCoO+ttz/+5FQJZfBYEq0Ibym9r
 UWmrKqKmo/nfbzI7rd8ddS1+/n7TSMzydUBWgcMZbqIoc9MjxufxFRl5L0BBnY/c4uYEIKeWG
 S1Sr6x8067NJeMWROkdFnuW6tPc55V79iEiGy70LS9rGo9MC5gxhNuCcqLGZVYyb1XW6FSGE7
 ToZnV/onM0to3wT909dTAHkqu/YGSYEm4k1EjItiPeeuwVNPKsPCFkh4hrA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.04.19 20:31, Sven Van Asbroeck wrote:

Hi,

>> Maybe it would be better calling it "IEC-61158" instead of "fieldbus" ?>>> > Yes, we are certainly open to that, if it is more correct and/or
better> accepted by users.
Thanks, I'd really appreciate that :)

Maybe I'm a bit beaurocratic here, but I really believe that precise
naming is important, eg. for avoiding potential conflicts w/ different
fieldbus classes (eg. mvb) that might come in the future.

> Yes. You can open as many handles to the device as you like,
> they will all share the fieldbus memory. When the remote
> fieldbus memory changes, that event will be broadcast to
> all open handles, via poll/select.

Great. When I read your first mail, I got reminded on the old legacy
canbus chardevs (before cansocket came in) that was single-user only.

By the way: any special reason for doing this via device instead of
socket (like we have w/ can) ?

I'm, personally, pretty undecided which way is better. Device nodes give
us easy access control via fs permissions, while socket allows
firewalling.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
