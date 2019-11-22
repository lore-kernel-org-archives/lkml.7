Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E34CC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 18:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7172071B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 18:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfKVSCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 13:02:11 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39320 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfKVSCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 13:02:10 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id ADF6528AE8C
Subject: Re: net-next/master bisection: boot on beaglebone-black
To:     David Miller <davem@davemloft.net>
Cc:     hulkci@huawei.com, tomeu.vizoso@collabora.com, broonie@kernel.org,
        khilman@baylibre.com, mgalka@collabora.com,
        enric.balletbo@collabora.com, yuehaibing@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com
References: <5dd7d181.1c69fb81.64fbc.cd8a@mx.google.com>
 <20191122.093657.95680289541075120.davem@davemloft.net>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <bfe5e987-e0b5-6c89-f193-6666be203532@collabora.com>
Date:   Fri, 22 Nov 2019 18:02:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191122.093657.95680289541075120.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2019 17:36, David Miller wrote:
> From: "kernelci.org bot" <bot@kernelci.org>
> Date: Fri, 22 Nov 2019 04:16:01 -0800 (PST)
> 
>>     mdio_bus: Fix PTR_ERR applied after initialization to constant
>>     
>>     Fix coccinelle warning:
>>     
>>     ./drivers/net/phy/mdio_bus.c:67:5-12: ERROR: PTR_ERR applied after initialization to constant on line 62
>>     ./drivers/net/phy/mdio_bus.c:68:5-12: ERROR: PTR_ERR applied after initialization to constant on line 62
> 
> The kernelci.org bot has posted at least a half dozen of these bisection
> results for the same exact bug, which we've fixed two days ago....
> 
> This is becomming more like spam and not very useful....

As far as I can tell, it's the first time someone replies to say
this issue is already fixed.  Sorry if I've missed an email.

Also, it's apparently not fixed in the net-next tree which
explains why it was reported again.  I guess we need to disable
bisections in net-next until it gets rebased and includes the
fix, and add a way to mark issues fixed somewhere else in
KernelCI to avoid this situation in the future.

Thanks,
Guillaume
