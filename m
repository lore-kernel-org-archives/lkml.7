Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B41FA3728
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 00:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A769B20659
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 00:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404114AbfJQA4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 20:56:32 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50590 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726521AbfJQA4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 20:56:32 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E9824814F5D5CF5B9A39;
        Thu, 17 Oct 2019 08:56:30 +0800 (CST)
Received: from [127.0.0.1] (10.74.149.191) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Thu, 17 Oct 2019
 08:56:22 +0800
Subject: Re: [PATCH net-next 00/12] net: hns3: add some bugfixes and
 optimizations
To:     David Miller <davem@davemloft.net>, <jakub.kicinski@netronome.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>
References: <1571210231-29154-1-git-send-email-tanhuazhong@huawei.com>
 <20191016101943.415d73cf@cakuba.netronome.com>
 <20191016.135003.672960397161023411.davem@davemloft.net>
From:   tanhuazhong <tanhuazhong@huawei.com>
Message-ID: <c21c51ee-428a-4cd6-38ac-4b9279d42fcd@huawei.com>
Date:   Thu, 17 Oct 2019 08:56:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20191016.135003.672960397161023411.davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.149.191]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/10/17 1:50, David Miller wrote:
> From: Jakub Kicinski <jakub.kicinski@netronome.com>
> Date: Wed, 16 Oct 2019 10:19:43 -0700
> 
>> On Wed, 16 Oct 2019 15:16:59 +0800, Huazhong Tan wrote:
>>> This patch-set includes some bugfixes and code optimizations
>>> for the HNS3 ethernet controller driver.
>>
>> The code LGTM, mostly, but it certainly seems like patches 2, 3 and 4
>> should be a separate series targeting the net tree :(
> 
> Agreed, there are legitimate bug fixes.
> 
> I have to say that I see this happening a lot, hns3 bug fixes targetting
> net-next in a larger series of cleanups and other kinds of changes.
> 
> Please handle this delegation properly.  Send bug fixes as a series targetting
> 'net', and send everything else targetting 'net-next'.
> 

ok, thanks.

> .
> 

