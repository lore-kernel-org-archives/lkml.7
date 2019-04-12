Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC77C10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 02:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD9F92083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 02:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfDLCa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 22:30:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6731 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726666AbfDLCa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 22:30:56 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B40EE5DEE7696B49EF9B;
        Fri, 12 Apr 2019 10:30:48 +0800 (CST)
Received: from [127.0.0.1] (10.74.149.191) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Fri, 12 Apr 2019
 10:30:40 +0800
Subject: Re: [PATCH net-next 01/12] net: hns3: fix VLAN initialization to be
 compatible with port base insert VLAN
To:     David Miller <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <linuxarm@huawei.com>, <shenjian15@huawei.com>
References: <1554985531-1827-1-git-send-email-tanhuazhong@huawei.com>
 <1554985531-1827-2-git-send-email-tanhuazhong@huawei.com>
 <20190411.112025.1323996172119715001.davem@davemloft.net>
From:   tanhuazhong <tanhuazhong@huawei.com>
Message-ID: <0a650f2c-7988-5ff3-68ad-909005fc50c9@huawei.com>
Date:   Fri, 12 Apr 2019 10:30:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190411.112025.1323996172119715001.davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.149.191]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/4/12 2:20, David Miller wrote:
> From: Huazhong Tan <tanhuazhong@huawei.com>
> Date: Thu, 11 Apr 2019 20:25:20 +0800
> 
>> From: Jian Shen <shenjian15@huawei.com>
>>
>> This patch fixes VLAN initialization, in order to be compatible
>> with VLAN inserted base on port.
> 
> This doesn't mean anything to me.
> 
> Why was normal VLAN initialization different, and how is the behavior
> of VLAN's configured when inserted based upon port different and why
> is it better?
> 
> You have to improve your commit log messages so that someone not
> intimately familiar with your driver and code can understand what you
> are doing and why.
> 

Sorry, I will describe it in detail.

Our hardware supports insert a specified vlan header for each function 
when send packets. User can enable it with command "ip link set 
<devname> vf  <vfid> vlan <vlan id>".  For this vlan header is inserted 
by hardware, not from stack,  hardware also needs to strip it from 
received packet before upstreaming to stack.  In this case, driver needs 
to tell hardware which vlan to insert or strip.

Thanks.

> .
> 

