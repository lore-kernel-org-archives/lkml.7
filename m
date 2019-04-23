Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C169C282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F3B20811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfDWJg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:36:29 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:47987 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726150AbfDWJg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:36:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TQ1gYRd_1556012185;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0TQ1gYRd_1556012185)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Apr 2019 17:36:26 +0800
Subject: Re: [RFC PATCH 2/5] numa: append per-node execution info in
 memory.numa_stat
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <209d247e-c1b2-3235-2722-dd7c1f896483@linux.alibaba.com>
 <7be82809-79d3-f6a1-dfe8-dd14d2b35219@linux.alibaba.com>
 <20190423085248.GE11158@hirez.programming.kicks-ass.net>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Message-ID: <8c3ad96d-7f3d-d966-6acc-8327023ae3f9@linux.alibaba.com>
Date:   Tue, 23 Apr 2019 17:36:25 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423085248.GE11158@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/4/23 下午4:52, Peter Zijlstra wrote:
> On Mon, Apr 22, 2019 at 10:12:20AM +0800, 王贇 wrote:
>> This patch introduced numa execution information, to imply the numa
>> efficiency.
>>
>> By doing 'cat /sys/fs/cgroup/memory/CGROUP_PATH/memory.numa_stat', we
>> see new output line heading with 'exectime', like:
>>
>>   exectime 24399843 27865444
>>
>> which means the tasks of this cgroup executed 24399843 ticks on node 0,
>> and 27865444 ticks on node 1.
> 
> I think we stopped reporting time in HZ to userspace a long long time
> ago. Please don't do that.

Ah I see, let's make it us maybe?

Regards,
Michael Wang

> 
