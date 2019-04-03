Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C43C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2063C2084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfDCJwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:52:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6226 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725857AbfDCJwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:52:22 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [10.3.19.205])
        by Forcepoint Email with ESMTP id 14EC4BEDF61515847D92;
        Wed,  3 Apr 2019 17:52:20 +0800 (CST)
Received: from [127.0.0.1] (10.74.149.191) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Wed, 3 Apr 2019
 17:52:14 +0800
Subject: Re: [PATCH net-next 01/12] net: hns3: check 1000M half for
 hns3_ethtool_ops.set_link_ksettings
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, Peng Li <lipeng321@huawei.com>
References: <1554260881-44948-1-git-send-email-tanhuazhong@huawei.com>
 <1554260881-44948-2-git-send-email-tanhuazhong@huawei.com>
 <dd51c598-c4df-f10f-91ca-2f5081bead68@cogentembedded.com>
From:   tanhuazhong <tanhuazhong@huawei.com>
Message-ID: <7fc9b12e-26b1-6f86-0c1e-d21677af4d3d@huawei.com>
Date:   Wed, 3 Apr 2019 17:52:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <dd51c598-c4df-f10f-91ca-2f5081bead68@cogentembedded.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.149.191]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/4/3 17:12, Sergei Shtylyov wrote:
> Hello!
> 
> On 03.04.2019 6:07, Huazhong Tan wrote:
> 
>> From: Peng Li <lipeng321@huawei.com>
>>
>> Hip08 SOC does not support 1000M half, this patch adds 1000M half
>> check for hns3_ethtool_ops.set_link_ksettings, so the user can not
>> set 1000M half by ethtool.
>>
>> Signed-off-by: Peng Li <lipeng321@huawei.com>
>> Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
>> ---
>>   drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c 
>> b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
>> index 359d473..0c05807 100644
>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
>> @@ -648,6 +648,10 @@ static int hns3_get_link_ksettings(struct 
>> net_device *netdev,
>>   static int hns3_set_link_ksettings(struct net_device *netdev,
>>                      const struct ethtool_link_ksettings *cmd)
>>   {
>> +    /* Chip don't support this mode. */
> 
>     Doesn't.
> 
> [...]
> 
> MBR, Sergei
> 

ok, thanks.

> .
> 

