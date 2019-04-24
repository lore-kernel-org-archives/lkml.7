Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD3FC10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8635A2148D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 01:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbfDXBs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 21:48:28 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48910 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729009AbfDXBs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 21:48:28 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3DC2D241662F0C6BE04A;
        Wed, 24 Apr 2019 09:48:25 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Wed, 24 Apr 2019
 09:48:21 +0800
Subject: Re: [PATCH] powerpc/pseries: Use correct event modifier in
 rtas_parse_epow_errlog()
To:     Russell Currey <ruscur@russell.cc>, <paulus@samba.org>,
        <mpe@ellerman.id.au>, <mahesh@linux.vnet.ibm.com>,
        <npiggin@gmail.com>, <ganeshgr@linux.ibm.com>, <anton@samba.org>
References: <20190423143533.26952-1-yuehaibing@huawei.com>
 <1b208e33c4f51630e2a336e95f25509fe7286e34.camel@russell.cc>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <9b540ba8-9711-f4a2-b4bc-d35a05fd3dda@huawei.com>
Date:   Wed, 24 Apr 2019 09:48:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1b208e33c4f51630e2a336e95f25509fe7286e34.camel@russell.cc>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/4/24 9:29, Russell Currey wrote:
> On Tue, 2019-04-23 at 22:35 +0800, Yue Haibing wrote:
>> From: YueHaibing <yuehaibing@huawei.com>
>>
>> rtas_parse_epow_errlog() should pass 'modifier' to
>> handle_system_shutdown, because event modifier only use
>> bottom 4 bits.
>>
>> Fixes: 55fc0c561742 ("powerpc/pseries: Parse and handle EPOW
>> interrupts")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Hello,
> 
> This fails to compile.
> 
> arch/powerpc/platforms/pseries/ras.c: In function
> 'rtas_parse_epow_errlog':
> arch/powerpc/platforms/pseries/ras.c:288:26: error: 'event_modifier'
> undeclared (first use in this function); did you mean 'modifier'?
>    handle_system_shutdown(event_modifier);
>                           ^~~~~~~~~~~~~~
>                           modifier

Yes, this should be 'modifier'

> 
> So yes, I assume you meant "modifier" instead of "event_modifier" as
> mentioned in your commit message.  Did you compile this before sending?

I am very sorry for this, this is not my compiled version,
I forgot to check again before sending.

> 
> (found by snowpatch)
> 
> - Russell
> 
> 
> .
> 

