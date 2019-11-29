Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6200CC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 12:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD9521721
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 12:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfK2M4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 07:56:11 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:55414 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726360AbfK2M4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 07:56:10 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C24F827C4B2A90F57078;
        Fri, 29 Nov 2019 20:56:05 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.137) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Fri, 29 Nov 2019
 20:56:01 +0800
Subject: Re: [PATCH 0/4] part2: kill pr_warning from kernel
To:     Petr Mladek <pmladek@suse.com>
CC:     <joe@perches.com>, <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <tj@kernel.org>, <arnd@arndb.de>,
        <sergey.senozhatsky@gmail.com>, <rostedt@goodmis.org>
References: <20191128004752.35268-1-wangkefeng.wang@huawei.com>
 <20191129115837.7hzuyqlmhbqsi4zm@pathway.suse.cz>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <e32f48b2-2286-912f-b8e2-1b1bcd892e07@huawei.com>
Date:   Fri, 29 Nov 2019 20:56:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20191129115837.7hzuyqlmhbqsi4zm@pathway.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.217.137]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/11/29 19:58, Petr Mladek wrote:
> On Thu 2019-11-28 08:47:48, Kefeng Wang wrote:
>> This is the part2 of kill pr_warning, as most pr_warning conversion merged
>> into v5.5, let's cleanup the last two stragglers. Then, completely drop
>> pr_warning defination in printk.h and check in checkpatch.pl.
>>
>> Part1: https://lore.kernel.org/lkml/20190920062544.180997-1-wangkefeng.wang@huawei.com
>>
>> Kefeng Wang (4):
>>   workqueue: Use pr_warn instead of pr_warning
>>   staging: isdn: gigaset: Use pr_warn instead of pr_warning
> 
> This one is already in mainline via staging tree.
> 
>>   printk: Drop pr_warning definition
>>   checkpatch: Drop pr_warning check
> 
> The other patches are committed in printk.git, branch
> for-5.5-pr-warning-removal.
> 
> I am going to sent pull request after 5.5-rc1 is tagged.
> It is should be fine according to linux-next. But I am not
> sure if all coming changes are really tested in linux-next.
> 
Hi Petr, thanks, the issue will always be there, so let's remove
the definition ASAP, and we can fix the follow-up possible use :)


> Best Regards,
> Petr
> 
> .
> 

