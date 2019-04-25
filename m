Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719FEC10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 01:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C7520652
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 01:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388157AbfDYBls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 21:41:48 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7250 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387460AbfDYBlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 21:41:47 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 52953A8057D19D74EFD0;
        Thu, 25 Apr 2019 09:41:45 +0800 (CST)
Received: from [127.0.0.1] (10.184.189.20) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Thu, 25 Apr 2019
 09:41:35 +0800
Subject: Re: [PATCH] net: vrf: Fix operation not supported when set vrf mac
To:     David Miller <davem@davemloft.net>
CC:     <dsa@cumulusnetworks.com>, <shrijeet@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mingfangsen@huawei.com>
References: <4e8a50df-bf96-3ef7-2977-71495d80643c@huawei.com>
 <20190424.114545.1491189947661702492.davem@davemloft.net>
From:   linmiaohe <linmiaohe@huawei.com>
Message-ID: <a91ac133-c3c0-f791-198d-9a22523b8f81@huawei.com>
Date:   Thu, 25 Apr 2019 09:41:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190424.114545.1491189947661702492.davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.189.20]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/4/25 2:45, David Miller wrote:
> From: linmiaohe <linmiaohe@huawei.com>
> Date: Sat, 20 Apr 2019 12:09:39 +0800
> 
>> From: Miaohe Lin <linmiaohe@huawei.com>
>>
>> Vrf device is not able to change mac address now because lack of
>> ndo_set_mac_address. Complete this in case some apps need to do
>> this.
>>
>> Reported-by: Hui Wang <wanghui104@huawei.com>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> It seems useless, but this change is pretty much harmless so I'll
> apply it.
> 
> Thanks.
> 
> .
> 

That's very nice of you. Thanks a lot.

