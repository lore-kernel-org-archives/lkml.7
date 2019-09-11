Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88989C5AE59
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 02:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA9521928
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 02:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfIKCBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 22:01:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2262 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726373AbfIKCBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 22:01:50 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 59DD6C4D5169DFFF799A;
        Wed, 11 Sep 2019 10:01:48 +0800 (CST)
Received: from [127.0.0.1] (10.74.149.191) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Wed, 11 Sep 2019
 10:01:39 +0800
Subject: Re: [PATCH net-next 1/7] net: hns3: add ethtool_ops.set_channels
 support for HNS3 VF driver
To:     David Miller <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <jakub.kicinski@netronome.com>,
        <huangguangbin2@huawei.com>
References: <1568105908-60983-1-git-send-email-tanhuazhong@huawei.com>
 <1568105908-60983-2-git-send-email-tanhuazhong@huawei.com>
 <20190910.192516.1686418457520996592.davem@davemloft.net>
From:   tanhuazhong <tanhuazhong@huawei.com>
Message-ID: <5d8e9ec1-87ad-33df-8530-67dbebd62839@huawei.com>
Date:   Wed, 11 Sep 2019 10:01:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190910.192516.1686418457520996592.davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.149.191]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/9/11 1:25, David Miller wrote:
> From: Huazhong Tan <tanhuazhong@huawei.com>
> Date: Tue, 10 Sep 2019 16:58:22 +0800
> 
>> +	/* Set to user value, no larger than max_rss_size. */
>> +	if (kinfo->req_rss_size != kinfo->rss_size && kinfo->req_rss_size &&
>> +	    kinfo->req_rss_size <= max_rss_size) {
>> +		dev_info(&hdev->pdev->dev, "rss changes from %u to %u\n",
>> +			 kinfo->rss_size, kinfo->req_rss_size);
>> +		kinfo->rss_size = kinfo->req_rss_size;
> 
> Please do not emit kernel log messages for normal operations.
> 

Will remove this log in V2.
Thanks.

> .
> 

