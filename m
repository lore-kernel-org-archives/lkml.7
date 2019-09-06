Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48FEC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 01:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A12CE20820
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 01:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391888AbfIFBZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 21:25:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59696 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389245AbfIFBZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 21:25:35 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D84102FD553F59EA768F;
        Fri,  6 Sep 2019 09:25:33 +0800 (CST)
Received: from [127.0.0.1] (10.74.221.148) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Fri, 6 Sep 2019
 09:25:26 +0800
Subject: Re: [PATCH] Revert "net: get rid of an signed integer overflow in
 ip_idents_reserve()"
To:     Eric Dumazet <eric.dumazet@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1564132635-57634-1-git-send-email-zhangshaokun@hisilicon.com>
 <afa992f6-eb5e-8104-9a03-f992b184a6b6@gmail.com>
CC:     Yang Guo <guoyang2@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jiri Pirko <jiri@resnulli.us>
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <c308f1a8-59b5-fb74-4879-e6f89c4a814a@hisilicon.com>
Date:   Fri, 6 Sep 2019 09:25:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <afa992f6-eb5e-8104-9a03-f992b184a6b6@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.221.148]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 2019/7/26 17:58, Eric Dumazet wrote:
> 
> 
> On 7/26/19 11:17 AM, Shaokun Zhang wrote:
>> From: Yang Guo <guoyang2@huawei.com>
>>
>> There is an significant performance regression with the following
>> commit-id <adb03115f459>
>> ("net: get rid of an signed integer overflow in ip_idents_reserve()").
>>
>>
> 
> So, you jump around and took ownership of this issue, while some of us
> are already working on it ?
> 

Any update about this issue?

Thanks,
Shaokun

> Have you first checked that current UBSAN versions will not complain anymore ?
> 
> A revert adding back the original issue would be silly, performance of
> benchmarks is nice but secondary.
> 
> 
> 

