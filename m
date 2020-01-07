Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4D7C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 07:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E2C2075A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 07:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgAGHW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 02:22:59 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:47778 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725781AbgAGHW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 02:22:59 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=shile.zhang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Tn4AQGD_1578381775;
Received: from ali-6c96cfdd1403.local(mailfrom:shile.zhang@linux.alibaba.com fp:SMTPD_---0Tn4AQGD_1578381775)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 07 Jan 2020 15:22:55 +0800
Subject: Re: linux-next: build warning after merge of the tip tree
To:     Ingo Molnar <mingo@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200107164317.51190747@canb.auug.org.au>
 <20200107071604.GA45744@gmail.com>
From:   Shile Zhang <shile.zhang@linux.alibaba.com>
Message-ID: <399f0d7d-ffbd-3226-6b6b-8bb7daef2051@linux.alibaba.com>
Date:   Tue, 7 Jan 2020 15:22:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200107071604.GA45744@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/1/7 15:16, Ingo Molnar wrote:
> * Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
>> Hi all,
>>
>> [This has been happening for a while, I just missed it :-( ]
>>
>> After merging the tip tree, today's linux-next build (x86_64 allnoconfig)
>> produced this warning:
>>
>> arch/x86/kernel/unwind_orc.c:210:12: warning: 'orc_sort_cmp' defined but not used [-Wunused-function]
>>    210 | static int orc_sort_cmp(const void *_a, const void *_b)
>>        |            ^~~~~~~~~~~~
>> arch/x86/kernel/unwind_orc.c:190:13: warning: 'orc_sort_swap' defined but not used [-Wunused-function]
>>    190 | static void orc_sort_swap(void *_a, void *_b, int size)
>>        |             ^~~~~~~~~~~~~
>>
>> Introduced by commit
>>
>>    f14bf6a350df ("x86/unwind/orc: Remove boot-time ORC unwind tables sorting")
> Now fixed via:
>
>    22a7fa8848c5: ("x86/unwind/orc: Fix !CONFIG_MODULES build warning")
>
> Will push it out after some testing, should go out with the next
> tip:auto-latest version.
Thanks very much! sorry for trouble.
>
> Thanks,
>
> 	Ingo

