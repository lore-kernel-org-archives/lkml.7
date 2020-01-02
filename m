Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8451C2D0DE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 01:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9418C24649
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 01:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgABBog convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 20:44:36 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:39033 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725895AbgABBog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 20:44:36 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TmWlbqJ_1577929467;
Received: from 127.0.0.1(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0TmWlbqJ_1577929467)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Jan 2020 09:44:32 +0800
Content-Type: text/plain;
        charset=gb2312
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RFC] memcg: Add swappiness to cgroup2
From:   teawater <teawaterz@linux.alibaba.com>
In-Reply-To: <20191231151621.8f1565ef8736233dbf60bca7@linux-foundation.org>
Date:   Thu, 2 Jan 2020 09:44:25 +0800
Cc:     Hui Zhu <teawater@gmail.com>, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Content-Transfer-Encoding: 8BIT
Message-Id: <DC612002-1238-4B8D-B9FA-E4197D995099@linux.alibaba.com>
References: <1577252208-32419-1-git-send-email-teawater@gmail.com>
 <20191231151621.8f1565ef8736233dbf60bca7@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 在 2020年1月1日，07:16，Andrew Morton <akpm@linux-foundation.org> 写道：
> 
> On Wed, 25 Dec 2019 13:36:48 +0800 Hui Zhu <teawater@gmail.com> wrote:
> 
>> Even if cgroup2 has swap.max, swappiness is still a very useful config.
>> This commit add swappiness to cgroup2.
>> 
>> ...
>> 
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -7143,6 +7143,11 @@ static struct cftype swap_files[] = {
>> 		.file_offset = offsetof(struct mem_cgroup, swap_events_file),
>> 		.seq_show = swap_events_show,
>> 	},
>> +	{
>> +		.name = "swappiness",
>> +		.read_u64 = mem_cgroup_swappiness_read,
>> +		.write_u64 = mem_cgroup_swappiness_write,
>> +	},
>> 	{ }	/* terminate */
>> };
> 
> There should be a Documentation/ update with this?
> 

Hi Andrew,

I will post a new version with Documentation/ update.

Thanks,
Hui

> 
> 



