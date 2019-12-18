Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED83C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 01:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5BF21775
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 01:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfLRB4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 20:56:39 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7701 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726167AbfLRB4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 20:56:39 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C3CF5B2E1C3F523A1ADA;
        Wed, 18 Dec 2019 09:56:35 +0800 (CST)
Received: from [127.0.0.1] (10.67.103.228) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Wed, 18 Dec 2019
 09:56:28 +0800
Subject: Re: [PATCH] net: hisilicon: Fix a BUG trigered by wrong bytes_compl
To:     David Miller <davem@davemloft.net>
References: <1576308182-121147-1-git-send-email-xiaojiangfeng@huawei.com>
 <20191217.134228.92517242104749153.davem@davemloft.net>
 <161c304b-46bd-0340-e0e3-3fb8b5a7cd5e@huawei.com>
CC:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <leeyou.li@huawei.com>, <nixiaoming@huawei.com>
From:   Jiangfeng Xiao <xiaojiangfeng@huawei.com>
Message-ID: <825f153c-be8b-6d43-1235-85b3cc353f74@huawei.com>
Date:   Wed, 18 Dec 2019 09:56:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <161c304b-46bd-0340-e0e3-3fb8b5a7cd5e@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.228]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/12/18 9:40, Jiangfeng Xiao wrote:
> 
> 
> On 2019/12/18 5:42, David Miller wrote:
>> From: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
>> Date: Sat, 14 Dec 2019 15:23:02 +0800
>>
>>> In addition, I adjusted the position of "count++;"
>>> to make the code more readable.
>>
>> This is an unrelated cleanup and should not be done in the same change
>> as your bug fix, submit this if you like for net-next after net has next
>> been merged into net-next.
>>
I'm so sorry. I didn't notice this issue in v2. Please ignore my v2. I will fix this issue in v3.

