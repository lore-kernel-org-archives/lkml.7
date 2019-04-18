Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F3AC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CEC7206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389333AbfDRO0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:26:38 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52728 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389121AbfDRO0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:26:38 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DAFEFFD6066CB0753C8F;
        Thu, 18 Apr 2019 22:26:22 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.408.0; Thu, 18 Apr 2019
 22:26:19 +0800
Subject: Re: [PATCH v2 -next] sched/core: Make some functions static
To:     Ingo Molnar <mingo@kernel.org>
References: <20190322143153.14416-1-yuehaibing@huawei.com>
 <20190418132937.36324-1-yuehaibing@huawei.com>
 <20190418134031.GA59073@gmail.com>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <5f7e511a-bd78-e442-1252-2e46c0224960@huawei.com>
Date:   Thu, 18 Apr 2019 22:26:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190418134031.GA59073@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/18 21:40, Ingo Molnar wrote:
> 
> * Yue Haibing <yuehaibing@huawei.com> wrote:
> 
>> From: YueHaibing <yuehaibing@huawei.com>
>>
>> Fix sparse warnings:
>>
>> kernel/sched/core.c:6524:11: warning: symbol 'min_cfs_quota_period' was not declared. Should it be static?
>> kernel/sched/core.c:6604:5: warning: symbol 'tg_set_cfs_quota' was not declared. Should it be static?
>> kernel/sched/core.c:6617:6: warning: symbol 'tg_get_cfs_quota' was not declared. Should it be static?
>> kernel/sched/core.c:6630:5: warning: symbol 'tg_set_cfs_period' was not declared. Should it be static?
>> kernel/sched/core.c:6640:6: warning: symbol 'tg_get_cfs_period' was not declared. Should it be static?
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Could you please also use the updated commit message I edited for v1, 
> instead of just reverting to the old one?

Sorry, I do not notice that, fix it now.

> 
> Thanks,
> 
> 	Ingo
> 
> 

