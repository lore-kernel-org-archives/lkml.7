Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7261C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7921320821
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388271AbfDRIeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:34:09 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:32911 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfDRIeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 04:34:08 -0400
Received: from [192.168.1.110] ([77.9.47.20]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MKszj-1hXt3w3FLJ-00LCQu; Thu, 18 Apr 2019 10:32:21 +0200
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
 <c1831703-a476-8870-0a5f-9060bda0f669@metux.net>
 <CAGngYiXx2eKR7DnHm9sNWVC+B1F2N6uUNXqZAq4rey2yjU1RyA@mail.gmail.com>
 <23a25601-ed98-5348-9bac-bf8fc2baea5e@metux.net>
 <CAGngYiVJwRh_ESLfSYWak4RU60T2D1HW0-3Hg1CZbRjWhaSN5Q@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <7ceaeb70-f937-bd84-95e5-d7a6baeb5d87@metux.net>
Date:   Thu, 18 Apr 2019 10:32:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAGngYiVJwRh_ESLfSYWak4RU60T2D1HW0-3Hg1CZbRjWhaSN5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:LeMVM4oiJEs6z4P0rdTtgEAOxj8YetWvkXGBSR54cpTgWDffYk7
 PT5mxzmyvvBzR6MRneLfOw5Pif7S0p5YC3ivXvgN7EFzjUAr7Lc5tYasXJvd5WiiAWvCi0I
 up8vBY3GAUb5lW/Q6FhtMnFzQTWrI7ZudvbNxoI64iyZ+BhJ8N5A9Oq96/gvLfarCQkLqRO
 McAZk4SKRPH1DOVTSEjFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i0A0u5Zs6gA=:1e8722c5dNnOJvb+cAeGQz
 AllFeHoZsyMh/MMzGfbmXiax7nT4T7BPJUS5yAHJWhuFbHgP62LWafeJFIQE1RWMU1DykY+CS
 ZN+R8upIQnHM53bGILrXwz7CO1aDxORN/ni3HNjMS3SL1HdVhZ0tmubeqhVoOJa+fmyH7VueF
 DORLZ/G7kU+midlsJgcc2gZocMdH2q5JkX0/07GdEsQPy11a/kW8os7LHRGclP06Cq0a3usl4
 m76Z0fnYsU/SUPmhxaUm3z7MClkjFEusuUZUAy5wayAFyqWU1pLCEfB+nbDOjvIDC9wRngwyJ
 PuIW4TfM6Fd/YFU8pGWqYqRCW0gslz9M0mX+oJn8k2D5nxmOJEfjfEC1bFwnV2uZ7A+gyMQmE
 rmS/ZuLj+io/EleYl4orjs0aDw+hJhGrFAZwHaJf2Zon8jfYr/RqIayIfcNrBJU8m6M51BdX3
 1Ux6gvQ6xeFQoEX7JIH3qTVB5CuI2VNssZNCVia04XuwDZC0EY3RRu2z0Ph9cAR7lActySdq1
 07rHy4sh+HObvlxNImvycC1HwTcFB79uu5qjiNET/aD6aZszJJ8SgxVMcnPY5/dycXUBWPBzu
 z+44hV+kf1/GhCvaoJMYGSqXgqGsS1s9fHMBdSAoVddDhwSlig2hiISiFfTR3Dp4UcTgQPCx6
 aHZ7l6y9oK0rhsZymYkhjzidKWZgLIhXbDxXyeaHVY9vwDloWG+Efm4mtF6xkWbNg5m5L3IyH
 bEmR1PI79zQCiCt6Dvl/t+6HI9pzjajhamrDyDj0bhlabmvC2XNXa4QWsAI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.04.19 00:12, Sven Van Asbroeck wrote:

> PS do you have a specific fieldbus device in mind which could be added
> to Linux? 

I actually had some Duagon MVB controllers (Ionia) in the pipeline.
That's stalled for quite some time, as my customer doesn't need the
MVB communication yet, for now just the machine as generic Linux host
w/ ADCs+DIOs.

Can't tell when exactly the MVB issue comes up again, or whether
the device will be connected to WTB instead. But I'm sure either one
will come in a few years.

> Would it support multiple plc process memories?

Not quite. More like SNMP. Theoretically, (parts of) that could be
somehow mapped into a logical process memory, but handling async
signals could be tricky (at least we'd need a mtime for each field
and an change notification mechanism).


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
