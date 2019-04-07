Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E23C282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 02:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF8F20B1F
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 02:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfDGCa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 22:30:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6261 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726245AbfDGCa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 22:30:27 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9A2C416ABB87A248A66F;
        Sun,  7 Apr 2019 10:30:24 +0800 (CST)
Received: from [127.0.0.1] (10.184.189.20) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Sun, 7 Apr 2019
 10:30:14 +0800
Subject: Re: [PATCH net] net: vrf: Fix ping failed when vrf mtu is set to 0
To:     David Miller <davem@davemloft.net>, <dsa@cumulusnetworks.com>
CC:     <shrijeet@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mingfangsen@huawei.com>
References: <0da12059-229f-e167-ad41-14b56993a029@huawei.com>
 <20190406.181232.473436529978209156.davem@davemloft.net>
From:   linmiaohe <linmiaohe@huawei.com>
Message-ID: <b8af36bf-a2c7-91f7-eed4-eb802523655e@huawei.com>
Date:   Sun, 7 Apr 2019 10:29:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190406.181232.473436529978209156.davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.189.20]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/4/7 9:12, David Miller wrote:
> From: linmiaohe <linmiaohe@huawei.com>
> Date: Thu, 4 Apr 2019 20:01:13 +0800
> 
>> From: Miaohe Lin <linmiaohe@huawei.com>
>>
>> When the mtu of a vrf device is set to 0, it would cause ping
>> failed.So I think we should limit dev->min_mtu to ETH_MIN_MTU
>> to solve this problem. And if dev->max_mtu still be 0 can be
>> confusing, so I limit dev->max_mtu to ETH_MAX_MTU.
>>
>> Here is the reproduce step:
> 
> Just in case it isn't clear, David Ahern gave you feedback and
> asked you to adjust things so that the problem is solved for ipv6
> as well.  He also gave you an appropriate Fixes: tag to add to
> your commit message.
> 
> .
> 

I'am sorry, I'am on my holiday, so I found these emalis just now.
I will adjust things in v2 so that this patch will solve for ipv6 as well.
And add an appropriate fixes to my commit message.
Thank you very much.

