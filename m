Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB358C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 11:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC1A2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 11:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfKYLJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 06:09:09 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40765 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfKYLJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 06:09:08 -0500
Received: from soja.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:13da])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <o.rempel@pengutronix.de>)
        id 1iZCEq-0003T5-4n; Mon, 25 Nov 2019 12:09:04 +0100
Subject: Re: [PATCH v1 1/2] net: dsa: sja1105: print info about probet chip
 only after every thing was done.
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev <netdev@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>, mkl@pengutronix.de,
        kernel@pengutronix.de, david@protonic.nl,
        Vivien Didelot <vivien.didelot@gmail.com>
References: <20191125100259.5147-1-o.rempel@pengutronix.de>
 <CA+h21hrwK-8TWcAowcLC5MOaqE+XYXdogmAE7TYVG5B3dG57cA@mail.gmail.com>
 <caab9bcc-a4a6-db88-aa23-859ffcf6ff85@pengutronix.de>
 <CA+h21ho9bJsaq8e-gRhRpM+kXARNJ6tyL10vKVf2+7YOtaJGXw@mail.gmail.com>
From:   Oleksij Rempel <o.rempel@pengutronix.de>
Message-ID: <69a6c4b8-e58b-4a04-7868-b2f4376cecd9@pengutronix.de>
Date:   Mon, 25 Nov 2019 12:09:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CA+h21ho9bJsaq8e-gRhRpM+kXARNJ6tyL10vKVf2+7YOtaJGXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:13da
X-SA-Exim-Mail-From: o.rempel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.11.19 11:39, Vladimir Oltean wrote:
> On Mon, 25 Nov 2019 at 12:32, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>> On 25.11.19 11:22, Vladimir Oltean wrote:
>>> On Mon, 25 Nov 2019 at 12:03, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>>>>
>>>> Currently we will get "Probed switch chip" notification multiple times
>>>> if first probe filed by some reason. To avoid this confusing notifications move
>>>> dev_info to the end of probe.
>>>>
>>>> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
>>>> ---
>>>
>>> Also there are some typos which should be corrected:
>>> probet -> probed
>>> every thing -> everything
>>> filed -> failed
>>>
>>> "failed for some reason" -> "was deferred"
>>
>> Ok, thx.
>>
>> should i resend both patches separately or only this one with spell fixes?
>>
> 
> I don't know if David/Jakub like applying partial series (just 2/2). I
> would send a v2 to each patch specifying the tree clearly.
> Also I think I would just move the "Probed...." message somewhere at
> the beginning of sja1105_setup, where no probe deferral can happen.

Ok, I'll drop the second patch by now, currently it is not critical issue for me.

Kind regards,
Oleksij Rempel

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
