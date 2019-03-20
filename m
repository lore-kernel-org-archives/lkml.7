Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A28BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 07:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129B52146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 07:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfCTHwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 03:52:19 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5153 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725942AbfCTHwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 03:52:18 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 41E4C13E8AA34DC178BC;
        Wed, 20 Mar 2019 15:52:16 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Wed, 20 Mar 2019
 15:52:12 +0800
Subject: Re: [Intel-wired-lan] [PATCH net-next] igc: Make
 igc_write_rss_indir_tbl static
To:     "Neftin, Sasha" <sasha.neftin@intel.com>, <davem@davemloft.net>,
        <jeffrey.t.kirsher@intel.com>
References: <20190319145507.22388-1-yuehaibing@huawei.com>
 <92371ea1-e9d7-e0b1-1c7a-a374f3c68681@intel.com>
CC:     <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
        <linux-kernel@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <84a273b4-a971-7835-1d79-4cad3fb4733a@huawei.com>
Date:   Wed, 20 Mar 2019 15:52:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <92371ea1-e9d7-e0b1-1c7a-a374f3c68681@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/3/20 15:07, Neftin, Sasha wrote:
> On 3/19/2019 16:55, Yue Haibing wrote:
>> From: YueHaibing <yuehaibing@huawei.com>
>>
>> Fix sparse warning:
>>
>> drivers/net/ethernet/intel/igc/igc_ethtool.c:646:6:
>>   warning: symbol 'igc_write_rss_indir_tbl' was not declared. Should it be static?
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>   drivers/net/ethernet/intel/igc/igc_ethtool.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> index eff37a6..5442394 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> @@ -643,7 +643,7 @@ static int igc_set_coalesce(struct net_device *netdev,
>>       return 0;
>>   }
>>   -void igc_write_rss_indir_tbl(struct igc_adapter *adapter)
>> +static void igc_write_rss_indir_tbl(struct igc_adapter *adapter)
>>   {
>>       struct igc_hw *hw = &adapter->hw;
>>       u32 reg = IGC_RETA(0);
>>
> The 'igc_write_rss_indir_tbl' method is declared in igc.h and used in igc_main.c
> Please, refer to latest Jeff next-queue, there is latest patches used these methods.

Well, I did not refer to Jeff's tree. So this patch can be dropped.

Thanks!

> 
> .
> 

